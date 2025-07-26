#!/usr/bin/env python3
import os
import re
import argparse
import difflib
import time
import threading
import smtplib
import ssl
from email.message import EmailMessage
from openai import OpenAI

MAX_RETRIES = 5
RETRY_DELAY = 2

PROGRAMMING_EXTENSIONS = {
    ".py", ".js", ".ts", ".java", ".c", ".cpp", ".h", ".hpp",
    ".go", ".rs", ".rb", ".php", ".swift", ".sh", ".pl"
}


def is_programming_file(path: str) -> bool:
    return os.path.isfile(path) and os.path.splitext(path)[1] in PROGRAMMING_EXTENSIONS


def diff_ratio(a: str, b: str) -> float:
    return 1.0 - difflib.SequenceMatcher(None, a, b).ratio()


def request_with_retry(client: OpenAI, model: str, instructions: str, history: str,
                       iteration: int) -> str:
    for attempt in range(MAX_RETRIES + 1):
        start_time = time.time()
        done_event = threading.Event()

        def timer():
            while not done_event.is_set():
                print(f"[DEBUG] Iter {iteration}, try {attempt + 1}: {int(time.time() - start_time)}s")
                time.sleep(1)

        threading.Thread(target=timer, daemon=True).start()
        try:
            print(f"[DEBUG] Iter {iteration}, try {attempt + 1}: sending request")
            resp = client.responses.create(model=model, instructions=instructions, input=history)
            done_event.set()
            print(f"[DEBUG] Iter {iteration}, try {attempt + 1}: success")
            return resp.output_text
        except Exception as e:
            done_event.set()
            print(f"[ERROR] Iter {iteration}, try {attempt + 1}: {e}")
            if attempt == MAX_RETRIES:
                raise
            print(f"[DEBUG] Iter {iteration}: retrying in {RETRY_DELAY}s")
            time.sleep(RETRY_DELAY)
    raise RuntimeError("Unreachable")


def gather_input(paths):
    parts = []
    for p in paths:
        if os.path.isdir(p):
            for fname in sorted(os.listdir(p)):
                if fname.lower().endswith((".utf", ".txt")):
                    with open(os.path.join(p, fname), encoding="utf-8") as f:
                        parts.append(f.read())
        else:
            with open(p, encoding="utf-8") as f:
                parts.append(f.read())
    return "\n".join(parts)


def parse_multi_file_output(text, input_paths):
    sections = []
    marker_re = re.compile(r"(?m)^\s*(?:#|//|;|'|\-{3,})\s*file\s*:\s*(.+)$", re.I)
    matches = list(marker_re.finditer(text))
    if not matches:
        return None
    for i, m in enumerate(matches):
        start = m.end()
        end = matches[i + 1].start() if i + 1 < len(matches) else len(text)
        fname = m.group(1).strip()
        content = text[start:end].lstrip("\n")
        sections.append((fname, content))
    out_map = {}
    remaining = {os.path.basename(p): p for p in input_paths}
    for fname, content in sections:
        base = os.path.basename(fname)
        if base in remaining:
            out_map[remaining.pop(base)] = content
    return out_map if out_map else None


def write_outputs(new_text, args, programming_mode):
    if programming_mode and not args.no_direct:
        if len(args.filepaths) == 1:
            with open(args.filepaths[0], "w", encoding="utf-8") as f:
                f.write(new_text)
            print(f"[DEBUG] Updated {args.filepaths[0]}")
        else:
            out_map = parse_multi_file_output(new_text, args.filepaths)
            if out_map:
                for path, content in out_map.items():
                    with open(path, "w", encoding="utf-8") as f:
                        f.write(content)
                    print(f"[DEBUG] Updated {path}")
            else:
                print("[WARN] Could not match output to files on this iteration")


def main():
    global MAX_RETRIES, RETRY_DELAY, PROGRAMMING_EXTENSIONS

    parser = argparse.ArgumentParser(description="Iterative OpenAI generation tool.")
    parser.add_argument("--instructions", required=True, help="Path to UTF-8 instructions file")
    parser.add_argument("--filepaths", nargs="+", required=True, help="Input file(s) or dir(s) of UTF files")
    parser.add_argument("--threshold", type=float, default=0.2, help="Stop when diff ratio < threshold")
    parser.add_argument("--threshold-percent", type=float, help="Stop when diff ratio < threshold-percent / 100")
    parser.add_argument("--model", default="o3-pro", help="OpenAI model name")
    parser.add_argument("--email", help="Send progress email to this address")
    parser.add_argument("--no-direct", action="store_true", help="Never overwrite inputs directly")
    parser.add_argument("--limit", type=int, help="Max iterations")
    parser.add_argument("--max-retries", type=int, default=MAX_RETRIES, help="Max retries for OpenAI calls")
    parser.add_argument("--retry-delay", type=float, default=RETRY_DELAY, help="Seconds between retries")
    parser.add_argument("--extensions", help="Comma-separated programming extensions (overrides default)")
    parser.add_argument("--api-key", help="OpenAI API key (overrides env)")
    parser.add_argument("--debug-dir", help="Directory to write debug responses (default: debug_<base>)")
    args = parser.parse_args()

    MAX_RETRIES = args.max_retries
    RETRY_DELAY = args.retry_delay
    if args.extensions:
        PROGRAMMING_EXTENSIONS = {e if e.startswith('.') else f'.{e}' for e in args.extensions.split(',')}

    if len(args.filepaths) > 1 and not args.no_direct:
        print("[INFO] Multiple inputs detected; will attempt per-file writes")

    threshold = (args.threshold_percent / 100 if args.threshold_percent is not None else args.threshold)

    with open(args.instructions, encoding="utf-8") as ins:
        instructions = ins.read()

    if len(args.filepaths) == 1 and is_programming_file(args.filepaths[0]):
        instructions += ("\n\nIMPORTANT: Only return the complete, revised source code "
                         "file. Do not include any extra text or explanations.")

    current_text = gather_input(args.filepaths)
    history_text = current_text
    client = OpenAI(api_key=args.api_key or os.environ.get("OPENAI_API_KEY"))

    base = os.path.splitext(os.path.basename(args.filepaths[0]))[0]
    debug_dir = args.debug_dir or f"debug_{base}"
    os.makedirs(debug_dir, exist_ok=True)
    iteration = 1

    email_server = None
    email_user = None
    if args.email:
        email_user = os.environ.get("GMAIL_ADDRESS")
        email_pwd = os.environ.get("GMAIL_APP_PASSWORD")
        if email_user and email_pwd:
            try:
                email_server = smtplib.SMTP_SSL("smtp.gmail.com", 465, context=ssl.create_default_context())
                email_server.login(email_user, email_pwd)
                print("[DEBUG] Logged into Gmail SMTP")
            except Exception as e:
                print(f"[WARN] Gmail login failed: {e}")

    programming_mode = all(is_programming_file(p) for p in args.filepaths)

    while True:
        if args.limit is not None and iteration > args.limit:
            print(f"[DEBUG] Iteration limit {args.limit} reached, stopping")
            break
        try:
            new_text = request_with_retry(client, args.model, instructions, history_text, iteration)
        except Exception as e:
            print(f"[FATAL] Iter {iteration}: {e}")
            break

        dbg_path = os.path.join(debug_dir, f"{base}_iter_{iteration}.txt")
        with open(dbg_path, "w", encoding="utf-8") as df:
            df.write(new_text)
        print(f"[DEBUG] Iter {iteration}: response written to {dbg_path}")

        write_outputs(new_text, args, programming_mode)  # direct overwrite each loop

        ratio = diff_ratio(current_text, new_text)
        print(f"[DEBUG] Iter {iteration}: diff_ratio={ratio:.6f}")

        if email_server:
            try:
                msg = EmailMessage()
                msg["From"] = email_user
                msg["To"] = args.email
                msg["Subject"] = f"Iteration {iteration} completed (ratio {ratio:.6f})"
                msg.set_content(f"Response saved to {dbg_path}\n\nFirst 500 chars:\n{new_text[:500]}")
                email_server.send_message(msg)
                print("[DEBUG] Email sent")
            except Exception as e:
                print(f"[WARN] Email send failed: {e}")

        if ratio < threshold:
            print(f"[DEBUG] Iter {iteration}: threshold met, stopping")
            current_text = new_text
            break

        current_text = new_text
        history_text += "\n\n" + new_text
        iteration += 1

    if email_server:
        try:
            email_server.quit()
        except Exception:
            pass


if __name__ == "__main__":
    main()
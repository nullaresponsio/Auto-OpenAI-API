import os
import sys
import time
import argparse
import threading
import traceback
from pathlib import Path
from openai import OpenAI

model = "o3-pro"
instructions = (
    "without losing any capabilities, enhance the fuzzing, stealth, and evasion capabilities of scanner.py and provide the fully updated scanner.py file in full. Drastically enhanced fuzzing is the most important thing to improve and be as creative as you can for max effectiveness: "
)
client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY"))

parser = argparse.ArgumentParser()
parser.add_argument("--input", required=True, help="Path to a UTF-8 code file")
parser.add_argument("--replace", action="store_true", help="Also overwrite the input file with the output")
args = parser.parse_args()

in_path = Path(args.input).resolve()
if not in_path.is_file():
    print(f"Input file not found: {in_path}", file=sys.stderr)
    sys.exit(1)

try:
    with open(in_path, "r", encoding="utf-8", errors="strict") as f:
        input_text = f.read()
except UnicodeError:
    print(f"Input file is not valid UTF-8: {in_path}", file=sys.stderr)
    sys.exit(1)

out_path = in_path.with_name(in_path.stem + "_updated.utf8")

done = threading.Event()
start = time.monotonic()


def debug_timer():
    while not done.is_set():
        elapsed = time.monotonic() - start
        print(
            f"[{elapsed:.2f}s] API in progress · Model: {model} · "
            f"Instructions len: {len(instructions)} · Input len: {len(input_text)}"
        )
        time.sleep(1)


timer_thread = threading.Thread(target=debug_timer, daemon=True)
timer_thread.start()

try:
    response = client.responses.create(
        model=model,
        instructions=instructions,
        input=input_text,
    )
except Exception as e:
    done.set()
    timer_thread.join()
    elapsed = time.monotonic() - start
    print(f"API call failed after {elapsed:.2f} seconds")
    print("Error type:", type(e).__name__)
    print("Error message:", str(e))
    traceback.print_exc()
    sys.exit(1)
else:
    done.set()
    timer_thread.join()
    elapsed = time.monotonic() - start
    print(f"API call completed in {elapsed:.2f} seconds")
    print(f"Response status: {getattr(response, 'status_code', 'n/a')}")
    print("Response object:", response)

    usage = getattr(response, "usage", None)

    def print_usage(u):
        if not u:
            return
        fields = [
            "prompt_tokens",
            "completion_tokens",
            "input_tokens",
            "output_tokens",
            "request_tokens",
            "response_tokens",
            "total_tokens",
        ]
        for k in fields:
            if hasattr(u, k):
                print(f"{k.replace('_', ' ').title()}: {getattr(u, k)}")

    print_usage(usage)

    if not usage or not hasattr(usage, "total_tokens"):
        try:
            import tiktoken

            enc = tiktoken.encoding_for_model(model)
            tokens = enc.encode(input_text)
            print("Input token count (estimated):", len(tokens))
        except Exception as enc_err:
            print("Token usage info not available:", enc_err)

    output_text = getattr(response, "output_text", "")
    print("Output text:\n", output_text)

    try:
        with open(out_path, "w", encoding="utf-8") as f:
            f.write(output_text)
        print(f"Wrote: {out_path}")
    except Exception as write_err:
        print(f"Failed writing output file {out_path}: {write_err}", file=sys.stderr)
        sys.exit(1)

    if args.replace:
        try:
            with open(in_path, "w", encoding="utf-8") as f:
                f.write(output_text)
            print(f"Replaced input file with output: {in_path}")
        except Exception as replace_err:
            print(f"Failed replacing input file {in_path}: {replace_err}", file=sys.stderr)
            sys.exit(1)
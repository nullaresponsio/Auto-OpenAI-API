import os
import sys
import time
import argparse
import threading
import traceback
from pathlib import Path
from difflib import SequenceMatcher
from openai import OpenAI

model = "o3-pro"
instructions = (
    "without losing any capabilities, enhance the fuzzing, stealth, and evasion capabilities of scanner.py and provide the fully updated scanner.py file in full. Drastically enhanced fuzzing is the most important thing to improve and be as creative as you can for max effectiveness: "
)
client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY"))

parser = argparse.ArgumentParser()
parser.add_argument("--input", required=True, help="Path to a UTF-8 code file")
parser.add_argument("--replace", action="store_true", help="Overwrite input file with final output")
parser.add_argument("--replacewhile", action="store_true", help="Enable iterative improvement loop")
parser.add_argument("--diff", type=float, default=1.0, help="Minimum improvement percentage threshold to continue (default: 1.0%%)")
parser.add_argument("--max", type=int, default=5, help="Maximum iteration count (default: 5)")
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

def call_api(input_data, iteration):
    done = threading.Event()
    start = time.monotonic()
    
    def debug_timer():
        while not done.is_set():
            elapsed = time.monotonic() - start
            print(
                f"[Iter {iteration}] [{elapsed:.2f}s] API in progress · Model: {model} · "
                f"Instructions len: {len(instructions)} · Input len: {len(input_data)}"
            )
            time.sleep(1)
    
    timer_thread = threading.Thread(target=debug_timer, daemon=True)
    timer_thread.start()
    
    try:
        response = client.responses.create(
            model=model,
            instructions=instructions,
            input=input_data,
        )
        output_text = getattr(response, "output_text", "")
    except Exception as e:
        done.set()
        timer_thread.join()
        elapsed = time.monotonic() - start
        print(f"API call failed after {elapsed:.2f} seconds")
        print("Error type:", type(e).__name__)
        print("Error message:", str(e))
        traceback.print_exc()
        return None
    else:
        done.set()
        timer_thread.join()
        elapsed = time.monotonic() - start
        print(f"Iteration {iteration} completed in {elapsed:.2f} seconds")
        
        usage = getattr(response, "usage", None)
        if usage:
            print(f"Tokens: Input={getattr(usage, 'input_tokens', 'N/A')}, "
                  f"Output={getattr(usage, 'output_tokens', 'N/A')}, "
                  f"Total={getattr(usage, 'total_tokens', 'N/A')}")
        
        return output_text

def calculate_improvement(prev, current):
    if not prev or not current:
        return 100.0  # Max improvement on first iteration
    matcher = SequenceMatcher(None, prev, current)
    return (1 - matcher.ratio()) * 100

def write_output(content, path):
    try:
        with open(path, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"Wrote: {path}")
        return True
    except Exception as e:
        print(f"Error writing {path}: {str(e)}", file=sys.stderr)
        return False

# Iterative improvement loop
if args.replacewhile:
    print(f"Starting iterative improvement (max: {args.max} iterations, min improvement: {args.diff}%)")
    current_text = input_text
    iteration = 0
    last_improvement = 0.0
    
    while iteration < args.max:
        output_text = call_api(current_text, iteration)
        if output_text is None:
            print("API call failed, terminating loop")
            break
        
        # Calculate improvement percentage
        improvement = calculate_improvement(current_text, output_text)
        print(f"Improvement from iteration {iteration}: {improvement:.2f}%")
        
        # Save iteration result
        iter_path = in_path.with_name(f"{in_path.stem}_iter{iteration}.utf8")
        if not write_output(output_text, iter_path):
            break
        
        # Check termination conditions
        if iteration > 0 and improvement < args.diff:
            print(f"Improvement threshold reached ({improvement:.2f}% < {args.diff}%), terminating loop")
            break
        
        # Prepare for next iteration
        current_text = output_text
        iteration += 1
        last_improvement = improvement
    
    final_output = current_text
    print(f"Completed {iteration} iterations, final improvement: {last_improvement:.2f}%")

# Single-pass mode
else:
    final_output = call_api(input_text, 0)
    if final_output is None:
        sys.exit(1)

# Save final output
out_path = in_path.with_name(in_path.stem + "_updated.utf8")
if not write_output(final_output, out_path):
    sys.exit(1)

# Replace original file if requested
if args.replace:
    try:
        with open(in_path, "w", encoding="utf-8") as f:
            f.write(final_output)
        print(f"Replaced input file: {in_path}")
    except Exception as e:
        print(f"Error replacing {in_path}: {str(e)}", file=sys.stderr)
        sys.exit(1)

print("Processing complete")
import os
import time
import threading
import traceback
from openai import OpenAI

model = "o3-pro"
instructions = (
    "without changing or adding any structs, turn these 2 swift files into the most comprehensive and greatest physics learning files possible: "
)
client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY"))

with open("input.txt", "r") as f:
    input_text = f.read()

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

    print("Output text:\n", response.output_text)
    with open("output.txt", "w") as f:
        f.write(response.output_text)
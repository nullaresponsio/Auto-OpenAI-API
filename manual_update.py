import os
import time
from openai import OpenAI

client = OpenAI(api_key=os.environ.get("OPENAI_API_KEY"))

with open("input.txt", "r") as f:
    input_text = f.read()

start = time.monotonic()
response = client.responses.create(
    model="o3-pro",
    instructions="enhance teaching and quizzing topics as best and as comprehensively as possible: ",
    input=input_text,
)
elapsed = time.monotonic() - start

print(f"API call completed in {elapsed:.2f} seconds")
print("Response status:", getattr(response, "status_code", "n/a"))
print("Response object:", response)

# print token usage if available
usage = getattr(response, "usage", None)
if usage:
    print(f"Prompt tokens: {usage.prompt_tokens}, completion tokens: {usage.completion_tokens}, total tokens: {usage.total_tokens}")
else:
    try:
        import tiktoken
        enc = tiktoken.encoding_for_model("o3-pro")
        tokens = enc.encode(input_text)
        print("Input token count:", len(tokens))
    except:
        print("Token usage info not available")

print("Output text:\n", response.output_text)

with open("output.txt", "w") as f:
    f.write(response.output_text)
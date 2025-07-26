# Auto-OpenAI-API

# Iterative LLM Refiner (`iter-refine.py`)

A command-line tool that repeatedly sends a document (or code file) to an OpenAI model with fixed instructions, stops when changes between iterations fall below a threshold, and writes the result back to disk. It includes robust retry logic, optional per-iteration email notifications, and an iteration **limit** so runs cannot exceed a specified number.

---

## Features

- **Iterative refinement loop** with configurable diff threshold.
- **Hard stop via `--limit`** to cap the maximum number of iterations.
- **Robust retries** with per-second live progress logs.
- **Programming-aware behavior**:
  - If the input is a single programming file (by extension) and `--no-direct` is **not** set, the file is **updated in place**.
  - Otherwise, output is written to `output_<base>.txt`.
- **Directory mode**: reads all `*.utf` and `*.txt` files (sorted) and concatenates them.
- **Per-iteration debug snapshots** in `debug_<base>/`.
- **Optional Gmail email notification** after each iteration.
- **OpenAI Responses API** usage via `openai` Python SDK.

---

## Requirements

- Python 3.8+
- Packages:
  - `openai` (Python SDK)
- Environment variables:
  - `OPENAI_API_KEY` → API key for OpenAI.
  - For email (optional):
    - `GMAIL_ADDRESS` → Your Gmail address.
    - `GMAIL_APP_PASSWORD` → A Gmail App Password (recommended; not your main password).

Install dependencies:

```bash
pip install openai


⸻

Usage

./iter-refine.py INSTRUCTIONS_FILE FILEPATH [options]

	•	INSTRUCTIONS_FILE: Path to a UTF-8 text file containing the prompt/instructions for the model.
	•	FILEPATH: Path to a single input file, or a directory of .utf/.txt files.

Options

Flag	Type	Default	Description
--threshold	float	0.2	Diff stop threshold (decimal). Loop stops when diff_ratio < threshold.
--threshold-percent	float	none	Diff stop threshold as a percent (e.g., 5 for 5%). Overrides --threshold if provided.
--model	str	o3-pro	OpenAI model name used in client.responses.create.
--email	str	none	Send a summary email to this address after each iteration (requires Gmail env vars).
--no-direct	flag	off	Disable in-place editing even for a single programming file.
--limit	int	none	Hard cap on the number of iterations attempted. If 0, no iterations run.

Programming file detection is based on extension:
.py, .js, .ts, .java, .c, .cpp, .h, .hpp, .go, .rs, .rb, .php, .swift, .sh, .pl

⸻

How It Works
	1.	Load input text:
	•	If FILEPATH is a file: read its content.
	•	If FILEPATH is a directory: read and concatenate all *.utf/*.txt files (sorted).
	2.	Prepare instructions:
	•	If input is a programming file, a hint is auto-appended to request code-only responses (complete, revised source with no extra text).
	3.	Iterative loop:
	•	Send history_text (initially the current text) to the model with the given instructions.
	•	Save the model output for that iteration to debug_<base>/<base>_iter_<N>.txt.
	•	Compute diff_ratio = 1 - difflib.SequenceMatcher(...).ratio().
	•	If diff_ratio < threshold, stop; otherwise, append the new output to history_text and continue.
	•	If --limit is provided, stop before starting iteration N when N > --limit. With --limit K, at most K iterations are performed.
	4.	Write result:
	•	If input was a single programming file and --no-direct is not set: overwrite the original file with the final text.
	•	Otherwise: write to output_<base>.txt.

⸻

Diff Threshold Details
	•	diff_ratio is computed as:

1.0 - SequenceMatcher(a, b).ratio()

where a is the previous text and b is the new text.

	•	Stop condition: diff_ratio < threshold.
	•	You can specify:
	•	--threshold 0.2 (decimal), or
	•	--threshold-percent 5 (interpreted as 0.05) which overrides --threshold.

Tips:
	•	A lower threshold (e.g., 0.02) stops earlier (requires very small changes).
	•	A higher threshold (e.g., 0.5) allows larger changes per iteration before stopping.

⸻

Iteration Limit
	•	Use --limit to cap the number of iterations.
	•	The check happens at the top of the loop; with --limit K:
	•	Iterations 1..K run at most.
	•	If --limit 0, the loop exits immediately (no API calls).

Example:

./iter-refine.py rules.txt mycode.py --limit 3

Runs at most 3 iterations, regardless of threshold.

⸻

Debugging & Logs
	•	Live timing logs: Each API attempt prints elapsed seconds until success/failure.
	•	Retries:
	•	MAX_RETRIES = 5 with RETRY_DELAY = 2s between retries.
	•	The tool attempts up to 6 total tries per iteration (initial try + 5 retries).
	•	Per-iteration output files: debug_<base>/<base>_iter_<N>.txt.

⸻

Email Notifications (Optional)

If --email you@example.com is provided and Gmail env vars are set:
	•	After each iteration, an email is sent with:
	•	The iteration number and computed diff ratio.
	•	The path to the written debug file.
	•	The first 500 characters of the model output.

Setup:

export GMAIL_ADDRESS="your.name@gmail.com"
export GMAIL_APP_PASSWORD="your_app_password"  # Use a Gmail App Password

Notes:
	•	SMTP server: smtp.gmail.com:465 via SSL.
	•	If login or send fails, the tool logs a warning and continues.

⸻

Output Behavior
	•	Single programming file + not --no-direct → overwrites the file.
	•	Otherwise → writes output_<base>.txt in the current directory.
	•	Partial progress is preserved:
	•	If an iteration fails, the loop stops and the last successful text is written to output (or kept in place for in-place mode).

⸻

Examples

1) Refine a single code file in place

./iter-refine.py ./instructions.md ./src/main.py

2) Cap at 5 iterations

./iter-refine.py ./instructions.md ./src/main.py --limit 5

3) Stricter stop threshold (2%)

./iter-refine.py ./rules.txt ./draft.txt --threshold-percent 2

4) Force non-destructive output for a programming file

./iter-refine.py ./rules.txt ./src/main.py --no-direct
# writes to ./output_main.txt

5) Directory mode (concatenate *.utf and *.txt)

./iter-refine.py ./rules.txt ./inputs_dir --limit 3
# result written to ./output_inputs_dir.txt

6) Email per-iteration status

export GMAIL_ADDRESS="me@gmail.com"
export GMAIL_APP_PASSWORD="xxxx xxxx xxxx xxxx"
./iter-refine.py ./rules.txt ./draft.txt --email me@company.com

7) Use a specific model

./iter-refine.py ./rules.txt ./draft.txt --model gpt-4.1-mini

The code calls:

client.responses.create(model=..., instructions=..., input=history_text)

Ensure the chosen model supports the Responses API.

⸻

Environment & Configuration
	•	OpenAI:

export OPENAI_API_KEY="sk-..."


	•	Proxy / Extra settings: If you need to configure custom OpenAI endpoints or proxies, set them via the SDK’s supported environment variables or client options (not shown in this script).

⸻

Security & Privacy
	•	The tool sends your entire input (and cumulative history each iteration) to the selected model.
	•	Consider redacting secrets or using mock data when appropriate.
	•	For email, use a Gmail App Password (with 2FA enabled on the account).

⸻

Known Limitations
	•	Context growth: history_text grows each iteration and may approach model context limits on long runs.
	•	Diff heuristic: SequenceMatcher is content-agnostic; small logically important changes may be treated as “small diffs”.
	•	Directory mode only reads *.utf and *.txt files; other extensions are ignored.
	•	In-place writes only happen for single programming files (by extension list shown above) and only if --no-direct is not used.

⸻

Exit Behavior
	•	On unrecoverable API errors, the script logs a fatal message and stops the loop. It will still proceed to the output step with the last successful text.
	•	Non-zero exit codes are not explicitly set; integrate with CI by inspecting output logs and artifact presence.

⸻

Development Notes
	•	Retries: MAX_RETRIES = 5, RETRY_DELAY = 2s; adjust in code if needed.
	•	Debug folder naming: debug_<base> where <base> is the input file/directory basename.
	•	Email subject format: Iteration <N> completed (ratio <value>).

⸻

License

Apache


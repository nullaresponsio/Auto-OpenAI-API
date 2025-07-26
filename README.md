
<img width="1362" height="780" alt="Screenshot 2025-07-26 at 3 03 04 AM" src="https://github.com/user-attachments/assets/f8119127-5a38-43e9-92e7-c6d701c92781" />

# Iterative OpenAI Generation Tool README

> **Sample usage (quick-start)**  
> Generate iterative improvements for a single Python file using `o3-pro`, stopping when changes drop below 5 %:
>
> ```bash
> python3 iterate_ai.py \
>   --instructions prompt.txt \
>   --filepaths main.py \
>   --model o3-pro \
>   --threshold-percent 5
> ```

---

## Table of Contents
1. [Overview](#overview)  
2. [Installation](#installation)  
3. [CLI Usage](#cli-usage)  
4. [How It Works](#how-it-works)  
5. [Environment Variables](#environment-variables)  
6. [Email Notifications](#email-notifications)  
7. [Programming-Aware Mode](#programming-aware-mode)  
8. [Multi-file Workflows](#multi-file-workflows)  
9. [Debugging](#debugging)  
10. [Examples](#examples)  
11. [Limitations & Caveats](#limitations--caveats)  
12. [License](#license)

---

## Overview
This script iteratively calls the OpenAI API to refine one or more text or code files until the diff between consecutive iterations drops below a user-defined threshold.  
Typical use-cases:

* Rewriting or polishing prose
* Auto-refactoring source code
* Generating multi-file boilerplates from high-level prompts

---

## Installation
```bash
git clone https://github.com/your-org/iterate-ai.git
cd iterate-ai
python -m venv venv && source venv/bin/activate
pip install -r requirements.txt  # openai>=1.6.*, etc.


⸻

CLI Usage

python3 iterate_ai.py --instructions <file> --filepaths <path> [options]

Option	Type	Default	Description
--instructions	required	—	UTF-8 file containing the system prompt for the model.
--filepaths	required	—	One or more input files or directories. Directories are scanned for .utf/.txt.
--model	str	o3-pro	OpenAI model name.
--threshold	float	0.2	Stop when diff ratio < threshold.
--threshold-percent	float	—	Same as --threshold but expressed in %.
--limit	int	—	Maximum iterations.
--no-direct	flag	False	Never overwrite inputs; always emit output_<base>.txt.
--extensions	str	see code	Comma-separated list of programming extensions that trigger programming-aware mode.
--email	str	—	Send progress emails to this address.
--debug-dir	str	debug_<base>	Directory for raw model outputs.
--max-retries	int	5	Max OpenAI request retries.
--retry-delay	float	2	Seconds between retries.
--api-key	str	$OPENAI_API_KEY	Override environment variable.


⸻

How It Works
	1.	Gather input Concatenates all selected files (recursive for directories).
	2.	First prompt Sends the entire text plus your instructions to the model.
	3.	Diff check Computes the Levenshtein ratio between old and new text.
	4.	Loop If the ratio ≥ threshold, the new output becomes history and another request is made.
	5.	Termination Stops on ratio < threshold or --limit exceeded.
	6.	Write-back   • Single programming file → in-place.
          • Multiple files → uses --- file: <name> markers to split.
          • Otherwise emits output_<base>.txt.

⸻

Environment Variables

Variable	Purpose
OPENAI_API_KEY	Fallback API key if not supplied via --api-key.
GMAIL_ADDRESS & GMAIL_APP_PASSWORD	Needed only when --email is used.


⸻

Email Notifications

When --email you@example.com is passed and Gmail credentials are available, each iteration sends a message containing:
	•	Iteration number
	•	Diff ratio
	•	First 500 characters of the model response
	•	Path to the debug file

⸻

Programming-Aware Mode

If all --filepaths are recognized programming files:
	•	An extra instruction is appended telling the model to return only the complete revised source (no comments or prose).
	•	Single-file runs overwrite in place by default; multi-file runs are matched back via # file: foo.py / // file: markers.

⸻

Multi-file Workflows

Provide several paths:

python3 iterate_ai.py \
  --instructions app_prompt.txt \
  --filepaths src/ utils.py \
  --threshold-percent 3

The model should emit sections like:

--- file: main.py
<code here>
--- file: utils.py
<code here>

The script maps these sections back to the original files; unmatched output is dumped to output_<base>.txt.

⸻

Debugging

All raw model outputs are saved under --debug-dir (default debug_<first_file_basename>):

debug_<base>/
  ├── <base>_iter_1.txt
  ├── <base>_iter_2.txt
  └── ...

Inspect these to track how the model evolves your content.

⸻

Examples

1. Refactor a JavaScript project

python3 iterate_ai.py \
  --instructions refactor_js.txt \
  --filepaths app/ \
  --model o3-pro \
  --threshold 0.15

2. Polish documentation without overwriting originals

python3 iterate_ai.py \
  --instructions style_guide.txt \
  --filepaths docs/README.utf \
  --no-direct \
  --threshold-percent 10

3. Continuous editing with e-mail updates

python3 iterate_ai.py \
  --instructions improvements.txt \
  --filepaths report.txt \
  --email myname@example.com \
  --limit 8


⸻

Limitations & Caveats
	•	Depends on model compliance with special “only return code” instruction.
	•	Diff ratio on large binary-like outputs (minified JS etc.) may be noisy.
	•	Multi-file parsing relies on explicit file: markers—ensure your prompts instruct the model accordingly.
	•	Gmail 2-factor accounts require an app password (not your normal login).

⸻

License

Apache © 2025 Bo Shang / PDFSage Inc.


# Job Hunter Pro — Python Edition

## Multi-AI Career Command Center (Local Python/Flask App)

A complete job hunting command center that runs locally on your Mac. No cloud deployment, no Node.js, no React build tools. Just Python.

---

## Quick Start (2 minutes)

Open Terminal on your Mac and run:

```bash
cd job-hunter-pro
chmod +x run.sh
./run.sh
```

That's it. Open **http://localhost:5000** in your browser.

---

## Manual Setup (if run.sh doesn't work)

```bash
cd job-hunter-pro

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Run
python3 app.py
```

Open **http://localhost:5000**.

---

## What You Need

- **macOS** (tested on MacBook Air M1/M2/M3)
- **Python 3.9+** (check: `python3 --version`)
  - If not installed: `brew install python` or download from https://python.org
- **At least one AI API key** (see below)

---

## Project Structure

```
job-hunter-pro/
├── app.py              ← Flask backend (all API routes, AI calls, file processing)
├── templates/
│   └── index.html      ← Frontend (HTML + CSS + JavaScript, single file)
├── requirements.txt    ← Python dependencies
├── run.sh              ← One-command setup & launch
├── data.json           ← Auto-created: stores your jobs, settings, resume
├── uploads/            ← Auto-created: temporary file uploads
└── README.md           ← This file
```

---

## How It Works

```
Your Browser (http://localhost:5000)
    │
    ├── Dashboard, Tracker, Search — all rendered in a single HTML page
    │
    ├── When you upload a resume (PDF/DOCX/DOC):
    │     └── File sent to Flask server
    │     └── pdfplumber (PDF) or python-docx (DOCX) extracts text locally
    │     └── NO data leaves your machine
    │
    ├── When you click Search Jobs, Tailor Resume, etc.:
    │     └── Browser sends request to Flask server
    │     └── Flask calls the AI provider's API (Claude/GPT/Gemini)
    │     └── Result returned to browser
    │
    └── When you download a .docx:
          └── python-docx generates a real Word document on the server
          └── File downloaded to your Mac

All job data is stored in data.json — persists across restarts.
```

---

## API Keys

You need at least one. All three are optional — use whichever you prefer.

### Anthropic (Claude)
1. Go to https://console.anthropic.com/settings/keys
2. Create key → starts with `sk-ant-...`
3. Add billing at https://console.anthropic.com/settings/billing

### OpenAI (GPT)
1. Go to https://platform.openai.com/api-keys
2. Create key → starts with `sk-proj-...`
3. Add billing at https://platform.openai.com/settings/organization/billing

### Google (Gemini)
1. Go to https://aistudio.google.com/apikey
2. Create key → starts with `AIzaSy...`
3. Free tier available (limited requests per minute)

**Paste your key in the Settings tab of the app.**

---

## Features

### Dashboard
- Stats cards: Total, Saved, Applied, Interview, Offer, Rejected
- Pipeline visualization bar
- Recent jobs list
- Quick action buttons

### Job Search (with AI + Web Search)
- Search across 11 platforms: LinkedIn, Indeed, Glassdoor, ZipRecruiter, AngelList, Remote.co, We Work Remotely, Dice, SimplyHired, Hired
- AI finds real listings with direct apply links
- Auto-extracts jobs into structured cards
- One-click "Add to Tracker" per job, or "Add All"

### Resume Upload
- Drag & drop or click to browse
- Supports PDF, DOCX, DOC, TXT
- All parsing done locally with Python (pdfplumber + python-docx)
- Extracted text is editable
- Auto-saved to data.json

### AI Tools (select any tracked job)
| Tool | What It Does | Download |
|------|-------------|----------|
| Tailor Resume | Rewrites resume with ATS keywords for specific job | .docx ✓ |
| Cover Letter | Personalized cover letter for company/role | .docx ✓ |
| Elevator Pitch | Professional summary + LinkedIn headline + bio | .docx ✓ |
| Interview Prep | 10 likely questions + answer frameworks | Copy ✓ |
| Salary Research | Compensation benchmarks + negotiation scripts | Copy ✓ |
| Networking | LinkedIn templates + cold emails + follow-ups | Copy ✓ |

### Job Tracker
- Full table with all fields
- Status dropdown: Saved → Applied → Interview → Offer/Rejected
- Star/favorite jobs
- Direct apply links
- Delete jobs
- Jump to AI Tools from any row

### Export
- CSV download (all jobs)
- DOCX download (AI outputs)

---

## Key Differences from the React Version

| | React (artifact) | Python (this) |
|---|---|---|
| Setup | Zero (runs in Claude.ai) | 2 min (python + pip) |
| AI proxy limits | 1000 tokens, truncated prompts | Full 4096 tokens, no limits |
| Resume size | Truncated to ~2500 chars | Full resume (6000+ chars) |
| PDF parsing | Needs AI API call | Local with pdfplumber (free, private) |
| DOCX output | HTML-based hack | Real .docx with python-docx |
| Data persistence | Gone on refresh | Saved in data.json forever |
| File uploads | Limited by sandbox | Full support, any size |
| Model selection | Locked to one model in artifact | Any model, any provider |

---

## Configuration

### Change the port
```bash
# In app.py, last line:
app.run(debug=True, port=8080)  # change 5000 to any port
```

### Add more platforms
Edit the `PLAT_COLORS` object in `templates/index.html` and add the platform to the select options in the Add Job modal.

### Change AI prompts
Edit the `prompts` dict in the `ai_tool()` function in `app.py`. Each tool has a `(system_prompt, user_prompt, web_search)` tuple you can customize.

### Increase max tokens
In `app.py`, find `"max_tokens": 4096` in the `call_ai()` function and increase to `8192` or higher.

---

## Troubleshooting

### "python3: command not found"
Install Python: `brew install python` or download from https://python.org

### "No module named flask"
You're not in the virtual environment. Run: `source venv/bin/activate`

### "Connection refused" when clicking Search
Your API key is missing or wrong. Go to Settings tab, check the key.

### PDF text is garbled
Some PDFs with complex layouts don't extract well with pdfplumber. Try:
- Use DOCX format instead (always parses perfectly)
- Edit the extracted text manually in the textarea

### "Address already in use"
Another process is using port 5000. Either:
- Kill it: `lsof -ti:5000 | xargs kill`
- Change the port in app.py

### App is slow
AI API calls take 5-30 seconds depending on the provider and model. This is normal. The loading spinner shows while waiting.

---

## Cost Estimates

| Action | Claude Sonnet 4.6 | GPT-5.4 Mini | Gemini 2.5 Flash |
|--------|-------------------|--------------|------------------|
| Job search | ~$0.01-0.03 | ~$0.01-0.03 | Free tier |
| Resume tailor | ~$0.01 | ~$0.01 | Free tier |
| Cover letter | ~$0.01 | ~$0.01 | Free tier |
| Interview prep | ~$0.01 | ~$0.01 | Free tier |
| **Daily use** | **~$0.10-0.30** | **~$0.10-0.30** | **Free** |

---

*Run locally. Own your data. Hunt smarter.*

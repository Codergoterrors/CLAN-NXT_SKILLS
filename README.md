# 🔴 CLAN NXT Skills | Dev Stack

```
   ██████╗██╗      █████╗ ███╗   ██╗    ███╗   ██╗██╗  ██╗████████╗
  ██╔════╝██║     ██╔══██╗████╗  ██║    ████╗  ██║╚██╗██╔╝╚══██╔══╝
  ██║     ██║     ███████║██╔██╗ ██║    ██╔██╗ ██║ ╚███╔╝    ██║   
  ██║     ██║     ██╔══██║██║╚██╗██║    ██║╚██╗██║ ██╔██╗    ██║   
  ╚██████╗███████╗██║  ██║██║ ╚████║    ██║ ╚████║██╔╝ ██╗   ██║   
   ╚═════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝    ╚═╝  ╚═══╝╚═╝  ╚═╝   ╚═╝
```

One-command setup for a full AI-powered development environment.

**What this installs:**

| Tool | What it does |
|---|---|
| 🎨 **3 Design Skills** | Non-generic, polished websites (Impeccable + Taste Skill + Emil Kowalski) |
| 🔥 **FreeLLMAPI** | ~1B free tokens/month from 6 providers behind one endpoint |
| ⚡ **RTK** | Saves 60–90% of tokens by compressing CLI output |
| 🚀 **Antigravity CLI** | Google's `agy` terminal coding agent |
| 🧠 **GSD** | Get Shit Done — spec-driven, multi-agent workflow system |

Works with **Cursor**, **Codex**, and **Antigravity** — globally across every project.

---

## Prerequisites

- Windows 10/11
- [Node.js v20+](https://nodejs.org) + npm
- [Git](https://git-scm.com)
- winget (built into Windows 11; [install for Win10](https://aka.ms/getwinget))

---

## Quickstart

```powershell
# 1. Clone this repo
git clone https://github.com/Codergoterrors/CLAN-NXT_SKILLS.git
cd CLAN-NXT_SKILLS

# 2. Run the setup script
powershell -ExecutionPolicy Bypass -File setup.ps1
```

Then follow **Steps 2–6** below for the parts that need manual input.

---

## Step 1 — Run setup.ps1

The script handles automatically:
- ✅ FreeLLMAPI clone + install + `.env` setup
- ✅ RTK install via winget
- ✅ RTK init for Cursor, Codex, Gemini/Antigravity
- ✅ Antigravity CLI install
- ✅ GSD install for Antigravity (globally via `npx @opengsd/gsd-core@latest`)
- ✅ `StartFreeLLMAPI.bat` copied to Desktop

---

## Step 2 — Install Design Skills (manual, one-time)

Run each command and when prompted:
- **Agents:** press `Enter` (defaults are correct)
- **Scope:** select `Global`
- **Proceed:** select `Yes`

```powershell
npx skills add pbakaus/impeccable
npx skills add https://github.com/Leonxlnx/taste-skill --skill "design-taste-frontend"
npx skills add emilkowalski/skill
```

---

## Step 3 — Add Free Provider API Keys

1. Double-click `StartFreeLLMAPI.bat` on your Desktop
2. Open [http://localhost:5173/keys](http://localhost:5173/keys)
3. Add keys from each provider (all free, no credit card):

| Provider | Get key at |
|---|---|
| Groq | [console.groq.com/keys](https://console.groq.com/keys) |
| Google | [aistudio.google.com/apikey](https://aistudio.google.com/apikey) |
| Mistral | [console.mistral.ai/api-keys](https://console.mistral.ai/api-keys) |
| GitHub Models | [github.com/settings/tokens](https://github.com/settings/tokens) (classic token) |
| Cohere | [dashboard.cohere.com/api-keys](https://dashboard.cohere.com/api-keys) |
| Cloudflare | [dash.cloudflare.com/profile/api-tokens](https://dash.cloudflare.com/profile/api-tokens) (Workers AI + Read) — also need Account ID from your dashboard URL |

---

## Step 4 — Set Environment Variables

After adding keys, copy your unified API key from the Keys page and run:

```powershell
[System.Environment]::SetEnvironmentVariable("OPENAI_API_KEY", "freellmapi-YOUR-KEY-HERE", "User")
[System.Environment]::SetEnvironmentVariable("OPENAI_BASE_URL", "http://localhost:3001/v1", "User")
```

Then set it in **Cursor** too:
- Open Cursor → `Ctrl+Shift+J` → Models → set API Key + Base URL

---

## Step 5 — Authenticate Antigravity

```powershell
agy auth
```

Opens browser for Google Sign-In. Complete it and you're done.

---

## Step 6 — Restart Terminal

Close all terminals and open a fresh one. Verify:

```powershell
echo $env:OPENAI_API_KEY    # should show freellmapi-xxx
echo $env:OPENAI_BASE_URL   # should show http://localhost:3001/v1
rtk gain                    # should show "No tracking data yet"
agy --version               # should show version number
```

In Antigravity, verify GSD:
```
/gsd-help                   # should list all GSD commands
```

---

## Daily Use

| Action | Command |
|---|---|
| Start FreeLLMAPI | Double-click `StartFreeLLMAPI.bat` on Desktop |
| Check token savings | `rtk gain` |
| Init RTK for new Antigravity project | `rtk init --agent antigravity` (run once per project folder) |
| Update Antigravity | `agy update` |
| Update GSD | `npx @opengsd/gsd-core@latest --antigravity --global` |
| Start a new project with GSD | `/gsd-new-project` (inside Antigravity) |
| Resume where you left off | `/gsd-progress` (inside Antigravity) |

---

## GSD Workflow (inside Antigravity)

GSD turns Antigravity into a spec-driven, multi-agent system that **ships real features** instead of vibing.

```
/gsd-new-project       → Questions → Research → Requirements → Roadmap
/gsd-discuss-phase 1   → Lock in your preferences before planning
/gsd-plan-phase 1      → Research + Plan + Verify (parallel agents)
/gsd-execute-phase 1   → Execute plans in parallel waves
/gsd-verify-work 1     → Manual UAT — walk through what was built
/gsd-ship 1            → Create a PR with auto-generated body
/gsd-progress          → Auto-detect next step / see where you are
/gsd-complete-milestone → Archive, tag, start next version
```

> **GSD is global** — once installed, it's available in every Antigravity session automatically.

---

## RTK + Antigravity Projects

RTK's global Gemini integration is already set up by `setup.ps1`.  
For **each new project folder** you open in Antigravity, run once:

```powershell
rtk init --agent antigravity
```

This creates `.agents/rules/antigravity-rtk-rules.md` in that project, which tells Antigravity to use RTK commands automatically. Takes 2 seconds.

---

## How It All Fits Together

```
FreeLLMAPI (~1B free tokens/month from 6 providers)
    ↓ routes through
RTK (compresses output, saves 60-90% of tokens)
    ↓ powers
Cursor / Codex / Antigravity
    ↓ guided by
GSD (spec-driven workflow — plan → execute → verify)
    ↓ guided by
Impeccable + Taste Skill + Emil Kowalski skills
    ↓ produces
Polished, well-architected features that don't look AI-generated
```

---

## Notes

- **FreeLLMAPI** must be running (via the bat file) for Cursor and Codex to use it
- **FreeLLMAPI** is for personal/experimental use only — swap in a paid API before shipping to production
- **Antigravity** uses Google's own Gemini API directly — it doesn't route through FreeLLMAPI
- **RTK** on Windows uses instructions mode (not full auto-rewrite) — prefix commands with `rtk` manually or let the agent do it
- **GSD** installs globally to `~/.gemini/antigravity/skills/` — no per-project setup needed (just `rtk init --agent antigravity` per project for RTK)

---

## Troubleshooting

**`agy` not found after install**
> Close and reopen terminal — the PATH update needs a fresh session.

**FreeLLMAPI shows no providers**
> You need to add provider keys manually at `http://localhost:5173/keys` — see Step 3.

**Cursor not using FreeLLMAPI**
> Make sure FreeLLMAPI is running first, then verify the Base URL is set to `http://localhost:3001/v1` in Cursor settings.

**RTK `gain` shows wrong version**
> Another package named `rtk` exists on crates.io. If you installed via cargo, uninstall and reinstall via winget: `winget install --id rtk-ai.rtk`

**GSD commands not showing in Antigravity**
> Restart Antigravity after install. GSD installs to `~/.gemini/antigravity/skills/gsd-*/`. If still missing, re-run: `npx @opengsd/gsd-core@latest --antigravity --global`

**GSD `npx` install fails during setup**
> Run manually after setup: `npx @opengsd/gsd-core@latest --antigravity --global`
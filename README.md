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

Then follow **Steps 2–5** below for the parts that need manual input.

---

## Step 1 — Run setup.ps1

The script handles automatically:
- ✅ FreeLLMAPI clone + install + `.env` setup
- ✅ RTK install via winget
- ✅ RTK init for Cursor, Codex, Gemini/Antigravity
- ✅ Antigravity CLI install
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

---

## Daily Use

| Action | Command |
|---|---|
| Start FreeLLMAPI | Double-click `StartFreeLLMAPI.bat` on Desktop |
| Check token savings | `rtk gain` |
| Init RTK for new Antigravity project | `rtk init --agent antigravity` (run once per project) |
| Update Antigravity | `agy update` |

---

## How It All Fits Together

```
FreeLLMAPI (~1B free tokens/month from 6 providers)
    ↓ routes through
RTK (compresses output, saves 60-90% of tokens)
    ↓ powers
Cursor / Codex / Antigravity
    ↓ guided by
Impeccable + Taste Skill + Emil Kowalski skills
    ↓ produces
Polished websites that don't look AI-generated
```

---

## Notes

- **FreeLLMAPI** must be running (via the bat file) for Cursor and Codex to use it
- **FreeLLMAPI** is for personal/experimental use only — swap in a paid API before shipping to production
- **Antigravity** uses Google's own Gemini API directly — it doesn't route through FreeLLMAPI
- **RTK** on Windows uses instructions mode (not full auto-rewrite) — prefix commands with `rtk` manually or let the agent do it

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
# =============================================================
#  AI Dev Stack — Team Setup Script (Windows)
#  Installs: FreeLLMAPI + RTK + Antigravity CLI
#  Design skills are installed separately (see README Step 2)
# =============================================================

$ErrorActionPreference = "Stop"

function Write-Step($n, $msg) {
    Write-Host ""
    Write-Host "[$n] $msg" -ForegroundColor Cyan
    Write-Host ("-" * 50) -ForegroundColor DarkGray
}

function Write-OK($msg)   { Write-Host "  ✓ $msg" -ForegroundColor Green }
function Write-Info($msg) { Write-Host "  → $msg" -ForegroundColor Gray }
function Write-Warn($msg) { Write-Host "  ⚠ $msg" -ForegroundColor Yellow }
function Write-Err($msg)  { Write-Host "  ✗ $msg" -ForegroundColor Red }

Clear-Host
Write-Host ""
Write-Host "  ╔══════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "  ║         CLAN NXT AI Dev Stack        ║" -ForegroundColor Magenta
Write-Host "  ╚══════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""
Write-Host "  This script sets up:" -ForegroundColor White
Write-Host "   • FreeLLMAPI  (~1B free tokens/month)" -ForegroundColor White
Write-Host "   • RTK         (60-90% token savings)" -ForegroundColor White
Write-Host "   • Antigravity CLI (Google's agy)" -ForegroundColor White
Write-Host ""
Write-Host "  Design Skills (Impeccable, Taste, Emil)" -ForegroundColor DarkGray
Write-Host "  are installed in Step 2 of the README." -ForegroundColor DarkGray
Write-Host ""
Read-Host "  Press Enter to begin"


# ── STEP 1: Prerequisites ─────────────────────────────────────
Write-Step "1/6" "Checking prerequisites"

# Node.js
try {
    $v = node --version 2>$null
    Write-OK "Node.js $v"
} catch {
    Write-Err "Node.js not found. Install v20+ from https://nodejs.org"
    exit 1
}

# npm
try {
    $v = npm --version 2>$null
    Write-OK "npm v$v"
} catch {
    Write-Err "npm not found"
    exit 1
}

# git
try {
    $v = git --version 2>$null
    Write-OK "$v"
} catch {
    Write-Err "git not found. Install from https://git-scm.com"
    exit 1
}

# winget
try {
    $v = winget --version 2>$null
    Write-OK "winget $v"
} catch {
    Write-Warn "winget not found — RTK install will be skipped (install manually)"
    $skipWinget = $true
}


# ── STEP 2: FreeLLMAPI ────────────────────────────────────────
Write-Step "2/6" "Setting up FreeLLMAPI"

Set-Location $HOME

if (Test-Path "$HOME\freellmapi\.git") {
    Write-Info "Already cloned — pulling latest..."
    Set-Location "$HOME\freellmapi"
    git pull --quiet
} else {
    Write-Info "Cloning FreeLLMAPI..."
    git clone --quiet https://github.com/tashfeenahmed/freellmapi.git
    Set-Location "$HOME\freellmapi"
}

Write-Info "Installing npm dependencies..."
npm install --silent

if (-not (Test-Path "$HOME\freellmapi\.env")) {
    Copy-Item .env.example .env
    $key = node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
    (Get-Content .env) -replace 'ENCRYPTION_KEY=your-64-char-hex-key-here', '' | Set-Content .env
    Add-Content .env "ENCRYPTION_KEY=$key"
    Write-OK ".env created with fresh encryption key"
} else {
    Write-OK ".env already exists — skipped"
}

# Copy StartFreeLLMAPI.bat to Desktop
$scriptDir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$batSource  = Join-Path $scriptDir "StartFreeLLMAPI.bat"
$desktopDst = Join-Path ([Environment]::GetFolderPath("Desktop")) "StartFreeLLMAPI.bat"

if (Test-Path $batSource) {
    Copy-Item $batSource $desktopDst -Force
    Write-OK "StartFreeLLMAPI.bat copied to Desktop"
}

Write-OK "FreeLLMAPI ready"


# ── STEP 3: RTK ───────────────────────────────────────────────
Write-Step "3/6" "Installing RTK (Rust Token Killer)"

if ($skipWinget) {
    Write-Warn "Skipping RTK — winget not available"
    Write-Info "Install manually: https://github.com/rtk-ai/rtk/releases"
} else {
    Write-Info "Installing via winget..."
    winget install --id rtk-ai.rtk --accept-package-agreements --accept-source-agreements --silent 2>$null
    Write-OK "RTK installed"
}


# ── STEP 4: Antigravity CLI ───────────────────────────────────
Write-Step "4/6" "Installing Antigravity CLI (agy)"

if (Get-Command agy -ErrorAction SilentlyContinue) {
    $v = agy --version 2>$null
    Write-OK "Already installed — agy v$v"
} else {
    Write-Info "Downloading and installing..."
    irm https://antigravity.google/cli/install.ps1 | iex
    Write-OK "Antigravity CLI installed"
}


# ── STEP 5: Environment variables ────────────────────────────
Write-Step "5/6" "Environment variables"

Write-Host ""
Write-Host "  You need your FreeLLMAPI unified key." -ForegroundColor White
Write-Host "  To get it:" -ForegroundColor White
Write-Host "   1. Run StartFreeLLMAPI.bat from your Desktop" -ForegroundColor Gray
Write-Host "   2. Open http://localhost:5173/keys" -ForegroundColor Gray
Write-Host "   3. Add your provider keys (Groq, Google, Mistral...)" -ForegroundColor Gray
Write-Host "   4. Copy the 'unified API key' at the top" -ForegroundColor Gray
Write-Host ""

$apiKey = Read-Host "  Paste your FreeLLMAPI key here (or Enter to skip)"

if ($apiKey.Trim() -ne "") {
    [System.Environment]::SetEnvironmentVariable("OPENAI_API_KEY",  $apiKey.Trim(), "User")
    [System.Environment]::SetEnvironmentVariable("OPENAI_BASE_URL", "http://localhost:3001/v1", "User")
    Write-OK "OPENAI_API_KEY set"
    Write-OK "OPENAI_BASE_URL set to http://localhost:3001/v1"
} else {
    Write-Warn "Skipped — run this later after starting FreeLLMAPI:"
    Write-Host ""
    Write-Host '  [System.Environment]::SetEnvironmentVariable("OPENAI_API_KEY", "freellmapi-xxx", "User")' -ForegroundColor DarkGray
    Write-Host '  [System.Environment]::SetEnvironmentVariable("OPENAI_BASE_URL", "http://localhost:3001/v1", "User")' -ForegroundColor DarkGray
}


# ── STEP 6: RTK Init ─────────────────────────────────────────
Write-Step "6/6" "Initializing RTK for your tools"

# Refresh PATH so rtk is available in this session
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH","Machine") + ";" +
            [System.Environment]::GetEnvironmentVariable("PATH","User")

if (Get-Command rtk -ErrorAction SilentlyContinue) {
    New-Item -ItemType Directory -Force -Path "$HOME\.claude" | Out-Null

    Write-Info "Cursor..."
    "y`n" | rtk init -g --agent cursor 2>$null

    Write-Info "Codex..."
    "N`n" | rtk init -g --codex 2>$null

    Write-Info "Gemini / Antigravity..."
    "y`nN`n" | rtk init -g --gemini 2>$null

    Write-OK "RTK wired into Cursor, Codex, and Gemini/Antigravity"
    Write-Warn "For each Antigravity project, also run: rtk init --agent antigravity"
} else {
    Write-Warn "RTK not in PATH yet — restart terminal and run:"
    Write-Host ""
    Write-Host "  rtk init -g --agent cursor" -ForegroundColor DarkGray
    Write-Host "  rtk init -g --codex" -ForegroundColor DarkGray
    Write-Host "  rtk init -g --gemini" -ForegroundColor DarkGray
}


# ── Done ──────────────────────────────────────────────────────
Write-Host ""
Write-Host "  ╔══════════════════════════════════════╗" -ForegroundColor Green
Write-Host "  ║           Setup Complete! 🎉          ║" -ForegroundColor Green
Write-Host "  ╚══════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "  Remaining manual steps:" -ForegroundColor White
Write-Host "   1. Install design skills — see README Step 2" -ForegroundColor Gray
Write-Host "   2. Add provider keys at http://localhost:5173/keys" -ForegroundColor Gray
Write-Host "   3. Run: agy auth  (sign in to Google)" -ForegroundColor Gray
Write-Host "   4. Restart your terminal" -ForegroundColor Gray
Write-Host ""
Write-Host "  Tools: Cursor, Codex, Antigravity" -ForegroundColor DarkGray
Write-Host "  Docs:  See README.md in this repo" -ForegroundColor DarkGray
Write-Host ""

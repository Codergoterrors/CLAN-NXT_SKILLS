@echo off
title FreeLLMAPI Server
color 0A

echo.
echo  ==========================================
echo   FreeLLMAPI Starting...
echo   Dashboard : http://localhost:5173
echo   API       : http://localhost:3001/v1
echo  ==========================================
echo.

cd /d "%USERPROFILE%\freellmapi"

if not exist "%USERPROFILE%\freellmapi\node_modules" (
    echo  [!] node_modules not found. Running npm install...
    npm install
)

echo  [*] Server is running. Do not close this window.
echo  [*] Press Ctrl+C to stop.
echo.

npm run dev

pause

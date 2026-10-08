@echo off
echo === Codex sandbox one-click fix ===
echo.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0fix-codex-sandbox.ps1"
echo.
pause

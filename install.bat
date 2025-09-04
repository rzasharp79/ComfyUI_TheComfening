@echo off
setlocal

REM Ensure we run from the repo root (folder of this script)
cd /d "%~dp0"

REM Ensure models folder exists
if not exist "models" mkdir "models"
echo Ensured models directory at: "%cd%\models"

exit /b 0


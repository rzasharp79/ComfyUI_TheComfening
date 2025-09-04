@echo off
setlocal enabledelayedexpansion

REM Ensure we run from the repo root (folder of this script)
cd /d "%~dp0"

echo === ComfyUI Custom Nodes Setup ===
echo This will add ComfyUI-Manager as a git submodule and install its requirements.

REM If the folder already exists, skip everything per request
if exist "custom_nodes\ComfyUI-Manager" (
    echo Folder custom_nodes\ComfyUI-Manager already exists. Skipping submodule add and requirements install.
    exit /b 0
)

REM Ensure custom_nodes directory exists
if not exist "custom_nodes" mkdir "custom_nodes"

REM Add submodule (folder is guaranteed not to exist above)
echo Adding submodule: ComfyUI-Manager into custom_nodes\ComfyUI-Manager
git submodule add --force https://github.com/Comfy-Org/ComfyUI-Manager.git "custom_nodes/ComfyUI-Manager"
if errorlevel 1 (
    echo Failed to add submodule. Ensure this repo is a git repository and Git is installed.
    exit /b 1
)
git submodule update --init --recursive "custom_nodes/ComfyUI-Manager"

REM Move into the submodule directory
pushd "custom_nodes\ComfyUI-Manager" >nul 2>&1
if errorlevel 1 (
    echo Could not enter custom_nodes\ComfyUI-Manager
    exit /b 1
)

REM Choose Python interpreter: prefer local venv, then py, then python
set "PYTHON_CMD="
if exist "%~dp0venv\Scripts\python.exe" set "PYTHON_CMD=%~dp0venv\Scripts\python.exe"
if not defined PYTHON_CMD (
    where py >nul 2>&1 && set "PYTHON_CMD=py -3"
)
if not defined PYTHON_CMD (
    where python >nul 2>&1 && set "PYTHON_CMD=python"
)
if not defined PYTHON_CMD (
    where python3 >nul 2>&1 && set "PYTHON_CMD=python3"
)

if not defined PYTHON_CMD (
    echo Could not find Python. Please ensure Python is installed or a venv exists at venv\.
    popd >nul 2>&1
    exit /b 1
)

echo Using Python: %PYTHON_CMD%
if exist requirements.txt (
    echo Installing ComfyUI-Manager requirements...
    %PYTHON_CMD% -m pip install --upgrade pip
    %PYTHON_CMD% -m pip install -r requirements.txt
    if errorlevel 1 (
        echo Failed to install requirements. You may need to activate your environment and retry.
        popd >nul 2>&1
        exit /b 1
    )
) else (
    echo No requirements.txt found in ComfyUI-Manager. Skipping dependency installation.
)

popd >nul 2>&1
echo Done. ComfyUI-Manager is set up under custom_nodes\ComfyUI-Manager.
exit /b 0

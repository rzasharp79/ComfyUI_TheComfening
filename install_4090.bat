@echo off
setlocal enableextensions

rem Ensure we run from the repo root (this script's directory)
cd /d "%~dp0"

echo === ComfyUI RTX 4090 setup (CUDA 12.9 PyTorch) ===

rem Create venv if missing
if not exist "venv\Scripts\python.exe" (
  echo [1/7] Creating virtual environment in .\venv ...
  where py >nul 2>nul && ( py -m venv venv ) || ( python -m venv venv )
)

rem Activate venv
echo [2/7] Activating virtual environment ...
call .\venv\Scripts\activate

rem Upgrade pip in the venv
echo [3/7] Upgrading pip ...
python -m pip install --upgrade pip

rem Install base requirements
echo [4/7] Installing requirements.txt ...
pip install -r requirements.txt

rem Remove any CPU or mismatched CUDA torch packages
echo [5/7] Uninstalling existing torch packages ...
pip uninstall -y torch torchvision

rem Install CUDA 12.9 wheels for torch/vision
echo [6/7] Installing torch/vision for CUDA 12.9 ...
where pip3 >nul 2>nul && (
  pip3 install torch torchvision --index-url https://download.pytorch.org/whl/cu129
) || (
  rem Fallback if pip3 is not available in venv
  pip install torch torchvision --index-url https://download.pytorch.org/whl/cu129
)

rem Launch ComfyUI
echo [7/7] Starting ComfyUI ...
python main.py

endlocal

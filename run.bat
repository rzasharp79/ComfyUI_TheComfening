@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM Ensure models folder exists
if not exist "models" mkdir "models"

call .\venv\scripts\activate

REM Choose an available port (default 8188 or COMFYUI_PORT)
if not defined COMFYUI_PORT set COMFYUI_PORT=8188
set PORT=
for /L %%P in (%COMFYUI_PORT%,1,8200) do (
  rem Check if port %%P is already LISTENING
  rem We filter for lines containing ":%%P " first, then for "LISTENING"
  netstat -ano | findstr /C:":%%P " | findstr /I /C:"LISTENING" >NUL
  if errorlevel 1 (
    set PORT=%%P
    goto :start_server
  )
)

:start_server
if not defined PORT set PORT=%COMFYUI_PORT%
echo Starting ComfyUI on port !PORT!
python main.py --port !PORT! %*

endlocal

@echo off

REM Ensure models folder exists
if not exist "models" mkdir "models"

call .\venv\scripts\activate
call python main.py 

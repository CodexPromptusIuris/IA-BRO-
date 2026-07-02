@echo off
setlocal
set SCRIPT_DIR=%~dp0
powershell -ExecutionPolicy Bypass -File "%SCRIPT_DIR%local-deploy.ps1"
if errorlevel 1 exit /b %errorlevel%

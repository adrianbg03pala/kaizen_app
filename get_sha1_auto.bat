@echo off
REM Ejecuta el script PowerShell para obtener SHA-1
powershell -ExecutionPolicy Bypass -File "%~dp0get_sha1.ps1"

@echo off
REM Crea un nuevo debug.keystore
powershell -ExecutionPolicy Bypass -File "%~dp0create_keystore.ps1"

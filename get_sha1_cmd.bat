@echo off
REM Extrae SHA-1 del keystore existente (creado por Flutter)

echo Extrayendo SHA-1...
echo.

set JAVA_HOME=C:\Program Files\Java\jre1.8.0_51
set KEYTOOL=%JAVA_HOME%\bin\keytool.exe

if not exist "%KEYTOOL%" (
    echo ERROR: keytool no encontrado en %KEYTOOL%
    echo.
    echo Verifica que Java este instalado en:
    echo C:\Program Files\Java\jre1.8.0_51
    pause
    exit /b 1
)

echo Usando: %KEYTOOL%
echo.

"%KEYTOOL%" -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android

echo.
echo ================================================
echo COPIA EL SHA1 Y REGISTRALO EN:
echo https://console.firebase.google.com
echo Project: kaizen-tfg-real
echo Project Settings -> Your Apps -> KAIZEN App
echo SHA certificate fingerprints -> Add fingerprint
echo ================================================
echo.
pause

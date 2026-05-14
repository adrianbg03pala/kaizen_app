@echo off
REM Script mejorado para obtener SHA-1 del keystore de debug
REM Busca keytool en ubicaciones comunes de Java

setlocal enabledelayedexpansion

echo Getting SHA-1 fingerprint of debug keystore...
echo.

REM Intenta encontrar keytool en ubicaciones comunes
set "KEYTOOL="

REM Opción 1: JAVA_HOME variable
if defined JAVA_HOME (
    if exist "!JAVA_HOME!\bin\keytool.exe" (
        set "KEYTOOL=!JAVA_HOME!\bin\keytool.exe"
    )
)

REM Opción 2: Ubicaciones comunes de Java
if not defined KEYTOOL (
    for %%A in (
        "C:\Program Files\Java\jdk-11\bin\keytool.exe"
        "C:\Program Files\Java\jdk1.8.0_51\bin\keytool.exe"
        "C:\Program Files (x86)\Java\jdk1.8.0_51\bin\keytool.exe"
        "C:\Java\jdk-11\bin\keytool.exe"
        "C:\Java\jdk1.8.0_51\bin\keytool.exe"
    ) do (
        if exist "%%A" (
            set "KEYTOOL=%%A"
            goto found
        )
    )
)

:found
if not defined KEYTOOL (
    echo.
    echo ERROR: No se encontro keytool en el sistema.
    echo.
    echo Opciones para resolver:
    echo.
    echo 1. Agregar Java al PATH:
    echo    - Abre: Configuracion ^(Settings^)
    echo    - Busca: Variables de entorno
    echo    - Edita: Path
    echo    - Agrega: C:\Program Files\Java\jdk1.8.0_51\bin
    echo.
    echo 2. O ejecuta este comando con la ruta completa:
    echo    "C:\Program Files\Java\jdk1.8.0_51\bin\keytool.exe" -list -v -keystore "%%USERPROFILE%%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
    echo.
    pause
    exit /b 1
)

echo Usando keytool desde: !KEYTOOL!
echo.

REM Ejecuta keytool con la ruta completa
"!KEYTOOL!" -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android

echo.
echo.
echo ====================================================
echo INSTRUCCIONES:
echo ====================================================
echo.
echo 1. Busca la linea que dice: SHA1: XX:XX:XX:...
echo.
echo 2. Copia SOLO los valores hexadecimales (sin "SHA1:")
echo    Ejemplo: AB:CD:EF:12:34:56:78:90:...
echo.
echo 3. Abre Firebase Console:
echo    https://console.firebase.google.com
echo.
echo 4. Proyecto: kaizen-tfg-real
echo    Project Settings ^(engranaje^) ^-> Your Apps ^-> KAIZEN App
echo.
echo 5. Busca: SHA certificate fingerprints
echo.
echo 6. Click: Add fingerprint
echo.
echo 7. Pega tu SHA1 y guarda
echo.
echo ====================================================
echo.
pause

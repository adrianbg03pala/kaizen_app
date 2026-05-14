@echo off
REM Limpia y rebuilda el proyecto

echo ========================================
echo Limpiando archivos de compilacion...
echo ========================================
echo.

cd /d C:\Projects\kaizen_app

REM Borra el keystore corrupto
if exist "%USERPROFILE%\.android\debug.keystore" (
    echo Borrando keystore corrupto...
    del "%USERPROFILE%\.android\debug.keystore"
    echo OK
    echo.
)

REM Ejecuta flutter clean
echo Ejecutando flutter clean...
call flutter clean
echo.

REM Ejecuta flutter pub get
echo Ejecutando flutter pub get...
call flutter pub get
echo.

echo ========================================
echo LISTO!
echo ========================================
echo.
echo Ahora ejecuta en una terminal:
echo   flutter run
echo.
echo Esto creara un nuevo keystore y compilara la app.
echo.
pause

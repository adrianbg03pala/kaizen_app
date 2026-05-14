@echo off
REM Elimina completamente el keystore corrupto

echo Eliminando keystore corrupto...
echo.

REM Elimina la carpeta .android completa
if exist "%USERPROFILE%\.android" (
    echo Borrando %USERPROFILE%\.android...
    rmdir /s /q "%USERPROFILE%\.android"
    echo OK
)

echo.
echo Keystore eliminado.
echo.
echo Ahora ejecuta:
echo   flutter run
echo.
echo Flutter creara un nuevo keystore limpio automaticamente.
echo.
pause

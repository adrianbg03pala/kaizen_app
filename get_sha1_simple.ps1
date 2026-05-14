# Script simple para extraer SHA-1 del keystore que ya existe

$keystorePath = "$env:USERPROFILE\.android\debug.keystore"

if (-not (Test-Path $keystorePath)) {
    Write-Host "ERROR: Keystore no encontrado en $keystorePath" -ForegroundColor Red
    pause
    exit 1
}

Write-Host "Extrayendo SHA-1 del keystore..." -ForegroundColor Green
Write-Host ""

# Intenta con keytool de Java
$javaHome = "C:\Program Files\Java\jre1.8.0_51"
$keytool = "$javaHome\bin\keytool.exe"

if (Test-Path $keytool) {
    & $keytool -list -v -keystore $keystorePath -alias androiddebugkey -storepass android -keypass android 2>&1 | Select-String "SHA1:" -A 0
}
else {
    Write-Host "keytool no encontrado" -ForegroundColor Red
}

Write-Host ""
Write-Host "Copia el SHA1 y regístralo en Firebase Console:" -ForegroundColor Cyan
Write-Host "https://console.firebase.google.com" -ForegroundColor Yellow
Write-Host ""
pause

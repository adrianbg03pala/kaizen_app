# Script para crear un nuevo debug.keystore

Write-Host "Creando debug.keystore..." -ForegroundColor Yellow
Write-Host ""

$javaPaths = @()

# Busca Java
try {
    $regPath = "HKLM:\SOFTWARE\JavaSoft\Java Development Kit"
    if (Test-Path $regPath) {
        $versions = Get-ChildItem $regPath
        foreach ($version in $versions) {
            $javaHome = (Get-ItemProperty $version.PSPath).JavaHome
            if ($javaHome -and (Test-Path "$javaHome\bin\keytool.exe")) {
                $javaPaths += $javaHome
            }
        }
    }
}
catch { }

if ($javaPaths.Count -eq 0) {
    Write-Host "ERROR: No se encontro Java" -ForegroundColor Red
    pause
    exit 1
}

$javaHome = $javaPaths[0]
$keytool = "$javaHome\bin\keytool.exe"
$keystorePath = "$env:USERPROFILE\.android\debug.keystore"
$keystoreDir = "$env:USERPROFILE\.android"

# Crea la carpeta .android si no existe
if (-not (Test-Path $keystoreDir)) {
    New-Item -ItemType Directory -Path $keystoreDir -Force | Out-Null
    Write-Host "Carpeta .android creada" -ForegroundColor Green
}

# Elimina el keystore existente si está corrupto
if (Test-Path $keystorePath) {
    Remove-Item $keystorePath -Force
    Write-Host "Keystore antiguo eliminado" -ForegroundColor Yellow
}

Write-Host "Creando nuevo keystore..." -ForegroundColor Cyan
Write-Host ""

# Crea un nuevo keystore
& $keytool -genkey -v -keystore $keystorePath -keyalg RSA -keysize 2048 -validity 10000 -alias androiddebugkey -storepass android -keypass android -dname "CN=Android Debug,O=Android,C=US"

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Keystore creado exitosamente!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Ahora obteniendo el SHA-1..." -ForegroundColor Yellow
    Write-Host ""

    # Obtiene el SHA-1
    & $keytool -list -v -keystore $keystorePath -alias androiddebugkey -storepass android -keypass android

    Write-Host ""
    Write-Host "========================================================" -ForegroundColor Cyan
    Write-Host "LISTO! Ahora:" -ForegroundColor Cyan
    Write-Host "========================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Copia el SHA1 que aparece arriba" -ForegroundColor White
    Write-Host ""
    Write-Host "2. Ve a Firebase Console:" -ForegroundColor White
    Write-Host "   https://console.firebase.google.com" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "3. Proyecto: kaizen-tfg-real" -ForegroundColor White
    Write-Host "   Project Settings -> Your Apps -> KAIZEN App" -ForegroundColor White
    Write-Host "   SHA certificate fingerprints -> Add fingerprint" -ForegroundColor White
    Write-Host ""
    Write-Host "4. Pega el SHA1 y guarda" -ForegroundColor White
    Write-Host ""
    Write-Host "========================================================" -ForegroundColor Cyan
}
else {
    Write-Host "ERROR al crear el keystore" -ForegroundColor Red
}

pause

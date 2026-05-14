# Script PowerShell para obtener SHA-1 del keystore de debug

Write-Host "Buscando Java en el sistema..." -ForegroundColor Yellow
Write-Host ""

$javaPaths = @()

# Busca en HKLM
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

# Busca en ubicaciones comunes
$commonPaths = @(
    "C:\Program Files\Java",
    "C:\Program Files (x86)\Java",
    "C:\Java"
)

foreach ($path in $commonPaths) {
    if (Test-Path $path) {
        $jdks = Get-ChildItem $path -Directory -ErrorAction SilentlyContinue
        foreach ($jdk in $jdks) {
            if (Test-Path "$($jdk.FullName)\bin\keytool.exe") {
                $javaPaths += $jdk.FullName
            }
        }
    }
}

if ($javaPaths.Count -eq 0) {
    Write-Host "ERROR: No se encontro Java" -ForegroundColor Red
    Write-Host "Descarga Java desde: https://www.oracle.com/java/technologies/downloads/"
    pause
    exit 1
}

$javaHome = $javaPaths[0]
$keytool = "$javaHome\bin\keytool.exe"

Write-Host "Java encontrado en: $javaHome" -ForegroundColor Green
Write-Host ""
Write-Host "Obteniendo SHA-1..." -ForegroundColor Yellow
Write-Host ""

# Ejecuta keytool
& $keytool -list -v -keystore "$env:USERPROFILE\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android

Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "INSTRUCCIONES:" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Busca arriba la linea con: SHA1: XX:XX:XX:..." -ForegroundColor White
Write-Host ""
Write-Host "2. Copia SOLO los valores hexadecimales (sin SHA1:)" -ForegroundColor White
Write-Host "   Ejemplo: AB:CD:EF:12:34:56:78:90:AB:CD" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Abre Firebase Console:" -ForegroundColor White
Write-Host "   https://console.firebase.google.com" -ForegroundColor Cyan
Write-Host ""
Write-Host "4. Proyecto: kaizen-tfg-real" -ForegroundColor White
Write-Host ""
Write-Host "5. Project Settings -> Your Apps -> KAIZEN App" -ForegroundColor White
Write-Host ""
Write-Host "6. SHA certificate fingerprints -> Add fingerprint" -ForegroundColor White
Write-Host ""
Write-Host "7. Pega tu SHA1 y guarda" -ForegroundColor White
Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""
pause

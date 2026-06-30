# WinTool Installer - kompatybilny z: irm "url" | iex
# Nie uzywamy param() ani exit - bo lamia irm | iex

$SourceBaseUrl = "https://raw.githubusercontent.com/Zespol-Borys/WinTool-for-Windows-11/main/program%20do%20powershella"
$InstallPath = "C:\WinTool"

$Files = @(
    "Windows11-Cleaner.ps1",
    "WinTool-WindowsUpdateGuard.ps1",
    "LISTA-KATEGORIE.md"
)

try {
    Write-Host ""
    Write-Host "+============================================================+" -ForegroundColor DarkCyan
    Write-Host "|              WinTool Installer                             |" -ForegroundColor Cyan
    Write-Host "+============================================================+" -ForegroundColor DarkCyan
    Write-Host ""

    # Sprawdz administratora
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal]::new($identity)
    $isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if (-not $isAdmin) {
        Write-Host "Brak uprawnien administratora. Ponowne uruchomienie..." -ForegroundColor Yellow

        # Pobierz install.ps1 do temp, zeby moc uruchomic jako admin z pliku
        $tempFile = Join-Path $env:TEMP "WinTool-install.ps1"
        Invoke-WebRequest -Uri "$SourceBaseUrl/install.ps1" -OutFile $tempFile -UseBasicParsing

        Start-Process -FilePath "powershell.exe" -ArgumentList @(
            "-NoProfile", "-NoExit", "-ExecutionPolicy", "Bypass",
            "-File", $tempFile
        ) -Verb RunAs

        Write-Host "Otwarto nowe okno z uprawnieniami administratora." -ForegroundColor Green
        Start-Sleep -Seconds 2
        return
    }

    Write-Host "Administrator: TAK" -ForegroundColor Green
    Write-Host "Cel instalacji: $InstallPath" -ForegroundColor DarkGray
    Write-Host ""

    # Utworz folder
    New-Item -Path $InstallPath -ItemType Directory -Force | Out-Null

    # Pobierz pliki
    foreach ($file in $Files) {
        $url = "{0}/{1}" -f $SourceBaseUrl, $file
        $target = Join-Path $InstallPath $file
        Write-Host "  Pobieranie: $file ..." -ForegroundColor Cyan
        Invoke-WebRequest -Uri $url -OutFile $target -UseBasicParsing
        Write-Host "  OK" -ForegroundColor Green
    }

    Write-Host ""
    Write-Host "WinTool zainstalowany w: $InstallPath" -ForegroundColor Green
    Write-Host "Uruchamianie programu..." -ForegroundColor Green
    Write-Host ""

    # Uruchom glowny skrypt
    $mainScript = Join-Path $InstallPath "Windows11-Cleaner.ps1"
    & $mainScript
}
catch {
    Write-Host ""
    Write-Host "BLAD: $_" -ForegroundColor Red
    Write-Host ""
    Read-Host "Enter aby zamknac"
}

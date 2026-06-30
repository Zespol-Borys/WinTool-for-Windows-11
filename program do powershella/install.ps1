[CmdletBinding()]
param(
    [string]$SourceBaseUrl = "https://TU-WKLEJ-LINK-DO-FOLDERU-RAW/WinTool",
    [string]$InstallPath = "C:\WinTool"
)

$ErrorActionPreference = "Stop"

$Files = @(
    "Windows11-Cleaner.ps1",
    "WinTool-WindowsUpdateGuard.ps1",
    "LISTA-KATEGORIE.md"
)

function Test-IsAdmin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal]::new($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Restart-AsAdmin {
    if (Test-IsAdmin) {
        return
    }

    $arguments = @(
        "-NoProfile",
        "-ExecutionPolicy", "Bypass",
        "-File", "`"$PSCommandPath`"",
        "-SourceBaseUrl", "`"$SourceBaseUrl`"",
        "-InstallPath", "`"$InstallPath`""
    )

    Start-Process -FilePath "powershell.exe" -ArgumentList $arguments -Verb RunAs
    exit
}

function Get-DownloadUrl {
    param([string]$FileName)

    return ("{0}/{1}" -f $SourceBaseUrl.TrimEnd("/"), $FileName)
}

Restart-AsAdmin

if ($SourceBaseUrl -like "*TU-WKLEJ-LINK*") {
    Write-Host "Najpierw podmien SourceBaseUrl w install.ps1 na prawdziwy link RAW." -ForegroundColor Red
    Write-Host "Przyklad GitHub RAW: https://raw.githubusercontent.com/user/repo/main"
    Read-Host "Enter aby zamknac"
    exit 1
}

New-Item -Path $InstallPath -ItemType Directory -Force | Out-Null

foreach ($file in $Files) {
    $url = Get-DownloadUrl -FileName $file
    $target = Join-Path $InstallPath $file

    Write-Host "Pobieranie: $file" -ForegroundColor Cyan
    Invoke-WebRequest -Uri $url -OutFile $target -UseBasicParsing
}

$mainScript = Join-Path $InstallPath "Windows11-Cleaner.ps1"

Write-Host ""
Write-Host "WinTool zainstalowany w: $InstallPath" -ForegroundColor Green
Write-Host "Uruchamianie programu..." -ForegroundColor Green

powershell -NoProfile -ExecutionPolicy Bypass -File $mainScript

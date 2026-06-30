[CmdletBinding()]
param()

$ErrorActionPreference = "Continue"

$BasePath = Split-Path -Parent $PSCommandPath
$StatePath = Join-Path $BasePath "wintool-windows-update-guard.json"
$LogPath = Join-Path $BasePath "wintool-windows-update-guard.log"
$TaskName = "WinTool-WindowsUpdateGuard"

function Write-GuardLog {
    param([string]$Message)

    $line = "[{0}] {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $Message
    Add-Content -Path $LogPath -Value $line -Encoding UTF8
}

function Disable-WindowsUpdateNow {
    $policyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
    New-Item -Path $policyPath -Force | Out-Null
    New-ItemProperty -Path $policyPath -Name "NoAutoUpdate" -Value 1 -PropertyType DWord -Force | Out-Null

    $services = @("wuauserv", "UsoSvc", "DoSvc", "BITS")

    foreach ($serviceName in $services) {
        $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
        if ($service) {
            Stop-Service -Name $serviceName -Force -ErrorAction SilentlyContinue
            Set-Service -Name $serviceName -StartupType Disabled -ErrorAction SilentlyContinue
        }
    }
}

function Restore-WindowsUpdateNow {
    $policyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
    Remove-ItemProperty -Path $policyPath -Name "NoAutoUpdate" -ErrorAction SilentlyContinue

    $settingsPath = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
    $pauseProperties = @(
        "PauseUpdatesExpiryTime",
        "PauseFeatureUpdatesEndTime",
        "PauseQualityUpdatesEndTime"
    )

    foreach ($property in $pauseProperties) {
        Remove-ItemProperty -Path $settingsPath -Name $property -ErrorAction SilentlyContinue
    }

    $services = @("BITS", "DoSvc", "UsoSvc", "wuauserv")

    foreach ($serviceName in $services) {
        $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
        if ($service) {
            Set-Service -Name $serviceName -StartupType Manual -ErrorAction SilentlyContinue
        }
    }
}

if (-not (Test-Path -LiteralPath $StatePath)) {
    Write-GuardLog "State file not found. Guard exits."
    exit 0
}

try {
    $state = Get-Content -LiteralPath $StatePath -Raw | ConvertFrom-Json
    $endTime = [datetime]$state.EndTime
}
catch {
    Write-GuardLog "State file is invalid. Guard exits."
    exit 1
}

if ((Get-Date) -ge $endTime) {
    Write-GuardLog "Guard expired. Restoring Windows Update and removing scheduled task."
    Restore-WindowsUpdateNow
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $StatePath -Force -ErrorAction SilentlyContinue
    exit 0
}

Write-GuardLog "Guard active until $endTime. Enforcing Windows Update disabled state."
Disable-WindowsUpdateNow

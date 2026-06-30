[CmdletBinding()]
param()

$ErrorActionPreference = "Continue"

$LogPath = Join-Path $PSScriptRoot ("cleaner-log-{0}.txt" -f (Get-Date -Format "yyyyMMdd-HHmmss"))
$FooterText = "Zespol Borys (c) 2026 WinTool"
$WindowsUpdateGuardTaskName = "WinTool-WindowsUpdateGuard"
$WindowsUpdateGuardScriptPath = Join-Path $PSScriptRoot "WinTool-WindowsUpdateGuard.ps1"
$WindowsUpdateGuardStatePath = Join-Path $PSScriptRoot "wintool-windows-update-guard.json"

$Translations = @{
    pl = @{
        MainTitle = "Panel glowny"
        MainSubtitle = "Steruj czyszczeniem Windows 11 z jednego menu."
        Menu = "Menu:"
        PickApps = "Wybierz aplikacje do usuniecia"
        RedOption = "OPCJA CZERWONA: OneDrive + Windows Update"
        RemoveSelected = "Usun zaznaczone aplikacje"
        ShowCategories = "Pokaz liste kategorii"
        LanguageMenu = "Zmien jezyk"
        Exit = "Wyjscie"
        SelectedApps = "Zaznaczone aplikacje"
        Choice = "Wybor"
        AppMenuTitle = "Menu 1 - wybor aplikacji"
        AppMenuSubtitle = "Zaznacz aplikacje numerem, komenda cNUMER albo myszka."
        AppsToRemove = "Aplikacje do usuniecia:"
        AppHintNumber = "Mozesz wpisac numer, np. 4, albo komende, np. c4."
        AppHintMouse = "M - otworz okno do zaznaczania myszka"
        SelectAll = "zaznacz wszystko"
        DeselectAll = "odznacz wszystko"
        MouseSelect = "zaznacz myszka w oknie"
        Back = "powrot"
        CategoryTitle = "Lista kategorii"
        CategorySubtitle = "Podzial aplikacji wedlug ryzyka usuwania."
        CategoryHeader = "Kategorie usuwania"
        ConfirmTitle = "Potwierdzenie usuwania"
        ConfirmSubtitle = "Sprawdz liste przed wykonaniem zmian."
        WillRemove = "Zostana usuniete:"
        RedTitle = "Opcja czerwona"
        RedSubtitle = "Narzedzia dla OneDrive i Windows Update."
        RemoveOneDrive = "Usun OneDrive"
        PauseUpdate = "Windows Update: blokada na wybrana liczbe dni"
        DisableUpdate = "Windows Update: wylacz na stale"
        RestoreUpdate = "Windows Update: przywroc dzialanie"
        RemoveOneDrivePause = "Usun OneDrive + zablokuj Windows Update"
        LanguageTitle = "Jezyk programu"
        LanguageSubtitle = "Wybierz jezyk recznie albo zostaw automatyczne wykrywanie."
        AutoLanguage = "Automatycznie wedlug Windows"
        Polish = "Polski"
        English = "Angielski"
        German = "Niemiecki"
        CurrentLanguage = "Aktualny jezyk"
        UnknownOption = "Nieznana opcja."
        PressEnter = "Enter aby wrocic"
        ConfirmHint = "wpisz TAK/T"
        ConfirmRemoveSelected = "Na pewno usunac zaznaczone aplikacje?"
        ConfirmOneDrive = "Usunac OneDrive?"
        ConfirmBlockUpdateDays = "Zablokowac Windows Update na {0} dni?"
        ConfirmDisableUpdate = "Kontynuowac stale wylaczenie Windows Update?"
        ConfirmRestoreUpdate = "Przywrocic Windows Update?"
        ConfirmOneDriveBlockUpdate = "Usunac OneDrive i zablokowac Windows Update na {0} dni?"
        ConfirmCancelled = "Anulowano."
    }
    en = @{
        MainTitle = "Main panel"
        MainSubtitle = "Control Windows 11 cleanup from one menu."
        Menu = "Menu:"
        PickApps = "Choose apps to remove"
        RedOption = "RED OPTION: OneDrive + Windows Update"
        RemoveSelected = "Remove selected apps"
        ShowCategories = "Show category list"
        LanguageMenu = "Change language"
        Exit = "Exit"
        SelectedApps = "Selected apps"
        Choice = "Choice"
        AppMenuTitle = "Menu 1 - app selection"
        AppMenuSubtitle = "Select apps by number, cNUMBER command, or mouse."
        AppsToRemove = "Apps to remove:"
        AppHintNumber = "You can type a number, e.g. 4, or a command, e.g. c4."
        AppHintMouse = "M - open mouse selection window"
        SelectAll = "select all"
        DeselectAll = "deselect all"
        MouseSelect = "select with mouse in a window"
        Back = "back"
        CategoryTitle = "Category list"
        CategorySubtitle = "Apps grouped by removal risk."
        CategoryHeader = "Removal categories"
        ConfirmTitle = "Removal confirmation"
        ConfirmSubtitle = "Check the list before applying changes."
        WillRemove = "The following will be removed:"
        RedTitle = "Red option"
        RedSubtitle = "Tools for OneDrive and Windows Update."
        RemoveOneDrive = "Remove OneDrive"
        PauseUpdate = "Windows Update: block for custom number of days"
        DisableUpdate = "Windows Update: disable permanently"
        RestoreUpdate = "Windows Update: restore"
        RemoveOneDrivePause = "Remove OneDrive + block Windows Update"
        LanguageTitle = "Program language"
        LanguageSubtitle = "Choose language manually or keep automatic detection."
        AutoLanguage = "Automatic from Windows"
        Polish = "Polish"
        English = "English"
        German = "German"
        CurrentLanguage = "Current language"
        UnknownOption = "Unknown option."
        PressEnter = "Enter to go back"
        ConfirmHint = "type YES/Y"
        ConfirmRemoveSelected = "Remove selected apps?"
        ConfirmOneDrive = "Remove OneDrive?"
        ConfirmBlockUpdateDays = "Block Windows Update for {0} days?"
        ConfirmDisableUpdate = "Continue with permanent Windows Update disable?"
        ConfirmRestoreUpdate = "Restore Windows Update?"
        ConfirmOneDriveBlockUpdate = "Remove OneDrive and block Windows Update for {0} days?"
        ConfirmCancelled = "Cancelled."
    }
    de = @{
        MainTitle = "Hauptmenue"
        MainSubtitle = "Windows-11-Bereinigung aus einem Menue steuern."
        Menu = "Menue:"
        PickApps = "Apps zum Entfernen auswaehlen"
        RedOption = "ROTE OPTION: OneDrive + Windows Update"
        RemoveSelected = "Ausgewaehlte Apps entfernen"
        ShowCategories = "Kategorieliste anzeigen"
        LanguageMenu = "Sprache aendern"
        Exit = "Beenden"
        SelectedApps = "Ausgewaehlte Apps"
        Choice = "Auswahl"
        AppMenuTitle = "Menue 1 - App-Auswahl"
        AppMenuSubtitle = "Apps per Nummer, Befehl cNUMMER oder Maus auswaehlen."
        AppsToRemove = "Apps zum Entfernen:"
        AppHintNumber = "Du kannst eine Nummer eingeben, z.B. 4, oder einen Befehl, z.B. c4."
        AppHintMouse = "M - Fenster zur Mausauswahl oeffnen"
        SelectAll = "alle auswaehlen"
        DeselectAll = "alle abwaehlen"
        MouseSelect = "mit Maus im Fenster auswaehlen"
        Back = "zurueck"
        CategoryTitle = "Kategorieliste"
        CategorySubtitle = "Apps nach Risiko beim Entfernen gruppiert."
        CategoryHeader = "Entfernungskategorien"
        ConfirmTitle = "Entfernen bestaetigen"
        ConfirmSubtitle = "Pruefe die Liste vor dem Anwenden."
        WillRemove = "Folgendes wird entfernt:"
        RedTitle = "Rote Option"
        RedSubtitle = "Werkzeuge fuer OneDrive und Windows Update."
        RemoveOneDrive = "OneDrive entfernen"
        PauseUpdate = "Windows Update: fuer eigene Anzahl Tage blockieren"
        DisableUpdate = "Windows Update: dauerhaft deaktivieren"
        RestoreUpdate = "Windows Update: wiederherstellen"
        RemoveOneDrivePause = "OneDrive entfernen + Windows Update blockieren"
        LanguageTitle = "Programmsprache"
        LanguageSubtitle = "Sprache manuell waehlen oder automatische Erkennung nutzen."
        AutoLanguage = "Automatisch nach Windows"
        Polish = "Polnisch"
        English = "Englisch"
        German = "Deutsch"
        CurrentLanguage = "Aktuelle Sprache"
        UnknownOption = "Unbekannte Option."
        PressEnter = "Enter zum Zurueckgehen"
        ConfirmHint = "JA/J eingeben"
        ConfirmRemoveSelected = "Ausgewaehlte Apps entfernen?"
        ConfirmOneDrive = "OneDrive entfernen?"
        ConfirmBlockUpdateDays = "Windows Update fuer {0} Tage blockieren?"
        ConfirmDisableUpdate = "Dauerhafte Deaktivierung von Windows Update fortsetzen?"
        ConfirmRestoreUpdate = "Windows Update wiederherstellen?"
        ConfirmOneDriveBlockUpdate = "OneDrive entfernen und Windows Update fuer {0} Tage blockieren?"
        ConfirmCancelled = "Abgebrochen."
    }
}

function Get-SystemLanguage {
    $language = (Get-Culture).TwoLetterISOLanguageName

    if ($Translations.ContainsKey($language)) {
        return $language
    }

    return "pl"
}

$Script:LanguageMode = "auto"
$Script:CurrentLanguage = Get-SystemLanguage

function Set-AppLanguage {
    param([string]$Language)

    if ($Language -eq "auto") {
        $Script:LanguageMode = "auto"
        $Script:CurrentLanguage = Get-SystemLanguage
        return
    }

    if ($Translations.ContainsKey($Language)) {
        $Script:LanguageMode = $Language
        $Script:CurrentLanguage = $Language
    }
}

function T {
    param([string]$Key)

    if ($Translations[$Script:CurrentLanguage].ContainsKey($Key)) {
        return $Translations[$Script:CurrentLanguage][$Key]
    }

    return $Translations["pl"][$Key]
}

function Confirm-Action {
    param([string]$Message)

    $answer = Read-Host ("{0} ({1})" -f $Message, (T "ConfirmHint"))
    $normalized = $answer.Trim().ToUpperInvariant()
    $accepted = @("TAK", "T", "YES", "Y", "JA", "J")

    return $accepted -contains $normalized
}

$Apps = @(
    @{
        Name = "Microsoft Edge"
        Packages = @("Microsoft.MicrosoftEdge.Stable", "Microsoft.MicrosoftEdge")
        Category = "Opcjonalne"
        Note = "Usuwaj tylko jesli masz inna przegladarke."
        Selected = $false
    },
    @{
        Name = "Microsoft Store"
        Packages = @("Microsoft.WindowsStore")
        Category = "Bezpieczne do usuniecia"
        Note = "Usuwa sklep Microsoft Store."
        Selected = $false
    },
    @{
        Name = "Poczta / Outlook"
        Packages = @("microsoft.windowscommunicationsapps", "Microsoft.OutlookForWindows")
        Category = "Bezpieczne do usuniecia"
        Note = "Mozna usunac, jesli uzywasz poczty w przegladarce lub innym programie."
        Selected = $true
    },
    @{
        Name = "Sticky Notes"
        Packages = @("Microsoft.MicrosoftStickyNotes")
        Category = "Bezpieczne do usuniecia"
        Note = "Usuwa systemowe karteczki."
        Selected = $true
    },
    @{
        Name = "Solitaire Collection"
        Packages = @("Microsoft.MicrosoftSolitaireCollection")
        Category = "Bezpieczne do usuniecia"
        Note = "Gra Microsoft Solitaire."
        Selected = $true
    },
    @{
        Name = "Pogoda"
        Packages = @("Microsoft.BingWeather")
        Category = "Bezpieczne do usuniecia"
        Note = "Aplikacja pogodowa Microsoft."
        Selected = $true
    },
    @{
        Name = "Mapy"
        Packages = @("Microsoft.WindowsMaps")
        Category = "Bezpieczne do usuniecia"
        Note = "Aplikacja map Windows."
        Selected = $true
    },
    @{
        Name = "Microsoft 365 / Office hub"
        Packages = @("Microsoft.MicrosoftOfficeHub")
        Category = "Bezpieczne do usuniecia"
        Note = "Hub/reklama Microsoft 365, nie pelny Office."
        Selected = $true
    },
    @{
        Name = "Microsoft To Do"
        Packages = @("Microsoft.Todos")
        Category = "Bezpieczne do usuniecia"
        Note = "Lista zadan Microsoft."
        Selected = $true
    },
    @{
        Name = "Word"
        Packages = @("Microsoft.Office.Word")
        Category = "Opcjonalne"
        Note = "Usuwa aplikacje Word, jesli jest zainstalowana jako pakiet Microsoft Store."
        Selected = $false
    },
    @{
        Name = "Excel"
        Packages = @("Microsoft.Office.Excel")
        Category = "Opcjonalne"
        Note = "Usuwa aplikacje Excel, jesli jest zainstalowana jako pakiet Microsoft Store."
        Selected = $false
    },
    @{
        Name = "PowerPoint"
        Packages = @("Microsoft.Office.PowerPoint")
        Category = "Opcjonalne"
        Note = "Usuwa aplikacje PowerPoint, jesli jest zainstalowana jako pakiet Microsoft Store."
        Selected = $false
    },
    @{
        Name = "Outlook"
        Packages = @("Microsoft.OutlookForWindows")
        Category = "Opcjonalne"
        Note = "Usuwa nowego Outlooka dla Windows."
        Selected = $false
    },
    @{
        Name = "Outlook classic"
        Packages = @("Microsoft.Office.Outlook")
        Category = "Opcjonalne"
        Note = "Klasyczny Outlook zwykle jest czescia pakietu Office i moze nie usunac sie osobno."
        Selected = $false
    },
    @{
        Name = "OneNote"
        Packages = @("Microsoft.Office.OneNote")
        Category = "Opcjonalne"
        Note = "Usuwa OneNote, jesli jest zainstalowany jako pakiet Microsoft Store."
        Selected = $false
    },
    @{
        Name = "OneNote for Windows 10"
        Packages = @("Microsoft.Office.OneNote")
        Category = "Opcjonalne"
        Note = "Usuwa starszy OneNote dla Windows 10, jesli jest dostepny jako pakiet."
        Selected = $false
    },
    @{
        Name = "Microsoft Copilot"
        Packages = @("Microsoft.Copilot")
        Category = "Opcjonalne"
        Note = "Usuwa aplikacje Microsoft Copilot, jesli jest zainstalowana."
        Selected = $false
    },
    @{
        Name = "Copilot w Windows"
        Packages = @("Microsoft.Windows.Copilot", "Microsoft.Copilot")
        Category = "Opcjonalne"
        Note = "Probuje usunac pakiet Copilot widoczny dla Windows."
        Selected = $false
    }
)

$CategoryList = @(
    @{
        Title = "Bezpieczne do usuniecia"
        Color = "Green"
        Items = @(
            "Poczta / Outlook",
            "Microsoft Store",
            "Sticky Notes",
            "Solitaire Collection",
            "Pogoda",
            "Mapy",
            "Microsoft 365 / Office hub",
            "Microsoft To Do",
            "Feedback Hub",
            "Get Help",
            "Tips"
        )
    },
    @{
        Title = "Opcjonalne"
        Color = "Yellow"
        Items = @(
            "OneDrive - usun, jesli nie synchronizujesz plikow z chmura",
            "Windows Update - pauza na wybrana liczbe dni albo stale wylaczenie",
            "Microsoft Edge - usun tylko jesli masz inna przegladarke",
            "Word",
            "Excel",
            "PowerPoint",
            "Outlook",
            "Outlook classic",
            "OneNote",
            "OneNote for Windows 10",
            "Microsoft Copilot",
            "Copilot w Windows",
            "Xbox / Game Bar - usun, jesli nie grasz i nie nagrywasz gier",
            "Teams / Chat - usun, jesli nie uzywasz",
            "Widgets - wylacz, jesli przeszkadzaja"
        )
    },
    @{
        Title = "Nie ruszac"
        Color = "Red"
        Items = @(
            "Windows Security / Defender",
            "Microsoft Edge WebView2 Runtime",
            "Visual C++ Redistributable",
            ".NET Runtime",
            "Sterowniki",
            "Windows Installer",
            "Usługi aktywacji Windows"
        )
    }
)

function Write-Log {
    param([string]$Message)

    $line = "[{0}] {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $Message
    Add-Content -Path $LogPath -Value $line -Encoding UTF8
}

function Test-IsAdmin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal]::new($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Restart-AsAdmin {
    if (Test-IsAdmin) {
        return
    }

    Write-Host ""
    Write-Host "Ten program najlepiej uruchomic jako administrator." -ForegroundColor Yellow
    $answer = Read-Host "Uruchomic ponownie jako administrator? (T/N)"

    if ($answer -match "^[TtYy]$") {
        Start-Process -FilePath "powershell.exe" -ArgumentList @(
            "-NoProfile",
            "-NoExit",
            "-ExecutionPolicy", "Bypass",
            "-File", "`"$PSCommandPath`""
        ) -Verb RunAs
        exit
    }
}

function Show-Header {
    param(
        [string]$Title = (T "MainTitle"),
        [string]$Subtitle = (T "MainSubtitle")
    )

    Clear-Host
    Write-Host "+============================================================+" -ForegroundColor DarkCyan
    Write-Host "|                    WinTool Cleaner                         |" -ForegroundColor Cyan
    Write-Host "+============================================================+" -ForegroundColor DarkCyan
    Write-Host ("  {0}" -f $Title) -ForegroundColor White
    Write-Host ("  {0}" -f $Subtitle) -ForegroundColor DarkGray
    Write-Host ("  Log: {0}" -f $LogPath) -ForegroundColor DarkGray
    Write-Host ""
}

function Show-Footer {
    Write-Host ""
    Write-Host "+------------------------------------------------------------+" -ForegroundColor DarkGray
    Write-Host ("  {0}" -f $FooterText) -ForegroundColor DarkGray
}

function Write-MenuOption {
    param(
        [string]$Key,
        [string]$Text,
        [ConsoleColor]$Color = "White"
    )

    Write-Host ("  [{0}] {1}" -f $Key, $Text) -ForegroundColor $Color
}

function Show-AppMenu {
    while ($true) {
        Show-Header -Title (T "AppMenuTitle") -Subtitle (T "AppMenuSubtitle")
        Write-Host (T "AppsToRemove") -ForegroundColor Cyan
        Write-Host (T "AppHintNumber") -ForegroundColor DarkGray
        Write-Host (T "AppHintMouse") -ForegroundColor DarkGray
        Write-Host ""

        for ($index = 0; $index -lt $Apps.Count; $index++) {
            if ($Apps[$index].Selected) { $mark = "[X]" } else { $mark = "[ ]" }
            $line = "{0,2}. {1} {2} ({3})" -f ($index + 1), $mark, $Apps[$index].Name, $Apps[$index].Category

            if ($Apps[$index].Category -eq "Nie ruszac") {
                Write-Host $line -ForegroundColor Red
            }
            elseif ($Apps[$index].Category -eq "Opcjonalne") {
                Write-Host $line -ForegroundColor Yellow
            }
            else {
                Write-Host $line -ForegroundColor Green
            }
        }

        Write-Host ""
        Write-MenuOption -Key "A" -Text (T "SelectAll") -Color Cyan
        Write-MenuOption -Key "D" -Text (T "DeselectAll") -Color Cyan
        Write-MenuOption -Key "M" -Text (T "MouseSelect") -Color Cyan
        Write-MenuOption -Key "0" -Text (T "Back") -Color DarkGray
        Show-Footer

        $choice = Read-Host (T "Choice")

        if ($choice -eq "0") {
            return
        }

        if ($choice -match "^[Aa]$") {
            foreach ($app in $Apps) {
                $app.Selected = $true
            }
            continue
        }

        if ($choice -match "^[Dd]$") {
            foreach ($app in $Apps) {
                $app.Selected = $false
            }
            continue
        }

        if ($choice -match "^[Mm]$") {
            Show-AppMouseMenu
            continue
        }

        if ($choice -match "^[Cc](\d+)$") {
            $number = [int]$Matches[1]
            if ($number -ge 1 -and $number -le $Apps.Count) {
                $Apps[$number - 1].Selected = -not $Apps[$number - 1].Selected
            }
            continue
        }

        $number = 0
        if ([int]::TryParse($choice, [ref]$number) -and $number -ge 1 -and $number -le $Apps.Count) {
            $Apps[$number - 1].Selected = -not $Apps[$number - 1].Selected
        }
    }
}

function Show-AppMouseMenu {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = [System.Windows.Forms.Form]::new()
    $form.Text = "Windows 11 Cleaner - wybierz aplikacje"
    $form.StartPosition = "CenterScreen"
    $form.Size = [System.Drawing.Size]::new(560, 520)
    $form.MinimumSize = [System.Drawing.Size]::new(520, 420)

    $label = [System.Windows.Forms.Label]::new()
    $label.Text = "Zaznacz aplikacje do usuniecia:"
    $label.AutoSize = $true
    $label.Location = [System.Drawing.Point]::new(16, 16)
    $form.Controls.Add($label)

    $panel = [System.Windows.Forms.Panel]::new()
    $panel.Location = [System.Drawing.Point]::new(16, 48)
    $panel.Size = [System.Drawing.Size]::new(510, 350)
    $panel.Anchor = "Top,Bottom,Left,Right"
    $panel.AutoScroll = $true
    $form.Controls.Add($panel)

    $checkboxes = @()
    for ($index = 0; $index -lt $Apps.Count; $index++) {
        $checkbox = [System.Windows.Forms.CheckBox]::new()
        $checkbox.Text = "{0}. {1} ({2})" -f ($index + 1), $Apps[$index].Name, $Apps[$index].Category
        $checkbox.Checked = [bool]$Apps[$index].Selected
        $checkbox.AutoSize = $true
        $checkbox.Location = [System.Drawing.Point]::new(8, 8 + ($index * 30))
        $checkbox.Tag = $index
        $panel.Controls.Add($checkbox)
        $checkboxes += $checkbox
    }

    $okButton = [System.Windows.Forms.Button]::new()
    $okButton.Text = "Zapisz"
    $okButton.Size = [System.Drawing.Size]::new(100, 32)
    $okButton.Anchor = "Bottom,Right"
    $okButton.Location = [System.Drawing.Point]::new(318, 420)
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.Controls.Add($okButton)

    $cancelButton = [System.Windows.Forms.Button]::new()
    $cancelButton.Text = "Anuluj"
    $cancelButton.Size = [System.Drawing.Size]::new(100, 32)
    $cancelButton.Anchor = "Bottom,Right"
    $cancelButton.Location = [System.Drawing.Point]::new(426, 420)
    $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.Controls.Add($cancelButton)

    $form.AcceptButton = $okButton
    $form.CancelButton = $cancelButton

    if ($form.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        foreach ($checkbox in $checkboxes) {
            $Apps[[int]$checkbox.Tag].Selected = $checkbox.Checked
        }
    }
}

function Show-CategoryList {
    Show-Header -Title (T "CategoryTitle") -Subtitle (T "CategorySubtitle")
    Write-Host (T "CategoryHeader") -ForegroundColor Cyan
    Write-Host ""

    foreach ($category in $CategoryList) {
        Write-Host $category.Title -ForegroundColor $category.Color
        foreach ($item in $category.Items) {
            Write-Host " - $item"
        }
        Write-Host ""
    }

    Show-Footer
    Read-Host (T "PressEnter")
}

function Remove-AppPackageByName {
    param(
        [string]$DisplayName,
        [string[]]$PackageNames
    )

    Write-Host ""
    Write-Host "Usuwanie: $DisplayName" -ForegroundColor Yellow
    Write-Log "Start: $DisplayName"

    foreach ($packageName in $PackageNames) {
        $userPackages = Get-AppxPackage -AllUsers -Name $packageName -ErrorAction SilentlyContinue

        foreach ($package in $userPackages) {
            Write-Host "  Pakiet uzytkownika: $($package.PackageFullName)"
            Write-Log "Remove-AppxPackage: $($package.PackageFullName)"
            Remove-AppxPackage -Package $package.PackageFullName -AllUsers -ErrorAction SilentlyContinue
        }

        $provisionedPackages = Get-AppxProvisionedPackage -Online |
            Where-Object { $_.DisplayName -eq $packageName }

        foreach ($package in $provisionedPackages) {
            Write-Host "  Pakiet instalacyjny Windows: $($package.DisplayName)"
            Write-Log "Remove-AppxProvisionedPackage: $($package.PackageName)"
            Remove-AppxProvisionedPackage -Online -PackageName $package.PackageName -ErrorAction SilentlyContinue | Out-Null
        }
    }

    Write-Log "Koniec: $DisplayName"
}

function Invoke-SelectedAppRemoval {
    $selectedApps = @($Apps | Where-Object { $_.Selected })

    if ($selectedApps.Count -eq 0) {
        Write-Host ""
        Write-Host "Nic nie jest zaznaczone." -ForegroundColor Yellow
        Read-Host (T "PressEnter")
        return
    }

    Show-Header -Title (T "ConfirmTitle") -Subtitle (T "ConfirmSubtitle")
    Write-Host (T "WillRemove") -ForegroundColor Yellow
    foreach ($app in $selectedApps) {
        Write-Host " - $($app.Name)"
    }

    Write-Host ""
    if (-not (Confirm-Action -Message (T "ConfirmRemoveSelected"))) {
        Write-Host (T "ConfirmCancelled") -ForegroundColor Yellow
        Read-Host (T "PressEnter")
        return
    }

    foreach ($app in $selectedApps) {
        Remove-AppPackageByName -DisplayName $app.Name -PackageNames $app.Packages
    }

    Write-Host ""
    Write-Host "Gotowe. Szczegoly zapisane w logu." -ForegroundColor Green
    Read-Host (T "PressEnter")
}

function Uninstall-OneDrive {
    Write-Host ""
    Write-Host "Usuwanie OneDrive..." -ForegroundColor Yellow
    Write-Log "Start: OneDrive"

    $setupPaths = @(
        "$env:SystemRoot\System32\OneDriveSetup.exe",
        "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"
    )

    $setup = $setupPaths | Where-Object { Test-Path $_ } | Select-Object -First 1

    if (-not $setup) {
        Write-Host "Nie znaleziono OneDriveSetup.exe." -ForegroundColor Yellow
        Write-Log "OneDriveSetup.exe not found"
        return
    }

    Stop-Process -Name "OneDrive" -Force -ErrorAction SilentlyContinue
    Start-Process -FilePath $setup -ArgumentList "/uninstall" -Wait
    Write-Log "Koniec: OneDrive"
}

function Pause-WindowsUpdate {
    param([int]$Days)

    if ($Days -lt 1) {
        $Days = 1
    }

    Write-Host ""
    Write-Host "Pauzowanie Windows Update na $Days dni..." -ForegroundColor Yellow
    Write-Log "Start: Windows Update pause"

    $settingsPath = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
    $pauseEnd = (Get-Date).AddDays($Days).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

    New-Item -Path $settingsPath -Force | Out-Null
    New-ItemProperty -Path $settingsPath -Name "PauseUpdatesExpiryTime" -Value $pauseEnd -PropertyType String -Force | Out-Null
    New-ItemProperty -Path $settingsPath -Name "PauseFeatureUpdatesEndTime" -Value $pauseEnd -PropertyType String -Force | Out-Null
    New-ItemProperty -Path $settingsPath -Name "PauseQualityUpdatesEndTime" -Value $pauseEnd -PropertyType String -Force | Out-Null

    Write-Log "Windows Update paused until $pauseEnd"
}

function Disable-WindowsUpdateServices {
    param([string]$Reason)

    Write-Host ""
    Write-Host "Wylaczanie Windows Update..." -ForegroundColor Red
    Write-Log "Start: Windows Update disable. Reason: $Reason"

    $policyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
    New-Item -Path $policyPath -Force | Out-Null
    New-ItemProperty -Path $policyPath -Name "NoAutoUpdate" -Value 1 -PropertyType DWord -Force | Out-Null

    $services = @("wuauserv", "UsoSvc", "DoSvc", "BITS")
    foreach ($serviceName in $services) {
        $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
        if ($service) {
            Write-Host "  Blokowanie uslugi: $serviceName"
            Write-Log "Disabling service: $serviceName"
            Stop-Service -Name $serviceName -Force -ErrorAction SilentlyContinue
            Set-Service -Name $serviceName -StartupType Disabled -ErrorAction SilentlyContinue
        }
    }
}

function Register-WindowsUpdateGuard {
    param([int]$Days)

    if (-not (Test-Path -LiteralPath $WindowsUpdateGuardScriptPath)) {
        Write-Host "Brakuje pliku monitora: $WindowsUpdateGuardScriptPath" -ForegroundColor Red
        Write-Log "Guard script missing: $WindowsUpdateGuardScriptPath"
        return
    }

    $endTime = (Get-Date).AddDays($Days)
    $state = [ordered]@{
        EndTime = $endTime.ToString("o")
        CreatedAt = (Get-Date).ToString("o")
        Days = $Days
    }

    $state | ConvertTo-Json | Set-Content -LiteralPath $WindowsUpdateGuardStatePath -Encoding UTF8

    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$WindowsUpdateGuardScriptPath`""
    $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1)
    $trigger.Repetition.Interval = "PT5M"
    $trigger.Repetition.Duration = ("P{0}D" -f ($Days + 1))
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

    Unregister-ScheduledTask -TaskName $WindowsUpdateGuardTaskName -Confirm:$false -ErrorAction SilentlyContinue
    Register-ScheduledTask -TaskName $WindowsUpdateGuardTaskName -Action $action -Trigger $trigger -Settings $settings -RunLevel Highest -User "SYSTEM" -Force | Out-Null

    Write-Log "Guard registered until $endTime"
}

function Disable-WindowsUpdateForDays {
    param([int]$Days)

    if ($Days -lt 1) {
        $Days = 1
    }

    Pause-WindowsUpdate -Days $Days
    Disable-WindowsUpdateServices -Reason "temporary $Days days"
    Register-WindowsUpdateGuard -Days $Days

    Write-Host ""
    Write-Host "Windows Update jest zablokowany na $Days dni." -ForegroundColor Green
    Write-Host "Monitor bedzie sprawdzal stan co 5 minut i po restarcie systemu." -ForegroundColor Yellow
}

function Disable-WindowsUpdatePermanent {
    Disable-WindowsUpdateServices -Reason "permanent"
    Unregister-ScheduledTask -TaskName $WindowsUpdateGuardTaskName -Confirm:$false -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $WindowsUpdateGuardStatePath -Force -ErrorAction SilentlyContinue

    Write-Log "End: Windows Update permanent disable"
}

function Restore-WindowsUpdate {
    Write-Host ""
    Write-Host "Przywracanie Windows Update..." -ForegroundColor Yellow
    Write-Log "Start: Windows Update restore"

    $policyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
    Remove-ItemProperty -Path $policyPath -Name "NoAutoUpdate" -ErrorAction SilentlyContinue
    Unregister-ScheduledTask -TaskName $WindowsUpdateGuardTaskName -Confirm:$false -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $WindowsUpdateGuardStatePath -Force -ErrorAction SilentlyContinue

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
            Write-Host "  Przywracanie uslugi: $serviceName"
            Write-Log "Restoring service: $serviceName"
            Set-Service -Name $serviceName -StartupType Manual -ErrorAction SilentlyContinue
            Start-Service -Name $serviceName -ErrorAction SilentlyContinue
        }
    }

    Write-Log "End: Windows Update restore"
}

function Read-PauseDays {
    while ($true) {
        $inputDays = Read-Host "Na ile dni zapauzowac Windows Update?"
        $days = 0

        if ([int]::TryParse($inputDays, [ref]$days) -and $days -ge 1) {
            return $days
        }

        Write-Host "Wpisz liczbe dni, np. 30, 365 albo 730." -ForegroundColor Yellow
    }
}

function Invoke-RedOption {
    while ($true) {
        Show-Header -Title (T "RedTitle") -Subtitle (T "RedSubtitle")
        Write-Host (T "RedTitle") -ForegroundColor Red
        Write-Host ""
        Write-MenuOption -Key "1" -Text (T "RemoveOneDrive") -Color Yellow
        Write-MenuOption -Key "2" -Text (T "PauseUpdate") -Color Yellow
        Write-MenuOption -Key "3" -Text (T "DisableUpdate") -Color Red
        Write-MenuOption -Key "4" -Text (T "RestoreUpdate") -Color Green
        Write-MenuOption -Key "5" -Text (T "RemoveOneDrivePause") -Color Yellow
        Write-MenuOption -Key "0" -Text (T "Back") -Color DarkGray
        Show-Footer

        $choice = Read-Host (T "Choice")

        switch ($choice) {
            "1" {
                if (Confirm-Action -Message (T "ConfirmOneDrive")) {
                    Uninstall-OneDrive
                    Write-Host "Gotowe." -ForegroundColor Green
                    Read-Host (T "PressEnter")
                }
            }
            "2" {
                $days = Read-PauseDays
                if (Confirm-Action -Message ((T "ConfirmBlockUpdateDays") -f $days)) {
                    Disable-WindowsUpdateForDays -Days $days
                    Write-Host "Gotowe." -ForegroundColor Green
                    Read-Host (T "PressEnter")
                }
            }
            "3" {
                Write-Host ""
                Write-Host "To wylaczy automatyczne aktualizacje Windows Update na stale." -ForegroundColor Red
                Write-Host "Mozesz pozniej uzyc opcji 4, zeby przywrocic dzialanie." -ForegroundColor Yellow
                if (Confirm-Action -Message (T "ConfirmDisableUpdate")) {
                    Disable-WindowsUpdatePermanent
                    Write-Host "Gotowe." -ForegroundColor Green
                    Read-Host (T "PressEnter")
                }
            }
            "4" {
                if (Confirm-Action -Message (T "ConfirmRestoreUpdate")) {
                    Restore-WindowsUpdate
                    Write-Host "Gotowe." -ForegroundColor Green
                    Read-Host (T "PressEnter")
                }
            }
            "5" {
                $days = Read-PauseDays
                if (Confirm-Action -Message ((T "ConfirmOneDriveBlockUpdate") -f $days)) {
                    Uninstall-OneDrive
                    Disable-WindowsUpdateForDays -Days $days
                    Write-Host "Gotowe." -ForegroundColor Green
                    Read-Host (T "PressEnter")
                }
            }
            "0" { return }
            default {
                Write-Host (T "UnknownOption") -ForegroundColor Yellow
                Start-Sleep -Seconds 1
            }
        }
    }
}

function Show-LanguageMenu {
    while ($true) {
        Show-Header -Title (T "LanguageTitle") -Subtitle (T "LanguageSubtitle")
        Write-Host ("{0}: {1} ({2})" -f (T "CurrentLanguage"), $Script:CurrentLanguage, $Script:LanguageMode) -ForegroundColor DarkGray
        Write-Host ""
        Write-MenuOption -Key "1" -Text (T "AutoLanguage") -Color Cyan
        Write-MenuOption -Key "2" -Text (T "Polish") -Color Cyan
        Write-MenuOption -Key "3" -Text (T "English") -Color Cyan
        Write-MenuOption -Key "4" -Text (T "German") -Color Cyan
        Write-MenuOption -Key "0" -Text (T "Back") -Color DarkGray
        Show-Footer

        $choice = Read-Host (T "Choice")

        switch ($choice) {
            "1" { Set-AppLanguage -Language "auto"; return }
            "2" { Set-AppLanguage -Language "pl"; return }
            "3" { Set-AppLanguage -Language "en"; return }
            "4" { Set-AppLanguage -Language "de"; return }
            "0" { return }
            default {
                Write-Host (T "UnknownOption") -ForegroundColor Yellow
                Start-Sleep -Seconds 1
            }
        }
    }
}

function Show-MainMenu {
    while ($true) {
        Show-Header -Title (T "MainTitle") -Subtitle (T "MainSubtitle")
        Write-Host (T "Menu") -ForegroundColor Cyan
        Write-MenuOption -Key "1" -Text (T "PickApps") -Color Cyan
        Write-MenuOption -Key "2" -Text (T "RedOption") -Color Red
        Write-MenuOption -Key "3" -Text (T "RemoveSelected") -Color Yellow
        Write-MenuOption -Key "4" -Text (T "ShowCategories") -Color Cyan
        Write-MenuOption -Key "5" -Text (T "LanguageMenu") -Color Cyan
        Write-MenuOption -Key "0" -Text (T "Exit") -Color DarkGray
        Write-Host ""

        $selectedCount = @($Apps | Where-Object { $_.Selected }).Count
        Write-Host ("{0}: {1}" -f (T "SelectedApps"), $selectedCount) -ForegroundColor DarkGray
        Show-Footer

        $choice = Read-Host (T "Choice")

        switch ($choice) {
            "1" { Show-AppMenu }
            "2" { Invoke-RedOption }
            "3" { Invoke-SelectedAppRemoval }
            "4" { Show-CategoryList }
            "5" { Show-LanguageMenu }
            "0" { return }
            default {
                Write-Host (T "UnknownOption") -ForegroundColor Yellow
                Start-Sleep -Seconds 1
            }
        }
    }
}

Restart-AsAdmin
Write-Log "Program started"
Show-MainMenu
Write-Log "Program closed"
Write-Host ""
Write-Host "Program zamkniety. Mozesz zamknac to okno." -ForegroundColor DarkGray
Read-Host "Enter aby zamknac"

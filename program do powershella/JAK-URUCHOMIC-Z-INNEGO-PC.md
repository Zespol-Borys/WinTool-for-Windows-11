# Jak uruchomic WinTool na innym PC

## Wariant 1: instalator z internetu

Wrzuć pliki na GitHub albo inny hosting jako pliki RAW:

- `install.ps1`
- `Windows11-Cleaner.ps1`
- `WinTool-WindowsUpdateGuard.ps1`
- `LISTA-KATEGORIE.md`

W pliku `install.ps1` podmien:

```powershell
https://TU-WKLEJ-LINK-DO-FOLDERU-RAW/WinTool
```

na prawdziwy link, np.:

```powershell
https://raw.githubusercontent.com/nazwa/repo/main
```

Potem na innym PC uruchom PowerShell jako administrator i wpisz:

```powershell
irm "LINK_DO_RAW_INSTALL.PS1" | iex
```

## Wariant 2: z parametrem bez edycji install.ps1

Mozna tez uruchomic instalator z podanym linkiem bazowym:

```powershell
iex "& { $(irm 'LINK_DO_RAW_INSTALL.PS1') } -SourceBaseUrl 'LINK_DO_FOLDERU_RAW'"
```

Przyklad:

```powershell
iex "& { $(irm 'https://raw.githubusercontent.com/nazwa/repo/main/install.ps1') } -SourceBaseUrl 'https://raw.githubusercontent.com/nazwa/repo/main'"
```

## Co robi instalator

- tworzy folder `C:\WinTool`
- pobiera pliki programu
- uruchamia `Windows11-Cleaner.ps1`
- prosi o administratora, jesli trzeba

# Jak uruchomic WinTool na innym PC

## Gotowa komenda

Na innym PC uruchom PowerShell jako administrator i wpisz:

```powershell
irm "https://raw.githubusercontent.com/Zespol-Borys/WinTool-for-Windows-11/main/program%20do%20powershella/install.ps1" | iex
```

## Wariant 1: instalator z internetu

Pliki programu sa pobierane z:

```powershell
https://raw.githubusercontent.com/Zespol-Borys/WinTool-for-Windows-11/main/program%20do%20powershella
```

## Wariant 2: z parametrem bez edycji install.ps1

Mozna tez uruchomic instalator z podanym linkiem bazowym:

```powershell
iex "& { $(irm 'LINK_DO_RAW_INSTALL.PS1') } -SourceBaseUrl 'LINK_DO_FOLDERU_RAW'"
```

Przyklad:

```powershell
iex "& { $(irm 'https://raw.githubusercontent.com/Zespol-Borys/WinTool-for-Windows-11/main/program%20do%20powershella/install.ps1') } -SourceBaseUrl 'https://raw.githubusercontent.com/Zespol-Borys/WinTool-for-Windows-11/main/program%20do%20powershella'"
```

## Co robi instalator

- tworzy folder `C:\WinTool`
- pobiera pliki programu
- uruchamia `Windows11-Cleaner.ps1`
- prosi o administratora, jesli trzeba

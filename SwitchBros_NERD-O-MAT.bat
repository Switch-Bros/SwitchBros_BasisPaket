@ECHO OFF
mode con: cols=106 lines=32
SETLOCAL ENABLEDELAYEDEXPANSION
chcp 1252 >nul 2>&1
title SwitchBros. NERD-O-MAT
REM Dieses Skript basiert auf der Batch-Datei von rashevskyv's Kefir Paket der ebenfalls Entwickler von DBI ist!
REM RIESEN DANK!!! an diesen tollen Entwickler!
REM Dieses Skript wurde um einiges erweitert, ergänzt und verbessert!

COLOR 0E
set wd=%temp%\sdfiles
set clear=0
set cfw=AMS
set cfwname=Atmosphere
set theme_flag=0
set theme=0
set ftpd=0
set fizeau=0
set icograb=0
set sd=%1
REM if not defined %sd% (GOTO hauptmenue)

REM ============================================================
:willkommen
type "%~dp0SwitchBros.txt"
pause>nul 2>&1

REM ============================================================
:neuekarte
COLOR 0C
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo                            _-== WARNUNG - WARNUNG - WARNUNG - WARNUNG ==-_
echo.
echo      Wenn du dieses Skript (NERD-O-MAT.bat) von deiner SD-Karte aus gestartet hast, dann
echo          SCHLIESSE es bitte SOFORT^^! NICHT von SD-Karte aus starten^^!
echo.
echo      Bitte starte die NERD-O-MAT.bat ^>NUR^< aus dem "BasisPaket" Ordner von deinem PC^^!
echo.
echo =====================================================================================================
echo.
echo      Hast du dieses Skript aus dem "SwitchBros_BasisPaket" heraus gestartet, dann gib jetzt
echo      bitte ^>NUR^< den Laufwerksbuchstaben deiner SD-Karte ein^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

for /f "usebackq delims=" %%a in (`powershell -command "$ErrorActionPreference='Stop'; $sd = Get-WmiObject -Class Win32_Volume | Where-Object {$_.DriveType -eq 2}; foreach ($s in $sd) { 'Laufwerksbuchstabe: {0}' -f $s.DriveLetter; if ($s.Label) { 'Laufwerk: {0}' -f $s.Label }; 'Dateisystem: {0}' -f $s.FileSystem; $size = [math]::Round($s.Capacity / 1GB, 2); if ($size -ge 1) { 'Größe: {0} GB' -f $size } else { 'Größe: {0} MB' -f ($s.Capacity / 1MB) }; 'Belegt: {0} GB' -f ([math]::Round(($s.Capacity - $s.FreeSpace) / 1GB, 2)); 'Frei: {0} GB' -f ([math]::Round($s.FreeSpace / 1GB, 2)) }"`) do (
    echo %%a
)

echo.

set /p "sd=     Bitte gib den Laufwerksbuchstaben der SD-Karte an: "

if not exist "%sd%:\" (
	set word=      Es befindet sich keine SD-Karte im Laufwerk %sd%         
	GOTO falschesdkarte
) else (
	if not exist "%sd%:\*" (
	  GOTO falschesdkarte
	  )
)

REM ============================================================
:modchip
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Wenn du einen Modchip in deiner Konsole hast, dann gib es bitte hier an^^!
echo.
echo      0 = Nein, ich habe keinen Modchip verbaut
echo      1 = Ja, ich habe einen Modchip verbaut (v2, lite, OLED)
echo      2 = Ja, ich habe einen trinketm0 in meiner v1
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set /p modchip="     Ist ein Modchip verbaut: "
if "%modchip%"=="0" SET bootdat=0
if "%modchip%"=="1" SET bootdat=1
if "%modchip%"=="2" SET bootdat=2

REM ============================================================
:datensichern
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Backups einiger Dateien werden erstellt^^!
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set "BackupFolder=%sd%:\Backup"
set "SBBAK=%BackupFolder%\SB"

if not exist "%SBBAK%" (
    mkdir "%SBBAK%" >nul 2>&1
)

set "folders=bootloader fastCFWSwitch Fizeau IconGrabber ftpd sys-ftpd tinfoil bootlogo DBI"

for %%i in (%folders%) do (
    if not exist "%SBBAK%\%%i" (
        mkdir "%SBBAK%\%%i" >nul 2>&1
    )
)

xcopy /I /Y "%sd%:\bootloader\hekate_ipl.ini" "%SBBAK%\bootloader\" >nul 2>&1
xcopy /I /Y "%sd%:\bootloader\nyx.ini" "%SBBAK%\bootloader\" >nul 2>&1
xcopy /I /Y "%sd%:\config\fastCFWSwitch\config.ini" "%SBBAK%\fastCFWSwitch\" >nul 2>&1
xcopy /I /Y "%sd%:\config\Fizeau\config.ini" "%SBBAK%\Fizeau\" >nul 2>&1
xcopy /I /Y "%sd%:\config\IconGrabber\config.json" "%SBBAK%\IconGrabber\" >nul 2>&1
xcopy /I /Y "%sd%:\config\ftpd\ftpd.cfg" "%SBBAK%\ftpd\" >nul 2>&1
xcopy /I /Y "%sd%:\config\sys-ftpd\config.ini" "%SBBAK%\sys-ftpd\" >nul 2>&1
xcopy /I /Y "%sd%:\switch\tinfoil\locations.conf" "%SBBAK%\tinfoil\" >nul 2>&1
xcopy /I /Y "%sd%:\switch\tinfoil\options.json" "%SBBAK%\tinfoil\" >nul 2>&1
xcopy /I /Y "%sd%:\atmosphere\exefs_patches\bootlogo\*" "%SBBAK%\bootlogo\" >nul 2>&1
xcopy /I /Y "%sd%:\switch\DBI\dbi.config" "%SBBAK%\DBI\" >nul 2>&1

REM ============================================================
:hauptmenue
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      1 = SD-Karte bereinigen/einrichten und zum SwitchBros. Paket wechseln^^!
echo          Das GANZE Skript komplett durchgehen wenn du die CFW zum ersten Mal aufsetzt, wenn du von
echo          einem anderen Paket kommst, oder wenn es sich um eine neue SD-Karte handelt^^! DANKE^^!
echo.
echo =====================================================================================================
echo.
echo      2 = Systeme (Linux, LAKKA, Android)^^!
echo.
echo      3 = Backup Ordner anlegen^^!
echo.
echo      4 = Kinder-Modus^^!
echo.
echo      5 = SteamAPI fuer IconGrabber App holen und eingeben^^!
echo.
echo      6 = Tesla-Overlay Menue^^!
echo.
echo      7 = Zusatz Apps^^!
echo.
echo      8 = fix ArchiveBit^^!
echo.
echo      9 = USB3 Speed eintragen^^!
echo.
echo.
echo      F = Unsicher, altes Paket behalten                             B = Dieses Skript Beenden
echo.     
echo -----------------------------------------------------------------------------------------------------
echo.

set /p neuistgut="     Bitte gib deine Auswahl ein: "
if "%neuistgut%"=="1" GOTO sbgibgas
if "%neuistgut%"=="2" GOTO systempartitionen
if "%neuistgut%"=="3" GOTO backupordner
if "%neuistgut%"=="4" GOTO kindgerecht
if "%neuistgut%"=="5" GOTO themepaket
if "%neuistgut%"=="6" GOTO systemmodule
if "%neuistgut%"=="7" GOTO zusatzapps
if "%neuistgut%"=="8" GOTO attributeundmac
if "%neuistgut%"=="9" GOTO hekateusb
if /i "%neuistgut%"=="F" GOTO endefeige
if /i "%neuistgut%"=="B" GOTO endemutig

REM ============================================================
:backupordner
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Bevor es losgeht, kann das Script fuer dich Backup-Ordner erstellen in denen du spaeter die
echo      Backups von hekate einfuegen kannst = (BOOT0, BOOT1 und RAW GPP - Keys, etc.)
echo.
echo      Die erstellten Backups von hekate sind nicht gerade klein^^!
echo      Gib bitte ein Laufwerk an (NICHT deine SD-Karte), dass ueber ausreichend freien Speicherplatz
echo      verfuegt (ca. 35GB fuer v1, v2 und lite bzw. 65GB fuer OLED Konsolen)!
echo.
echo      Folgende (leere) Ordner werden im angegebenen Laufwerk, auf deinem PC, fuer dich angelegt:
echo.             
echo      - SwitchBackup
echo        - sysNAND (fuer BOOT0, BOOT1 und RAW GPP)
echo        - Enigma
echo          - Prodkeys-Devkeys (prod.keys und dev.keys)
echo          - Partial_AES_Keys (partial_aes.keys (Mariko Chip))
echo          - Amiibo_Keys
echo        - SD-Karten_Backup (CFW eingerichtet = Ein Backup davon)
echo.
echo      Brauchst du die Ordner nicht dann druecke nur die Eingabetaste^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set "LW="
set /P ="     Bitte gib einen gueltigen Laufwerksbuchstaben ein: "

if defined LW (
 (
    md "%LW%:\SwitchBackup\sysNAND"
    md "%LW%:\SwitchBackup\Enigma\Prodkeys-Devkeys"
    md "%LW%:\SwitchBackup\Enigma\Partial_AES_Keys"
    md "%LW%:\SwitchBackup\Enigma\Amiibo_Keys"
    md "%LW%:\SwitchBackup\SD-Karten_Backup"
  ) 2>nul
	COLOR 0E
	cls
	echo.
	echo -----------------------------------------------------------------------------------------------------
	echo.
	echo      Die Ordner fuer deine Backups wurden im Laufwerk "%LW%:\" erstellt
	echo.
	echo      Beliebige Taste um zum Hauptmenue zurueckzukehren^^!
	echo.
	echo -----------------------------------------------------------------------------------------------------
	echo.
	pause>nul 2>&1
	GOTO hauptmenue
) else (
    GOTO hauptmenue
)

REM ============================================================
:endefeige
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo                                    JA GENAU, HAU DOCH AB DU LUTSCHA^^!^^!^^!
echo.
echo                                     BLEIB BEI DEINEM BLOEDEN PAKET^^!
echo                           ZIEHE NICHT UEBER LOS^^! UND STREICHE KEINE 2000 EURO EIN^^!
echo.
echo.
echo.
echo      Das Programm schliesst sich von selbst, falls du zu bloed bist die Eingabetaste zu druecken^^!^^!^^!
echo -----------------------------------------------------------------------------------------------------
echo.

if exist "%wd%" (RD /s /q "%wd%\*")
pause>nul 2>&1
exit

REM ======= ATMOSPHERE ORDNER ==================================
:sbgibgas
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo           Deine SD-Karte wird jetzt vorbereitet und alle dafuer Notwendigen Daten geloescht^^!
echo.
echo.
echo.
echo      BITTE WARTEN...
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

if exist "%sd%:\atmosphere\titles" (rename %sd%:\atmosphere\titles contents)
if exist "%sd%:\atmosphere\title" (rename %sd%:\atmosphere\title contents)
if exist "%sd%:\atmosphere\content" (rename %sd%:\atmosphere\content contents)

if exist "%sd%:\atmosphere\config" (RD /s /q "%sd%:\atmosphere\config")
if exist "%sd%:\atmosphere\config_templates" (RD /s /q "%sd%:\atmosphere\config_templates")
if exist "%sd%:\atmosphere\erpt_reports" (RD /s /q "%sd%:\atmosphere\erpt_reports")
if exist "%sd%:\atmosphere\crash_reports" (RD /s /q "%sd%:\atmosphere\crash_reports")
if exist "%sd%:\atmosphere\exefs_patches" (RD /s /q "%sd%:\atmosphere\exefs_patches")
if exist "%sd%:\atmosphere\extras" (RD /s /q "%sd%:\atmosphere\extras")
if exist "%sd%:\atmosphere\fatal_errors" (RD /s /q "%sd%:\atmosphere\fatal_errors")
if exist "%sd%:\atmosphere\fatal_reports" (RD /s /q "%sd%:\atmosphere\fatal_reports")
if exist "%sd%:\atmosphere\flags" (RD /s /q "%sd%:\atmosphere\flags")
if exist "%sd%:\atmosphere\hosts" (RD /s /q  "%sd%:\atmosphere\hosts")
if exist "%sd%:\atmosphere\kips" (RD /s /q  "%sd%:\atmosphere\kips")
if exist "%sd%:\atmosphere\kip_patches" (RD /s /q "%sd%:\atmosphere\kip_patches")
if exist "%sd%:\atmosphere\hekate_kips" (RD /s /q "%sd%:\atmosphere\hekate_kips")
if exist "%sd%:\atmosphere\logs" (RD /s /q  "%sd%:\atmosphere\logs")
if exist "%sd%:\atmosphere\update" (RD /s /q  "%sd%:\atmosphere\update")

if exist "%sd%:\atmosphere\package3" (del "%sd%:\atmosphere\package3")
if exist "%sd%:\atmosphere\*.bin" (del "%sd%:\atmosphere\*.bin")
if exist "%sd%:\atmosphere\*.nsp" (del "%sd%:\atmosphere\*.nsp")
if exist "%sd%:\atmosphere\*.romfs" (del "%sd%:\atmosphere\*.romfs")
if exist "%sd%:\atmosphere\*.sig" (del "%sd%:\atmosphere\*.sig")
if exist "%sd%:\atmosphere\*.json" (del "%sd%:\atmosphere\*.json")
if exist "%sd%:\atmosphere\*.ini" (del "%sd%:\atmosphere\*.ini")

REM ======= ATMOSPHERE CONTENTS ORDNER =========================
if exist "%sd%:\atmosphere\contents\0100000000000008" (RD /s /q "%sd%:\atmosphere\contents\0100000000000008")
if exist "%sd%:\atmosphere\contents\010000000000100B" (RD /s /q "%sd%:\atmosphere\contents\010000000000100B")
if exist "%sd%:\atmosphere\contents\010000000000000D" (RD /s /q "%sd%:\atmosphere\contents\010000000000000D")
if exist "%sd%:\atmosphere\contents\010000000000002b" (RD /s /q "%sd%:\atmosphere\contents\010000000000002b")
if exist "%sd%:\atmosphere\contents\0100000000000032" (RD /s /q "%sd%:\atmosphere\contents\0100000000000032")
if exist "%sd%:\atmosphere\contents\0100000000000034" (RD /s /q "%sd%:\atmosphere\contents\0100000000000034")
if exist "%sd%:\atmosphere\contents\0100000000000036" (RD /s /q "%sd%:\atmosphere\contents\0100000000000036")
if exist "%sd%:\atmosphere\contents\0100000000000037" (RD /s /q "%sd%:\atmosphere\contents\0100000000000037")
if exist "%sd%:\atmosphere\contents\010000000000003C" (RD /s /q "%sd%:\atmosphere\contents\010000000000003C")
if exist "%sd%:\atmosphere\contents\0100000000000042" (RD /s /q "%sd%:\atmosphere\contents\0100000000000042")
if exist "%sd%:\atmosphere\contents\010000000000100C" (RD /s /q "%sd%:\atmosphere\contents\010000000000100C")
if exist "%sd%:\atmosphere\contents\010000000000100D" (RD /s /q "%sd%:\atmosphere\contents\010000000000100D")
if exist "%sd%:\atmosphere\contents\0100000000001000" (RD /s /q "%sd%:\atmosphere\contents\0100000000001000")
if exist "%sd%:\atmosphere\contents\0100000000001013" (RD /s /q "%sd%:\atmosphere\contents\0100000000001013")

if exist "%sd%:\atmosphere\contents\0000000000534C56" (RD /s /q "%sd%:\atmosphere\contents\0000000000534C56")
if exist "%sd%:\atmosphere\contents\00FF0000000002AA" (RD /s /q "%sd%:\atmosphere\contents\00FF0000000002AA")
if exist "%sd%:\atmosphere\contents\00FF0000636C6BF2" (RD /s /q "%sd%:\atmosphere\contents\00FF0000636C6BF2")
if exist "%sd%:\atmosphere\contents\00FF0000636C6BFF" (RD /s /q "%sd%:\atmosphere\contents\00FF0000636C6BFF")
if exist "%sd%:\atmosphere\contents\00FF00006D7470FF" (RD /s /q "%sd%:\atmosphere\contents\00FF00006D7470FF")
if exist "%sd%:\atmosphere\contents\00FF0000A53BB665" (RD /s /q "%sd%:\atmosphere\contents\00FF0000A53BB665")
if exist "%sd%:\atmosphere\contents\00FF0012656180FF" (RD /s /q "%sd%:\atmosphere\contents\00FF0012656180FF")
if exist "%sd%:\atmosphere\contents\01FF415446660000" (RD /s /q "%sd%:\atmosphere\contents\01FF415446660000")
if exist "%sd%:\atmosphere\contents\00FF747765616BFF" (RD /s /q "%sd%:\atmosphere\contents\00FF747765616BFF")
if exist "%sd%:\atmosphere\contents\0100000000000052" (RD /s /q "%sd%:\atmosphere\contents\0100000000000052")
if exist "%sd%:\atmosphere\contents\0100000000000081" (RD /s /q "%sd%:\atmosphere\contents\0100000000000081")
if exist "%sd%:\atmosphere\contents\0100000000000352" (RD /s /q "%sd%:\atmosphere\contents\0100000000000352")
if exist "%sd%:\atmosphere\contents\0100000000000464" (RD /s /q "%sd%:\atmosphere\contents\0100000000000464")
if exist "%sd%:\atmosphere\contents\0100000000000523" (RD /s /q "%sd%:\atmosphere\contents\0100000000000523")
if exist "%sd%:\atmosphere\contents\0100000000000901" (RD /s /q "%sd%:\atmosphere\contents\0100000000000901")
if exist "%sd%:\atmosphere\contents\0100000000000BED" (RD /s /q "%sd%:\atmosphere\contents\0100000000000BED")
if exist "%sd%:\atmosphere\contents\0100000000000BEF" (RD /s /q "%sd%:\atmosphere\contents\0100000000000BEF")
if exist "%sd%:\atmosphere\contents\0100000000000DAD" (RD /s /q "%sd%:\atmosphere\contents\0100000000000DAD")
if exist "%sd%:\atmosphere\contents\0100000000000F12" (RD /s /q "%sd%:\atmosphere\contents\0100000000000F12")
if exist "%sd%:\atmosphere\contents\0100000000000FAF" (RD /s /q "%sd%:\atmosphere\contents\0100000000000FAF")
if exist "%sd%:\atmosphere\contents\0100000000006480" (RD /s /q "%sd%:\atmosphere\contents\0100000000006480")
if exist "%sd%:\atmosphere\contents\0100000000007200" (RD /s /q "%sd%:\atmosphere\contents\0100000000007200")
if exist "%sd%:\atmosphere\contents\010000000000bd00" (RD /s /q "%sd%:\atmosphere\contents\010000000000bd00")
if exist "%sd%:\atmosphere\contents\010000000000C235" (RD /s /q "%sd%:\atmosphere\contents\010000000000C235")
if exist "%sd%:\atmosphere\contents\010000000000f00f" (RD /s /q "%sd%:\atmosphere\contents\010000000000f00f")
if exist "%sd%:\atmosphere\contents\010000000000FFAB" (RD /s /q "%sd%:\atmosphere\contents\010000000000FFAB")
if exist "%sd%:\atmosphere\contents\01000000001ED1ED" (RD /s /q "%sd%:\atmosphere\contents\01000000001ED1ED")
if exist "%sd%:\atmosphere\contents\0532232232232000" (RD /s /q "%sd%:\atmosphere\contents\0532232232232000")
if exist "%sd%:\atmosphere\contents\054e4f4558454000" (RD /s /q "%sd%:\atmosphere\contents\054e4f4558454000")
if exist "%sd%:\atmosphere\contents\2200000000000100" (RD /s /q "%sd%:\atmosphere\contents\2200000000000100")
if exist "%sd%:\atmosphere\contents\4100000000000324" (RD /s /q "%sd%:\atmosphere\contents\4100000000000324")
if exist "%sd%:\atmosphere\contents\4200000000000000" (RD /s /q "%sd%:\atmosphere\contents\4200000000000000")
if exist "%sd%:\atmosphere\contents\420000000000000E" (RD /s /q "%sd%:\atmosphere\contents\420000000000000E")
if exist "%sd%:\atmosphere\contents\420000000000000F" (RD /s /q "%sd%:\atmosphere\contents\420000000000000F")
if exist "%sd%:\atmosphere\contents\4200000000000010" (RD /s /q "%sd%:\atmosphere\contents\4200000000000010")
if exist "%sd%:\atmosphere\contents\4200000000000811" (RD /s /q "%sd%:\atmosphere\contents\4200000000000811")
if exist "%sd%:\atmosphere\contents\4200000000000BA6" (RD /s /q "%sd%:\atmosphere\contents\4200000000000BA6")
if exist "%sd%:\atmosphere\contents\4200000000000FFF" (RD /s /q "%sd%:\atmosphere\contents\4200000000000FFF")
if exist "%sd%:\atmosphere\contents\010000000007E51A" (RD /s /q "%sd%:\atmosphere\contents\010000000007E51A")
if exist "%sd%:\atmosphere\contents\420000000007E51A" (RD /s /q "%sd%:\atmosphere\contents\420000000007E51A")
if exist "%sd%:\atmosphere\contents\4200000000474442" (RD /s /q "%sd%:\atmosphere\contents\4200000000474442")
if exist "%sd%:\atmosphere\contents\4200000000696969" (RD /s /q "%sd%:\atmosphere\contents\4200000000696969")
if exist "%sd%:\atmosphere\contents\4200000AF1E8DA89" (RD /s /q "%sd%:\atmosphere\contents\4200000AF1E8DA89")
if exist "%sd%:\atmosphere\contents\42000062616B6101" (RD /s /q "%sd%:\atmosphere\contents\42000062616B6101")
if exist "%sd%:\atmosphere\contents\4200736372697074" (RD /s /q "%sd%:\atmosphere\contents\4200736372697074")
if exist "%sd%:\atmosphere\contents\4206900000000012" (RD /s /q "%sd%:\atmosphere\contents\4206900000000012")
if exist "%sd%:\atmosphere\contents\430000000000000A" (RD /s /q "%sd%:\atmosphere\contents\430000000000000A")
if exist "%sd%:\atmosphere\contents\430000000000000B" (RD /s /q "%sd%:\atmosphere\contents\430000000000000B")
if exist "%sd%:\atmosphere\contents\430000000000000C" (RD /s /q "%sd%:\atmosphere\contents\430000000000000C")
if exist "%sd%:\atmosphere\contents\43000000000000FF" (RD /s /q "%sd%:\atmosphere\contents\43000000000000FF")
if exist "%sd%:\atmosphere\contents\4300000000000909" (RD /s /q "%sd%:\atmosphere\contents\4300000000000909")
if exist "%sd%:\atmosphere\contents\5600000000000000" (RD /s /q "%sd%:\atmosphere\contents\5600000000000000")
if exist "%sd%:\atmosphere\contents\690000000000000D" (RD /s /q "%sd%:\atmosphere\contents\690000000000000D")

REM ======= BOOTLOADER ORDNER ==================================
if exist "%sd%:\bootloader\debug" (RD /s /q "%sd%:\bootloader\debug")
if exist "%sd%:\bootloader\sys" (RD /s /q "%sd%:\bootloader\sys")
if exist "%sd%:\bootloader\*.bmp" (del "%sd%:\bootloader\*.bmp")
if exist "%sd%:\bootloader\*.ini" (del "%sd%:\bootloader\*.ini")
if exist "%sd%:\bootloader\nyx.ini_" (del "%sd%:\bootloader\nyx.ini")
if exist "%sd%:\bootloader\*.bin" (del "%sd%:\bootloader\*.bin")
if exist "%sd%:\bootloader\*.sig" (del "%sd%:\bootloader\*.sig")

if exist "%sd%:\bootloader\payloads\hekate_ctcaer_*.bin" (del "%sd%:\bootloader\payloads\hekate_ctcaer_*.bin")
if exist "%sd%:\bootloader\payloads\Atmosphere.bin" (del "%sd%:\bootloader\payloads\Atmosphere.bin")
if exist "%sd%:\bootloader\payloads\Incognito*.bin" (del "%sd%:\bootloader\payloads\Incognito*.bin")
if exist "%sd%:\bootloader\payloads\fusee-primary-payload.bin" (del "%sd%:\bootloader\payloads\fusee-primary-payload.bin")
if exist "%sd%:\bootloader\payloads\biskeydump.bin" (del "%sd%:\bootloader\payloads\biskeydump.bin")
if exist "%sd%:\bootloader\payloads\fusee-payload.bin" (del "%sd%:\bootloader\payloads\fusee-payload.bin")
if exist "%sd%:\bootloader\payloads\fusee-primary.bin" (del "%sd%:\bootloader\payloads\fusee-primary.bin")
if exist "%sd%:\bootloader\payloads\sxos.bin" (del "%sd%:\bootloader\payloads\sxos.bin")
if exist "%sd%:\bootloader\payloads\rajnx_ipl.bin" (del "%sd%:\bootloader\payloads\rajnx_ipl.bin")
if exist "%sd%:\bootloader\payloads\prodinfo_gen.bin" (del "%sd%:\bootloader\payloads\prodinfo_gen.bin")
if exist "%sd%:\bootloader\payloads\.bin" (del "%sd%:\bootloader\payloads\TegraExplorer306.bin")

if exist "%sd%:\bootloader\ini\!kefir_updater.ini" (del "%sd%:\bootloader\ini\!kefir_updater.ini")
if exist "%sd%:\bootloader\ini\kefir_updater.ini" (del "%sd%:\bootloader\ini\kefir_updater.ini")
if exist "%sd%:\bootloader\ini\fullstock.ini" (del "%sd%:\bootloader\ini\fullstock.ini")
if exist "%sd%:\bootloader\ini\Atmosphere.ini" (del "%sd%:\bootloader\ini\Atmosphere.ini")
if exist "%sd%:\bootloader\ini\sxos.ini" (del "%sd%:\bootloader\ini\sxos.ini")
if exist "%sd%:\bootloader\ini\hekate_keys.ini" (del "%sd%:\bootloader\ini\hekate_keys.ini")
if exist "%sd%:\bootloader\ini\RajNX.ini" (del "%sd%:\bootloader\ini\RajNX.ini")

if exist "%sd%:\bootloader\res\icon_payload.bmp" (del "%sd%:\bootloader\res\icon_payload.bmp")
if exist "%sd%:\bootloader\res\icon_payload_nobox.bmp" (del "%sd%:\bootloader\res\icon_payload_nobox.bmp")
if exist "%sd%:\bootloader\res\icon_switch.bmp" (del "%sd%:\bootloader\res\icon_switch.bmp")
if exist "%sd%:\bootloader\res\icon_switch_nobox.bmp" (del "%sd%:\bootloader\res\icon_switch_nobox.bmp")
if exist "%sd%:\bootloader\res\icon_ams_nobox.bmp" (del "%sd%:\bootloader\res\icon_ams_nobox.bmp")
if exist "%sd%:\bootloader\res\icon_lockpick_nobox.bmp" (del "%sd%:\bootloader\res\icon_lockpick_nobox.bmp")
if exist "%sd%:\bootloader\res\icon_lockpick.bmp" (del "%sd%:\bootloader\res\icon_lockpick.bmp")
if exist "%sd%:\bootloader\res\l4t.bmp" (del "%sd%:\bootloader\res\l4t.bmp")
if exist "%sd%:\bootloader\res\l4t_nobox.bmp" (del "%sd%:\bootloader\res\l4t_nobox.bmp")
if exist "%sd%:\bootloader\res\Majoras_nobox.bmp" (del "%sd%:\bootloader\res\Majoras_nobox.bmp")
if exist "%sd%:\bootloader\res\Majoras.bmp" (del "%sd%:\bootloader\res\Majoras.bmp")
if exist "%sd%:\bootloader\res\Switchroot Android_nobox.bmp" (del "%sd%:\bootloader\res\Switchroot Android_nobox.bmp")
if exist "%sd%:\bootloader\res\Switchroot Android 10.bmp" (del "%sd%:\bootloader\res\Switchroot Android 10.bmp")
if exist "%sd%:\bootloader\res\Zahnrad_nobox.bmp" (del "%sd%:\bootloader\res\Zahnrad_nobox.bmp")
if exist "%sd%:\bootloader\res\Zahnrad.bmp" (del "%sd%:\bootloader\res\Zahnrad.bmp")
if exist "%sd%:\bootloader\res\icon_lockpick.bmp" (del "%sd%:\bootloader\res\icon_lockpick.bmp")
if exist "%sd%:\bootloader\res\icon_tegraexplorer.bmp" (del "%sd%:\bootloader\res\icon_tegraexplorer.bmp")

REM ======= CONFIG ORDNER ======================================
if exist "%sd%:\config\fw-downloader" (RD /s /q "%sd%:\config\fw-downloader")
if exist "%sd%:\config\luigi-theme-updater" (RD /s /q "%sd%:\config\luigi-theme-updater")
if exist "%sd%:\config\mario-theme-updater" (RD /s /q "%sd%:\config\mario-theme-updater")
if exist "%sd%:\config\sys-ftpd" (RD /s /q "%sd%:\config\sys-ftpd")
if exist "%sd%:\config\aio-switch-updater" (RD /s /q "%sd%:\config\\aio-switch-updater")
if exist "%sd%:\config\btred" (RD /s /q "%sd%:\config\btred")
if exist "%sd%:\config\aio-switch-updater" (RD /s /q "%sd%:\config\aio-switch-updater")
if exist "%sd%:\config\BootSoundNX" (RD /s /q "%sd%:\config\BootSoundNX")
if exist "%sd%:\config\cheats-updater" (RD /s /q "%sd%:\config\cheats-updater")
if exist "%sd%:\config\fastCFWSwitch" (RD /s /q "%sd%:\config\fastCFWSwitch")
if exist "%sd%:\config\Fizeau" (RD /s /q "%sd%:\config\Fizeau")
if exist "%sd%:\config\sys-clk" (RD /s /q "%sd%:\config\sys-clk")
if exist "%sd%:\config\sys-con" (RD /s /q "%sd%:\config\sys-con")
if exist "%sd%:\config\tesla" (RD /s /q "%sd%:\config\tesla")

REM ======= THEMES ORDNER ======================================
if exist "%sd%:\themes\systemData" (RD /s /q "%sd%:\themes\systemData")
if exist "%sd%:\themes\Ryu Hayabusa" (RD /s /q "%sd%:\themes\Ryu Hayabusa")

if exist "%sd%:\bootloader" (RD /s /q "%sd%:\bootloader")
if exist "%sd%:\config" (RD /s /q "%sd%:\config")
if exist "%sd%:\switch" (RD /s /q "%sd%:\switch")
if exist "%sd%:\themes" (RD /s /q "%sd%:\themes")

FOR /D /R "%sd%:\" %%X IN (amsPACK*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (kefir*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (ShallowSea*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (DeepSea*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (reinx*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (firmware*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (sxos*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (custom*) DO RD /S /Q "%%X"

REM ======= SD-KARTEN ROOT =====================================
if exist "%sd%:\tegraexplorer" (RD /s /q "%sd%:\tegraexplorer")
if exist "%sd%:\modules" (RD /s /q "%sd%:\modules")
if exist "%sd%:\NSPs" (RD /s /q "%sd%:\NSPs")
if exist "%sd%:\NSP" (RD /s /q "%sd%:\NSP")
if exist "%sd%:\SaltySD" (RD /s /q "%sd%:\SaltySD")
if exist "%sd%:\atmo" (RD /s /q "%sd%:\atmo")
if exist "%sd%:\ams" (RD /s /q "%sd%:\ams")
if exist "%sd%:\scripts" (RD /s /q "%sd%:\scripts")
if exist "%sd%:\music" (RD /s /q "%sd%:\music")
if exist "%sd%:\tools" (RD /s /q "%sd%:\tools")
if exist "%sd%:\games" (RD /s /q "%sd%:\games")
if exist "%sd%:\pegascape" (RD /s /q "%sd%:\pegascape")
if exist "%sd%:\TinGen" (RD /s /q "%sd%:\TinGen")
if exist "%sd%:\sept" (RD /s /q  "%sd%:\sept")
if exist "%sd%:\.git" (RD /s /q "%sd%:\.git")
if exist "%sd%:\*.nro" (del "%sd%:\hbmenu.nro")
if exist "%sd%:\*.te" (del "%sd%:\startup.te")
if exist "%sd%:\*.ini" (del "%sd%:\*.ini")
if exist "%sd%:\*.bin" (del "%sd%:\*.bin")
if exist "%sd%:\*.txt" (del "%sd%:\*.txt")
if exist "%sd%:\*.dat" (del "%sd%:\*.dat")
if exist "%sd%:\*.log" (del "%sd%:\*.log")

if exist "%sd%:\roms\*.txt" (del  "%sd%:\roms\*.txt")

REM ======= SWITCH ORDNER ======================================
if exist "%sd%:\switch\download-helper" (RD /s /q "%sd%:\switch\download*")
if exist "%sd%:\switch\fw-downloader" (RD /s /q "%sd%:\switch\fw-downloader")
if exist "%sd%:\switch\gamecard_installer" (RD /s /q "%sd%:\switch\gamecard_installer")
if exist "%sd%:\switch\theme-updater" (RD /s /q "%sd%:\switch\theme-updater")
if exist "%sd%:\switch\luigi-theme-updater" (RD /s /q "%sd%:\switch\luigi-theme-updater")
if exist "%sd%:\switch\mario-theme-updater" (RD /s /q "%sd%:\switch\mario-theme-updater")
if exist "%sd%:\switch\Switch_90DNS_tester" (RD /s /q "%sd%:\switch\Switch_90DNS_tester")
if exist "%sd%:\switch\appstore" (RD /s /q "%sd%:\switch\appstore")

if exist "%sd%:\switch\tinleaf" (RD /s /q "%sd%:\switch\tinleaf")
if exist "%sd%:\switch\daybreak" (RD /s /q "%sd%:\switch\daybreak")
if exist "%sd%:\switch\tinwoo" (RD /s /q "%sd%:\switch\tinwoo")
if exist "%sd%:\switch\tinleaf" (RD /s /q "%sd%:\switch\tinleaf")
if exist "%sd%:\switch\switch-cheats-updater" (RD /s /q "%sd%:\switch\switch-cheats-updater\")
if exist "%sd%:\switch\btpair" (RD /s /q "%sd%:\switch\btpair")
if exist "%sd%:\switch\incognito" (RD /s /q "%sd%:\switch\incognito")
if exist "%sd%:\switch\Shutdown" (RD /s /q "%sd%:\switch\Shutdown")
if exist "%sd%:\switch\Reboot" (RD /s /q "%sd%:\switch\Reboot")
if exist "%sd%:\switch\Lockpick" (RD /s /q "%sd%:\switch\Lockpick")
if exist "%sd%:\switch\ultimate_updater" (RD /s /q "%sd%:\switch\ultimate_updater")
if exist "%sd%:\switch\gag-order" (RD /s /q "%sd%:\switch\gag-order")
if exist "%sd%:\switch\switch-time" (RD /s /q "%sd%:\switch\switch-time")
if exist "%sd%:\switch\nxmtp" (RD /s /q "%sd%:\switch\nxmtp")
if exist "%sd%:\switch\NXMPforMe" (RD /s /q "%sd%:\switch\NXMPforMe")
if exist "%sd%:\switch\lithium" (RD /s /q "%sd%:\switch\lithium")
if exist "%sd%:\switch\LinkUser" (RD /s /q "%sd%:\switch\LinkUser")
if exist "%sd%:\switch\TriPlayer" (RD /s /q "%sd%:\switch\TriPlayer")
if exist "%sd%:\switch\KosmosToolbox" (RD /s /q "%sd%:\switch\KosmosToolbox")
if exist "%sd%:\switch\KosmosUpdater" (RD /s /q "%sd%:\switch\KosmosUpdater")
if exist "%sd%:\switch\games" (RD /s /q "%sd%:\switch\games")
if exist "%sd%:\switch\mercury" (RD /s /q "%sd%:\switch\mercury")
if exist "%sd%:\switch\Fizeau" (RD /s /q "%sd%:\switch\Fizeau\")
if exist "%sd%:\switch\FreshHay" (RD /s /q "%sd%:\switch\FreshHay\")
if exist "%sd%:\switch\nx-ntpc" (RD /s /q "%sd%:\switch\nx-ntpc\")
if exist "%sd%:\switch\incognito" (RD /s /q "%sd%:\switch\incognito")
if exist "%sd%:\switch\fakenews-injector" (RD /s /q "%sd%:\switch\fakenews-injector")
if exist "%sd%:\switch\ChoiDujourNX" (RD /s /q "%sd%:\switch\ChoiDujourNX")
if exist "%sd%:\switch\Reboot_to_Payload" (RD /s /q "%sd%:\switch\Reboot_to_Payload")
if exist "%sd%:\switch\pplay" (RD /s /q "%sd%:\switch\pplay")
if exist "%sd%:\switch\SX" (RD /s /q "%sd%:\switch\SX")
if exist "%sd%:\switch\tinfoil" (RD /s /q "%sd%:\switch\tinfoil")
if exist "%sd%:\switch\tinfoil-store-updater" (RD /s /q "%sd%:\switch\tinfoil-store-updater")
if exist "%sd%:\switch\tinfoil-store-premium" (RD /s /q "%sd%:\switch\tinfoil-store-premium")
if exist "%sd%:\switch\.overlays" (RD /s /q "%sd%:\switch\.overlays")
REM if exist "%sd%:\switch\*.nro" (del "%sd%:\switch\*.nro")
REM if exist "%sd%:\switch\*.star" (del "%sd%:\switch\*.star")
if exist "%sd%:\switch\*.ini" (del "%sd%:\switch\*.ini")
if exist "%sd%:\switch\*.jar" (del "%sd%:\switch\*.jar")
if exist "%sd%:\switch\*.zip" (del "%sd%:\switch\*.zip")

REM ============================================================
:sblegtlos
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo                    Jetzt wird das satanarchaeoluegenialkohoellische Switch Bros. Paket              
echo                                  direkt auf deine SD-Karte geballert^^!         
echo.
echo                                    Du verdienst halt nur das BESTE^^!      
echo.
echo.
echo      NICHTS DRUECKEN^^!^^!^^!
echo.
echo      Gleich geht es weiter^^!
echo.
echo -----------------------------------------------------------------------------------------------------
powershell -Command "Start-Sleep -Seconds 5"

COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo                 Die Daten vom Switch Bros. Paket werden jetzt auf deine SD-Karte kopiert^^!
echo.
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
xcopy "%~dp0*" "%sd%:\" /H /Y /C /R /S /E >nul 2>nul
if exist "%SB-Backup%\Fizeau\config.ini" (xcopy "%SB-Backup%\Fizeau\config.ini" "%sd%:\config\Fizeau\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%SB-Backup%\ftpd\ftpd.cfg" (xcopy "%SB-Backup%\ftpd\ftpd.cfg" "%sd%:\config\ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%SB-Backup%\sys-ftpd\config.ini" (xcopy "%SB-Backup%\sys-ftpd\config.ini" "%sd%:\config\sys-ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%SB-Backup%\icongrabber\config.json" (xcopy "%SB-Backup%\icongrabber\config.json" "%sd%:\config\icongrabber\config.json\*" /H /Y /C /R /S /E /I) >nul 2>nul
powershell -Command "Start-Sleep -Seconds 3"
GOTO systempartitionen

REM ============================================================
:systempartitionen
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo     Waehle die Systeme aus, die in hekate, unter "Launch",  zur Verfuegung stehen sollen^^!
echo.
echo     Entweder sind die Systeme bereits bei dir installiert, oder du moechtest diese spaeter
echo     installieren = Die Partitionen dafuer nicht vergessen (Partiton nachtraeglich geht nicht)^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo     Achtung Modchip Besitzer = LAKKA, Libreelec, Ubuntu Bionic und fedora werden unterstuetzt^^!
echo.
echo     Android und die anderen Linux Distributionen z.Zt. NICHT^^!^^!^^!
echo -----------------------------------------------------------------------------------------------------
echo.
echo      0 = Basis (Standard)
echo      1 = Basis + Android
echo      2 = Basis + Linux
echo      3 = Basis + LAKKA
echo      4 = Basis + LibreELEC
echo      5 = Basis + Android + Linux
echo      6 = Basis + Android + LAKKA
echo      7 = Basis + Android + LibreELEC
echo      8 = Basis + Android + Linux + LAKKA
echo      9 = Basis + Android + Linux + LibreELEC
echo     10 = Basis + Android + LAKKA + LibreELEC
echo     11 = Basis + Android + Linux + LAKKA + LibreELEC
echo     12 = Basis + Linux + LAKKA
echo     13 = Basis + Linux + LAKKA + LibreELEC
echo     14 = Basis + Linux + LibreELEC
echo     15 = Basis + LAKKA + LibreELEC
echo     16 = alte hekate_ipl.ini behalten (nicht empfohlen)
echo.
echo -----------------------------------------------------------------------------------------------------
echo     W - Es geht erst weiter wenn du 'W' eingegeben hast^^!
echo         Also System auswaehlen und danach (W)EITER^^!
echo.
echo     H = Zurueck zum Hauptmenue
echo -----------------------------------------------------------------------------------------------------
echo.

set /p eingabe="     Waehle deine Systemkombination: "
if "%eingabe%"=="0" GOTO nurbasissystem
if "%eingabe%"=="1" GOTO androidpartition
if "%eingabe%"=="2" GOTO linuxpartition
if "%eingabe%"=="3" GOTO lakkapartition
if "%eingabe%"=="4" GOTO librepartition
if "%eingabe%"=="5" GOTO androidlinux
if "%eingabe%"=="6" GOTO androidlakka
if "%eingabe%"=="7" GOTO androidlibre
if "%eingabe%"=="8" GOTO androidlinuxlakka
if "%eingabe%"=="9" GOTO androidlinuxlibre
if "%eingabe%"=="10" GOTO androidlakkalibre
if "%eingabe%"=="11" GOTO androidlinuxlakkalibre
if "%eingabe%"=="12" GOTO linuxlakka
if "%eingabe%"=="13" GOTO linuxlakkalibre
if "%eingabe%"=="14" GOTO linuxlibre
if "%eingabe%"=="15" GOTO lakkalibre
if "%eingabe%"=="16" GOTO altesystembehalten 
if /i "%eingabe%"=="W" GOTO kindgerecht
if /i "%eingabe%"=="H" GOTO hauptmenue

REM ============================================================
:nurbasissystem
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\b\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
GOTO systempartitionen

REM ============================================================
:androidpartition
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\ba\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\android\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
GOTO systempartitionen

REM ============================================================
:linuxpartition
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Welche Linux Distribution wirst du spaeter nutzen?
echo.
echo      B = Ubuntu Bionic (empfohlen, wenn unsicher)
echo      F = Fedora Linux
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set "Linux="
set /p Linux="     Waehle deine Linux Distribution: "
if /i "%Linux%"=="B" (
xcopy "%sd%:\switchbros\system\bu\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

if /i "%Linux%"=="F" (
xcopy "%sd%:\switchbros\system\bu\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

GOTO systempartitionen

REM ============================================================
:lakkapartition
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\bl\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\lakka\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
GOTO systempartitionen

REM ============================================================
:librepartition
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\be\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\libreelec\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
GOTO systempartitionen

REM ============================================================
:androidlinux
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Welche Linux Distribution wirst du spaeter nutzen?
echo.
echo      B = Ubuntu Bionic (empfohlen, wenn unsicher)
echo      F = Fedora Linux
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set "Linux="
set /p Linux="     Waehle deine Linux Distribution: "
if /i "%Linux%"=="B" (
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\bau\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

if /i "%Linux%"=="F" (
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\bau\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

GOTO systempartitionen

REM ============================================================
:androidlakka
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\bla\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\lakka\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\android\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
GOTO systempartitionen

REM ============================================================
:androidlibre
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\bae\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\libreelec\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\android\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
GOTO systempartitionen

REM ============================================================
:androidlinuxlakka
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Welche Linux Distribution wirst du spaeter nutzen?
echo.
echo      B = Ubuntu Bionic (empfohlen, wenn unsicher)
echo      F = Fedora Linux
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set "Linux="
set /p Linux="     Waehle deine Linux Distribution: "
if /i "%Linux%"=="B" (
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\balu\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

if /i "%Linux%"=="F" (
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\balu\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

xcopy "%sd%:\switchbros\system\images\android\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\lakka\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
GOTO systempartitionen

REM ============================================================
:androidlinuxlibre
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Welche Linux Distribution wirst du spaeter nutzen?
echo.
echo      B = Ubuntu Bionic (empfohlen, wenn unsicher)
echo      F = Fedora Linux
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set "Linux="
set /p Linux="     Waehle deine Linux Distribution: "
if /i "%Linux%"=="B" (
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\baue\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

if /i "%Linux%"=="F" (
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\baue\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

xcopy "%sd%:\switchbros\system\images\android\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\libreelec\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
GOTO systempartitionen

REM ============================================================
:androidlakkalibre
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\bale\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\libreelec\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\android\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\lakka\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
GOTO systempartitionen

REM ============================================================
:androidlinuxlakkalibre
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Welche Linux Distribution wirst du spaeter nutzen?
echo.
echo      B = Ubuntu Bionic (empfohlen, wenn unsicher)
echo      F = Fedora Linux
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set "Linux="
set /p Linux="     Waehle deine Linux Distribution: "
if /i "%Linux%"=="B" (
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\balue\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

if /i "%Linux%"=="F" (
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\balue\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

xcopy "%sd%:\switchbros\system\images\android\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\libreelec\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\lakka\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
GOTO systempartitionen

REM ============================================================
:linuxlakka
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Welche Linux Distribution wirst du spaeter nutzen?
echo.
echo      B = Ubuntu Bionic (empfohlen, wenn unsicher)
echo      F = Fedora Linux
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set "Linux="
set /p Linux="     Waehle deine Linux Distribution: "
if /i "%Linux%"=="B" (
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\blu\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

if /i "%Linux%"=="F" (
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\blu\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

xcopy "%sd%:\switchbros\system\images\lakka\*" "%sd%:\" /H /Y /C /R /S /E /I
GOTO systempartitionen

REM ============================================================
:linuxlibre
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Welche Linux Distribution wirst du spaeter nutzen?
echo.
echo      B = Ubuntu Bionic (empfohlen, wenn unsicher)
echo      F = Fedora Linux
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set "Linux="
set /p Linux="     Waehle deine Linux Distribution: "
if /i "%Linux%"=="B" (
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\bue\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

if /i "%Linux%"=="F" (
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\bue\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

xcopy "%sd%:\switchbros\system\images\libreelec\*" "%sd%:\" /H /Y /C /R /S /E /I
GOTO systempartitionen

REM ============================================================
:linuxlakkalibre
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Welche Linux Distribution wirst du spaeter nutzen?
echo.
echo      B = Ubuntu Bionic (empfohlen, wenn unsicher)
echo      F = Fedora Linux
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set "Linux="
set /p Linux="     Waehle deine Linux Distribution: "
if /i "%Linux%"=="B" (
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\blue\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

if /i "%Linux%"=="F" (
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\blue\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)

xcopy "%sd%:\switchbros\system\images\libreelec\*" "%sd%:\" /H /Y /C /R /S /E /I
xcopy "%sd%:\switchbros\system\images\lakka\*" "%sd%:\" /H /Y /C /R /S /E /I
GOTO systempartitionen

REM ============================================================
:lakkalibre
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\ble\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\libreelec\*" "%sd%:\" /H /Y /C /R /S /E /I
xcopy "%sd%:\switchbros\system\images\lakka\*" "%sd%:\" /H /Y /C /R /S /E /I
GOTO systempartitionen

REM ============================================================
:altesystembehalten
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

if exist "%SB-Backup%\bootloader\hekate_ipl.ini" (xcopy "%SB-Backup%\bootloader\hekate_ipl.ini" "%sd%:\bootloader\hekate_ipl.ini" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%SB-Backup%\bootloader\nyx.ini" (xcopy "%SB-Backup%\bootloader\nyx.ini" "%sd%:\bootloader\nyx.ini" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%SB-Backup%\fastcfwswitch\config.ini" (xcopy "%SB-Backup%\fastcfwswitch\config.ini" "%sd%:\config\fastCFWSwitch\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%SB-Backup%\Fizeau\config.ini" (xcopy "%SB-Backup%\Fizeau\config.ini" "%sd%:\config\Fizeau\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%SB-Backup%\ftpd\ftpd.cfg" (xcopy "%SB-Backup%\ftpd\ftpd.cfg" "%sd%:\config\ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%SB-Backup%\sys-ftpd\config.ini" (xcopy "%SB-Backup%\sys-ftpd\config.ini" "%sd%:\config\sys-ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%SB-Backup%\icongrabber\config.json" (xcopy "%SB-Backup%\icongrabber\config.json" "%sd%:\config\icongrabber\*" /H /Y /C /R /S /E /I) >nul 2>nul
GOTO systempartitionen

REM ============================================================
:kindgerecht
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Solltest du Kinder haben, und NICHT wollen das die App = Tinfoil  auf dem homescreen erscheint,
echo      dann kannst du hier auswaehlen welche Version von Tinfoil installiert werden soll^^!
echo.
echo      1 = Tinfoil im hbmenu (nicht neben anderen Spielen auf dem homescreen (empfohlen))
echo.
echo      2 = Tinfoil auf dem homescreen (aktualisiert sich spaeter selbst)
echo.
echo      W = Kein Tinfoil (Spiele manuell "ausleihen" und installieren, zum Beispiel mit der App DBI)
echo.
echo -----------------------------------------------------------------------------------------------------
echo      H = Zurueck zum Hauptmenue
echo -----------------------------------------------------------------------------------------------------
echo.

set /p kindgerecht="     Waehle deine Tinfoil Version: "
	if "%kindgerecht%"=="1" GOTO tinfoila
	if "%kindgerecht%"=="2" GOTO tinfoilb
	if /i "%kindgerecht%"=="W" GOTO tinfoilno
	if /i "%kindgerecht%"=="H" GOTO hauptmenue

REM ============================================================
:tinfoila
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\kids\switch\*" "%sd%:\switch\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\kids\tinfoilhbmenu\*" "%sd%:\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\kids\NSPs\*" "%sd%:\NSPs\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%SB-Backup%\Tinfoil\locations.conf" "%sd%:\switch\tinfoil\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%SB-Backup%\Tinfoil\options.json" "%sd%:\switch\tinfoil\*" /H /Y /C /R /S /E /I >nul 2>nul
GOTO themepaketinst

REM ============================================================
:tinfoilb
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\kids\switch\*" "%sd%:\switch\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\kids\tinfoilhomescreen\*" "%sd%:\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\kids\NSPs\*" "%sd%:\NSPs\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%SB-Backup%\Tinfoil\locations.conf" "%sd%:\switch\tinfoil\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%SB-Backup%\Tinfoil\options.json" "%sd%:\switch\tinfoil\*" /H /Y /C /R /S /E /I >nul 2>nul
GOTO themepaketinst

REM ============================================================
:tinfoilno
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

RD /s /q "%sd%:\switch\tinfoil" >nul 2>nul
del "%sd%:\NSPs\Tinfoil [050000BADDAD0000][15.0][v0].nsp" >nul 2>nul
GOTO themepaketinst

REM ============================================================
:themepaketinst
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\theme\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
if exist "%SB-Backup%\bootlogo\bootlogo" (
RD /s /q "%sd%:\atmosphere\exefs_patches\bootlogo" >nul 2>nul
xcopy /y "%SB-Backup%\bootlogo\bootlogo" "%sd%:\atmosphere\exefs_patches\bootlogo") >nul 2>nul
if exist "%SB-Backup%\IconGrabber\config.json" (xcopy "%SB-Backup%\IconGrabber\config.json" "%sd%:\config\IconGrabber\*" /H /Y /C /R /S /E /I) >nul 2>nul
GOTO steamapiangeben

REM ============================================================
:steamapiangeben
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Wenn du moechtest gib deine Steam API fuer IconGrabber ein damit IconGrabber die SteamGridDB
echo      durchsuchen kann^^!
echo.
echo      Du solltest dich hier = ^>^> https://www.steamgriddb.com/ ^<^< mit deinem normalen STEAM-Account anmelden^^!
echo      (klick mit STRG + LMT auf den Link um ihn zu oeffnen) 
echo      Rechts oben auf deinen Namen ^> Preferences ^> dann links der letzte TAB = API
echo      Kopiere jetzt dort deine SteamAPI (RMT + kopieren)^^!
echo.
echo      Die kopierte API kannst du in diesem Fenster einfuegen indem du nur einmal die rechte
echo      Maustaste klickst^^! Dann mit Eingabetaste bestaetigen^^! 
echo.
echo      Eingabetaste = Diesen Schritt ueberspringen^^!
echo      (Sinnvoll wenn du die API bereits in der IconGrabber config drin hast^^!)
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set /p steamapi="     Bitte gib deine Steam API ein: "
set "config_path=%sd%:\config\icongrabber\config.json"
if "%steamapi%"=="" (
    goto systemmodule
)
set "search=deine_STEAM_API"
set "replace=%steamapi%"
set "textfile=%config_path%"
set "newfile=%sd%:\config\icongrabber\config_neu.json"
(for /f "delims=" %%i in (%textfile%) do (
    set "line=%%i"
    set "line=!line:%search%=%replace%!"
    echo !line!
))>"%newfile%"
move /y "%newfile%" "%textfile%"
GOTO systemmodule

REM ============================================================
:themepaketdeinst
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

RD /s /q "%sd%:\atmosphere\contents\00FF747765616BFF" >nul 2>nul
RD /s /q "%sd%:\config\icongrabber" >nul 2>nul
RD /s /q "%sd%:\switch\icongrabber" >nul 2>nul
RD /s /q "%sd%:\switch\Switch_themes_Installer" >nul 2>nul
RD /s /q "%sd%:\switch\ThemezerNX" >nul 2>nul
RD /s /q "%sd%:\switch\appstore\.get\packages\NXthemes_Installer" >nul 2>nul
RD /s /q "%sd%:\switch\appstore\.get\packages\ThemezerNX" >nul 2>nul
del "%sd%:\ThemeApps.txt" >nul 2>nul
GOTO systemmodule

REM ============================================================
:systemmodule
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo     Das Tesla-Overlay Menue kannst du auf deiner Switch aufrufen ueber: 
echo.
echo                          ZL + ZR + PLUS Taste 
echo.
echo     0 = kein Tesla-Overlay, keine Module^^!
echo     1 = Tesla-Overlay Menue + Standard System-Module^^!
echo     2 = Tesla-Overlay Menue + 4IFIR Uebertaktungs-System^^!
echo     3 = Tesla-Overlay Menue + Module einzeln + 4IFIR Uebertaktungs-System (empfohlen)^^!
echo.
echo     W = Ueberspringen und im Skript weiter gehen^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo     H = Zurueck zum Hauptmenue
echo -----------------------------------------------------------------------------------------------------
echo.

set /p sysmod="     Waehle deine Tesla-Overlay Version: "
	if "%sysmod%"=="0" GOTO teslanull
	if "%sysmod%"=="1" GOTO teslastandard
	if "%sysmod%"=="2" GOTO tesla4ifir
	if "%sysmod%"=="3" GOTO teslamodintro
	if /i "%sysmod%"=="W" GOTO attributeundmac
	if /i "%sysmod%"=="H" GOTO hauptmenue
    
REM ============================================================
:teslanull
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
    RD /s /q "%sd%:\switch\.overlays" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\420000000007E51A" >nul 2>nul
	RD /s /q "%sd%:\config\Tesla" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\Tesla-Menu" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\dns-mitm_manager" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\00FF0000000002AA" >nul 2>nul
	RD /s /q "%sd%:\config\BootSoundNX" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\054e4f4558454000" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\010000000000000D" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\0100000000001013" >nul 2>nul
	RD /s /q "%sd%:\switch\breeze" >nul 2>nul
	RD /s /q "%sd%:\switch\EdiZon" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\EdiZon" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\0100000000000352" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\emuiibo" >nul 2>nul
	RD /s /q "%sd%:\config\fastCFWswitch" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\fastCFWswitch" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\0100000000000F12" >nul 2>nul
	RD /s /q "%sd%:\config\Fizeau" >nul 2>nul
	RD /s /q "%sd%:\switch\Fizeau" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\Fizeau" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\4200000000000010" >nul 2>nul
	RD /s /q "%sd%:\switch\ldnmitm_config" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\ldn_mitm" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\010000000000bd00" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\exefs_patches\bluetooth_patches" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\exefs_patches\btm_patches" >nul 2>nul
	RD /s /q "%sd%:\config\MissionControl" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\MissionControl" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\ovlsysmodule" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\0000000000534C56" >nul 2>nul
	RD /s /q "%sd%:\SaltySD" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\SaltyNX" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\fpslocker" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\Status-Monitor-Overlay" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\00FF0000636C6BFF" >nul 2>nul
	RD /s /q "%sd%:\config\sys-clk" >nul 2>nul
	RD /s /q "%sd%:\switch\sys-clk" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\sys-clk-manager" >nul 2>nul
	RD /s /q "%sd%:\switch\sys-clk-Editor" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\sys-clk-Editor" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\690000000000000D" >nul 2>nul
	RD /s /q "%sd%:\config\sys-con" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\sys-con" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\00FF0000A53BB665" >nul 2>nul
	RD /s /q "%sd%:\config\sysdvr" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\SysDVR-conf" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\sysdvr-overlay" >nul 2>nul
	RD /s /q "%sd%:\switch\SysDVR-conf" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\420000000000000E" >nul 2>nul
	RD /s /q "%sd%:\config\sys-ftpd" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\sys-ftpd-light" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\4200000000000000" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\sys-tune" >nul 2>nul
	RD /s /q "%sd%:\switch\appstore\.get\packages\QuickNTP" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\0100BF500207C000" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\01009EE0111CC000" >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\010092A0172E4000" >nul 2>nul
	RD /s /q "%sd%:\switch\MemTesterNX" >nul 2>nul
	RD /s /q "%sd%:\switch\ReverseNX-Tool" >nul 2>nul

REM ============================================================
:teslastandard
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

	xcopy "%sd%:\switchbros\sys-modul\Tesla-menu\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\EdiZon\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\fastCFWswitch\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\MissionControl\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\ovlSysmodule\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\sys-clk\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\sys-clk-Editor\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\sys-con\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\sys-ftpd-light\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\QuickNTP\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps

REM ============================================================
:tesla4ifir
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\sys-modul\Tesla-menu\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\sys-modul\EdiZon\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\sys-modul\fastCFWswitch\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\sys-modul\MissionControl\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\sys-modul\ovlSysmodule\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\sys-modul\4IFIR\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\sys-modul\sys-clk-Editor\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\sys-modul\sys-ftpd-light\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\sys-modul\sys-con\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\sys-modul\QuickNTP\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
GOTO zusatzapps

REM ============================================================
:teslamodintro
COLOR 0E
xcopy "%sd%:\switchbros\sys-modul\Tesla-menu\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
GOTO teslamanuell

REM ============================================================
:teslamanuell
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo     Waehle hier die Module die du im Tesla-Overlay haben moechtest^^! 
echo     Das Tesla-Overlay ist in diesem Schritt bereits installiert^^! 
echo     Sonst machen die Module ja keinen Sinn^^! 
echo.
echo     Erst wenn du auf 'Weiter' gehst wird das Skript fortgesetzt^^! 
echo.
echo       1 = BootSoundNX (Bootsound beim Systemstart)
echo       2 = DNS-MITM Manager (Hosts Datei neu laden)
echo       3 = Edizon (Cheats nutzen)
echo       4 = emuiibo (damit kann man virtuelle amiibos nutzen)
echo       5 = fastCFWswitch (Launcher fuer Payloads (nicht fuer Modchip))
echo       6 = Fizeau (Bildschirmanzeige optimieren/verbessern)
echo       7 = ldn_mitm (LAN-Play App)
echo       8 = MissionControl (fremd Controller ueber Bluetooth)
echo       9 = ovlSysmodule (Tesla-Overlay module aktivieren/deaktivieren)
echo      10 = QuickNTP (Datum und Zeit mit Zeit-Server synchronisieren)
echo      11 = SaltyNX (SaltyNX gibt dir die Moeglichkeit plugins und andere Module zu starten)
echo      12 = Status-Monitor-Overlay (Werte der Switch an anzeigen)
echo      13 = sys-clk (Switch Uebertakten/Untertakten)
echo      14 = sys-clk-Editor (Werte in die config.ini von sys-clk eintragen)
echo      15 = sys-con (fremd Controller ueber USB)
echo      16 = sys-ftpd-light (FTP Verbindung im Hintergrund)
echo      17 = sys-tune (sys-tune kann Audio im Hintergrund abspielen! Manche Spiele koennen abstuerzen)
echo      18 = SysDVR-Overlay (Switch Bildschirm auf den PC uebertragen)
echo      19 = 4IFIR OC (Switch Uebertaktungs-System)
echo.
echo       W = Ueberspringen und im Skript weiter gehen^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo       H = Zurueck zum Hauptmenue
echo -----------------------------------------------------------------------------------------------------
echo.

set "teslamods="
set /p teslamods="     Waehle das Tesla-Overlay Modul: "
	if "%teslamods%"=="1" GOTO bootsoundnx
	if "%teslamods%"=="2" GOTO dnsmitm
	if "%teslamods%"=="3" GOTO edizon
	if "%teslamods%"=="4" GOTO emuiibo
	if "%teslamods%"=="5" GOTO fastcfwswitch
	if "%teslamods%"=="6" GOTO fizeau
	if "%teslamods%"=="7" GOTO ldnmitm
	if "%teslamods%"=="8" GOTO missioncontrol
	if "%teslamods%"=="9" GOTO ovlssysmodule
	if "%teslamods%"=="10" GOTO quickntp
	if "%teslamods%"=="11" GOTO saltynx
	if "%teslamods%"=="12" GOTO statmon
	if "%teslamods%"=="13" GOTO sysclk
	if "%teslamods%"=="14" GOTO sysclkedit
	if "%teslamods%"=="15" GOTO syscon
	if "%teslamods%"=="16" GOTO sysftpd
	if "%teslamods%"=="17" GOTO systune
	if "%teslamods%"=="18" GOTO sysdvr
	if "%teslamods%"=="19" GOTO fourifir
	if /i "%teslamods%"=="W" GOTO zusatzapps
	if /i "%teslamods%"=="H" GOTO hauptmenue

REM ============================================================
:bootsoundnx
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll BootSoundNX installiert oder deinstalliert werden?
echo.
echo      1 = BootSoundNX installieren
echo      2 = BootSoundNX deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "bootsoundnx="
set /p bootsoundnx="     Bitte triff deine Auswahl: "
	if "%bootsoundnx%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\BootSoundNX\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO bootsoundnx
	)
	if "%bootsoundnx%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\00FF0000000002AA"
	RD /s /q "%sd%:\config\BootSoundNX"
	GOTO bootsoundnx
	)
	if "%bootsoundnx%"=="3" GOTO teslamanuell

REM ============================================================
:dnsmitm
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll DNS-MITM Manager installiert oder deinstalliert werden?
echo      Bitte BEACHTEN: DNS-MITM Manager ist KEIN Spielzeug^^! NUR benutzen wenn du weisst wie^^!
echo.
echo      1 = DNS-MITM Manager installieren
echo      2 = DNS-MITM Manager deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "dnsmitm="
set /p dnsmitm="     Bitte triff deine Auswahl: "
	if "%dnsmitm%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\DNS-MITM_Manager\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO dnsmitm
	)
	if "%dnsmitm%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\dns-mitm_Manager"
	del "%sd%:\switch\.overlays\DNS-MITM_Manager.ovl"
	GOTO dnsmitm
	)
	if "%dnsmitm%"=="3" GOTO teslamanuell

REM ============================================================
:edizon
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll EdiZon installiert oder deinstalliert werden?
echo.
echo      1 = EdiZon installieren
echo      2 = EdiZon deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "edizon="
set /p edizon="     Bitte triff deine Auswahl: "
	if "%edizon%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\EdiZon\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO edizon
	)
	if "%edizon%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\054e4f4558454000"
	RD /s /q "%sd%:\atmosphere\contents\010000000000000D"
	RD /s /q "%sd%:\atmosphere\contents\0100000000001013"
	RD /s /q "%sd%:\switch\EdiZon"
	RD /s /q "%sd%:\switch\breeze"
	RD /s /q "%sd%:\switch\appstore\.get\packages\EdiZon"
	del "%sd%:\switch\.overlays\ovlEdiZon.ovl"
	GOTO edizon
	)
	if "%edizon%"=="3" GOTO teslamanuell

REM ============================================================
:emuiibo
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll emuiibo installiert oder deinstalliert werden?
echo.
echo      1 = emuiibo installieren
echo      2 = emuiibo deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "emuiibo="
set /p emuiibo="     Bitte triff deine Auswahl: "
	if "%emuiibo%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\emuiibo\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO emuiibo
	)
	if "%emuiibo%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\0100000000000352"
	RD /s /q "%sd%:\switch\appstore\.get\packages\emuiibo"
	del "%sd%:\switch\.overlays\emuiibo.ovl"
	GOTO emuiibo
	)
	if "%emuiibo%"=="3" GOTO teslamanuell

REM ============================================================
:fastcfwswitch
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll fastCFWSwitch installiert oder deinstalliert werden?
echo.
echo      1 = fastCFWSwitch installieren
echo      2 = fastCFWSwitch deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "fastcfwswitch="
set /p fastcfwswitch=     Bitte triff deine Auswahl: 
	if "%fastcfwswitch%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\fastCFWSwitch\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	if exist "%sd%:\switchbros\backup\fastcfwswitch\config.ini" (xcopy "%sd%:\switchbros\backup\fastcfwswitch\config.ini" "%sd%:\config\fastCFWSwitch\*" /H /Y /C /R /S /E /I) >nul 2>nul
	GOTO fastcfwswitch
	)
	if "%fastcfwswitch%"=="2" (
	RD /s /q "%sd%:\config\fastCFWSwitch"
	RD /s /q "%sd%:\switch\appstore\.get\packages\fastCFWSwitch"
	del "%sd%:\switch\.overlays\0_fastCFWswitch.ovl"
	GOTO fastcfwswitch
	)
	if "%fastcfwswitch%"=="3" GOTO teslamanuell

REM ============================================================
:fizeau
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll Fizeau installiert oder deinstalliert werden?
echo.
echo      1 = Fizeau installieren
echo      2 = Fizeau deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "fizeau="
set /p fizeau=     Bitte triff deine Auswahl: 
	if "%fizeau%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\Fizeau\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\config.ini" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO fizeau
	)
	if "%fizeau%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\0100000000000F12"
	RD /s /q "%sd%:\config\Fizeau"
	RD /s /q "%sd%:\switch\Fizeau"
	RD /s /q "%sd%:\switch\appstore\.get\packages\Fizeau"
	del "%sd%:\switch\.overlays\Fizeau.ovl"
	GOTO fizeau
	)
	if "%fizeau%"=="3" GOTO teslamanuell

REM ============================================================
:ldnmitm
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll ldnmitm installiert oder deinstalliert werden?
echo.
echo      1 = ldnmitm installieren
echo      2 = ldnmitm deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "ldnmitm="
set /p ldnmitm=     Bitte triff deine Auswahl: 
	if "%ldnmitm%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\ldnmitm\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO ldnmitm
	)
	if "%ldnmitm%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\4200000000000010"
	RD /s /q "%sd%:\switch\ldn_mitm_config"
	RD /s /q "%sd%:\switch\appstore\.get\packages\ldn_mitm_config"
	del "%sd%:\switch\.overlays\ldnmitm_config"
	GOTO ldnmitm
	)
	if "%ldnmitm%"=="3" GOTO teslamanuell

REM ============================================================
:missioncontrol
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll MissionControl installiert oder deinstalliert werden?
echo.
echo      1 = MissionControl installieren
echo      2 = MissionControl deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "missioncontrol="
set /p missioncontrol=     Bitte triff deine Auswahl: 
	if "%missioncontrol%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\MissionControl\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO missioncontrol
	)
	if "%missioncontrol%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\010000000000bd00"
	RD /s /q "%sd%:\atmosphere\contents\exefs_patches\bluetooth_patches"
	RD /s /q "%sd%:\atmosphere\contents\exefs_patches\btm_patches"
	RD /s /q "%sd%:\config\MissionControl"
	RD /s /q "%sd%:\switch\appstore\.get\packages\missioncontrol"
	GOTO missioncontrol
	)
	if "%missioncontrol%"=="3" GOTO teslamanuell

REM ============================================================
:ovlssysmodule
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll ovl-Sysmodul installiert oder deinstalliert werden?
echo.
echo      1 = ovl-Sysmodul installieren
echo      2 = ovl-Sysmodul deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "ovlssysmodule="
set /p ovlssysmodule=     Bitte triff deine Auswahl: 
	if "%ovlssysmodule%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\ovlSysmodule\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO ovlssysmodule
	)
	if "%ovlssysmodule%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\ovlssysmodule"
	del "%sd%:\switch\.overlays\ovlSysmodules.ovl"
	GOTO ovlssysmodule
	)
	if "%ovlssysmodule%"=="3" GOTO teslamanuell

REM ============================================================
:quickntp
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll QuickNTP installiert oder deinstalliert werden?
echo.
echo      1 = QuickNTP installieren
echo      2 = QuickNTP deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "quickntp="
set /p quickntp="     Bitte triff deine Auswahl: "
	if "%quickntp%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\QuickNTP\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO quickntp
	)
	if "%quickntp%"=="2" (
	del /s /q "%sd%:\switch\.overlays\QuickNTP.ovl"
	RD /s /q "%sd%:\switch\appstore\.get\packages\QuickNTP"
	GOTO quickntp
	)
	if "%quickntp%"=="3" GOTO teslamanuell

REM ============================================================
:saltynx
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll SaltyNX installiert oder deinstalliert werden?
echo.
echo      1 = SaltyNX installieren
echo      2 = SaltyNX deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "saltynx="
set /p saltynx=     Bitte triff deine Auswahl: 
	if "%saltynx%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\SaltyNX\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO saltynx
	)
	if "%saltynx%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\0000000000534C56"
	RD /s /q "%sd%:\SaltySD"
	del /s /q "%sd%:\switch\.overlays\FPSLocker.ovl"
	RD /s /q "%sd%:\switch\appstore\.get\packages\SaltyNX"
	GOTO saltynx
	)
	if "%saltynx%"=="3" GOTO teslamanuell

REM ============================================================
:statmon
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll Status-Monitor-Overlay installiert oder deinstalliert werden?
echo.
echo      1 = Status-Monitor-Overlay installieren
echo      2 = Status-Monitor-Overlay deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "statmon="
set /p statmon=     Bitte triff deine Auswahl: 
	if "%statmon%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\Status-Monitor-Overlay\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO statmon
	)
	if "%statmon%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\Status-Monitor-Overlay"
	del "%sd%:\switch\.overlays\Status-Monitor-Overlay.ovl"
	GOTO statmon
	)
	if "%statmon%"=="3" GOTO teslamanuell

REM ============================================================
:sysclk
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll sys-clk installiert oder deinstalliert werden?
echo.
echo      1 = sys-clk installieren
echo      2 = sys-clk deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "sysclk="
set /p sysclk=     Bitte triff deine Auswahl: 
	if "%sysclk%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\sys-clk\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO sysclk
	)
	if "%sysclk%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\00FF0000636C6BFF"
	RD /s /q "%sd%:\config\sys-clk"
	del /s /q "%sd%:\switch\.overlays\sys-clk-overlay.ovl"
	RD /s /q "%sd%:\switch\appstore\.get\packages\sys-clk-manager"
	RD /s /q "%sd%:\switch\sys-clk-manager"
	GOTO sysclk
	)
	if "%sysclk%"=="3" GOTO teslamanuell

REM ============================================================
:sysclkedit
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll sys-clk-Editor installiert oder deinstalliert werden?
echo.
echo      1 = sys-clk-Editor installieren
echo      2 = sys-clk-Editor deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "sysclkedit="
set /p sysclkedit=     Bitte triff deine Auswahl: 
	if "%sysclkedit%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\sys-clk-Editor\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO sysclkedit
	)
	if "%sysclkedit%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\sys-clk-Editor"
	RD /s /q "%sd%:\switch\sys-clk-Editor"
	GOTO sysclkedit
	)
	if "%sysclkedit%"=="3" GOTO teslamanuell

REM ============================================================
:syscon
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll sys-con installiert oder deinstalliert werden?
echo.
echo      1 = sys-con installieren
echo      2 = sys-con deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "syscon="
set /p syscon=     Bitte triff deine Auswahl: 
	if "%syscon%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\sys-con\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO syscon
	)
	if "%syscon%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\690000000000000D"
	RD /s /q "%sd%:\config\sys-con"
	RD /s /q "%sd%:\switch\appstore\.get\packages\sys-con"
	GOTO syscon
	)
	if "%syscon%"=="3" GOTO teslamanuell

REM ============================================================
:sysftpd
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll sys-FTPD-light installiert oder deinstalliert werden?
echo.
echo      1 = sys-FTPD-light installieren
echo      2 = sys-FTPD-light deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "sysftpd="
set /p sysftpd=     Bitte triff deine Auswahl: 
	if "%sysftpd%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\sys-ftpd-light\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO sysftpd
	)
	if "%sysftpd%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\420000000000000E"
	RD /s /q "%sd%:\config\sys-ftpd"
	RD /s /q "%sd%:\switch\appstore\.get\packages\sys-ftpd-light"
	GOTO sysftpd
	)
	if "%sysftpd%"=="3" GOTO teslamanuell

REM ============================================================
:sysdvr
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll sysDVR installiert oder deinstalliert werden?
echo.
echo      1 = sysDVR installieren
echo      2 = sysDVR deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "sysdvr="
set /p sysdvr=     Bitte triff deine Auswahl: 
	if "%sysdvr%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\sysdvr-overlay\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO sysdvr
	)
	if "%sysdvr%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\00FF0000A53BB665"
	RD /s /q "%sd%:\config\sysdvr"
	del /s /q "%sd%:\switch\.overlays\sysdvr-overlay.ovl"
	RD /s /q "%sd%:\switch\appstore\.get\packages\SysDVR-conf"
	RD /s /q "%sd%:\switch\appstore\.get\packages\sysdvr-overlay"
	RD /s /q "%sd%:\switch\SysDVR-conf"
	GOTO sysdvr
	)
	if "%sysdvr%"=="3" GOTO teslamanuell

REM ============================================================
:systune
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll sys-tune installiert oder deinstalliert werden?
echo.
echo      1 = sys-tune installieren
echo      2 = sys-tune deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "systune="
set /p systune=     Bitte triff deine Auswahl: 
	if "%systune%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\sys-tune\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO systune
	)
	if "%systune%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\4200000000000000"
	del /s /q "%sd%:\switch\.overlays\sys-tune-overlay.ovl"
	RD /s /q "%sd%:\switch\appstore\.get\packages\sys-tune"
	GOTO systune
	)
	if "%systune%"=="3" GOTO teslamanuell

REM ============================================================
:fourifir
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll 4IFIR OC installiert oder deinstalliert werden?
echo.
echo      1 = 4IFIR OC installieren
echo      2 = 4IFIR OC deinstallieren
echo.
echo      3 = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo      Enter = zum naechsten Modul springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "fourifir="
set /p fourifir=     Bitte triff deine Auswahl: 
	if "%fourifir%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\4IFIR\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO fourifir
	)
	if "%fourifir%"=="2" (
	del /s /q "%sd%:\switch\atmosphere\kips\loader.kip"
	GOTO fourifir
	)
	if "%fourifir%"=="3" GOTO teslamanuell

REM ============================================================
:zusatzapps
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo     Zusatz-Apps kannst du hier installieren / deinstallieren^^!
echo.
echo     1 = Alle Zusatz-Apps installieren (wenn CFW zum ersten Mal gemacht wird = empfohlen)^^!
echo     2 = Zusatz-Apps einzeln auswaehlen und entscheiden (so individuell wie du)^^!
echo.
echo     W = Ueberspringen und im Skript weiter gehen^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo     H = Zurueck zum Hauptmenue
echo -----------------------------------------------------------------------------------------------------
echo.

set /p zusatzapps="     Waehle deine Zusatz-Apps Variante: "
	if "%zusatzapps%"=="1" GOTO zusatzkomplett
	if "%zusatzapps%"=="2" GOTO zusatzeinzel
	if /i "%zusatzapps%"=="W" GOTO attributeundmac
	if /i "%zusatzapps%"=="H" GOTO hauptmenue

REM ============================================================
:zusatzkomplett
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Alle Zusatz-Apps werden jetzt installiert^^!
echo.
echo      BITTE WARTEN...
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\zusatzapps\chiaki\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\fake08\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\haku33\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\TencentSwitcherGui\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul

GOTO attributeundmac

REM ============================================================
:zusatzeinzel
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo     Waehle hier ein paar Apps die zusaetzlich installiert / deinstalliert werden sollen^^! 
echo.
echo     Erst wenn du auf 'Weiter' gehst wird das Skript fortgesetzt^^!
echo.
echo      1 = chiaki (PS4/PS5 auf der Switch streamen)
echo      2 = fake08 (Pico8 Emulator)
echo      3 = haku33 (OutOfTheBox Reinigung)
echo      4 = TencentSwitcherGui (Chinesisch auf englisch stellen)
echo.
echo      W = Ueberspringen und im Skript weiter gehen^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo      H = Zurueck zum Hauptmenue
echo -----------------------------------------------------------------------------------------------------
echo.

set "datenapps="
set /p datenapps=     Waehle deine Zusatz-App(s): 
	if "%datenapps%"=="1" GOTO chiaki
	if "%datenapps%"=="2" GOTO fake08
	if "%datenapps%"=="3" GOTO haku33
	if "%datenapps%"=="4" GOTO tencentswitcher
	if /i "%datenapps%"=="W" GOTO attributeundmac
	if /i "%datenapps%"=="H" GOTO hauptmenue

REM ============================================================
:chiaki
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll chiaki installiert oder deinstalliert werden?
echo.
echo      1 = chiaki installieren
echo      2 = chiaki deinstallieren
echo.
echo      3 = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo      Enter = zur naechsten App springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "chiaki="
set /p chiaki=     Bitte triff deine Auswahl: 
	if "%chiaki%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\chiaki\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO chiaki
	)
	if "%chiaki%"=="2" (
	RD /s /q "%sd%:\switch\chiaki"
	GOTO chiaki
	)
	if "%chiaki%"=="3" GOTO zusatzapps

REM ============================================================
:fake08
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll Fake-08 installiert oder deinstalliert werden?
echo.
echo      1 = Fake-08 installieren
echo      2 = Fake-08 deinstallieren
echo.
echo      3 = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo      Enter = zur naechsten App springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "fake08="
set /p fake08=     Bitte triff deine Auswahl: 
	if "%fake08%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\fake08\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO fake08
	)
	if "%fake08%"=="2" (
	RD /s /q "%sd%:\switch\fake08"
	GOTO fake08
	)
	if "%fake08%"=="3" GOTO zusatzapps

REM ============================================================
:haku33
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll haku33 installiert oder deinstalliert werden?
echo.
echo      1 = haku33 installieren
echo      2 = haku33 deinstallieren
echo.
echo      3 = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo      Enter = zur naechsten App springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "haku33="
set /p haku33=     Bitte triff deine Auswahl: 
	if "%haku33%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\haku33\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO haku33
	)
	if "%haku33%"=="2" (
	RD /s /q "%sd%:\switch\haku33"
	GOTO haku33
	)
	if "%haku33%"=="3" GOTO zusatzapps

REM ============================================================
:tencentswitcher
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Soll TencentSwitcherGui installiert oder deinstalliert werden?
echo.
echo      1 = TencentSwitcherGui installieren
echo      2 = TencentSwitcherGui deinstallieren
echo.
echo      3 = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo      Enter = zur naechsten App springen^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "tencentswitcher="
set /p tencentswitcher=     Bitte triff deine Auswahl: 
	if "%tencentswitcher%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\TencentSwitcherGui\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO tencentswitcher
	)
	if "%tencentswitcher%"=="2" (
	RD /s /q "%sd%:\switch\TencentSwitcherGui"
	GOTO tencentswitcher
	)
	if "%tencentswitcher%"=="3" GOTO zusatzapps

REM ============================================================
:attributeundmac
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Attribute in Ordnung bringen und MacOS Dateien entfernen^^!
echo.
echo.
echo.
echo      1 = Attribute bereinigen (fixArchiveBit) und weiter im Skript^^!
echo.
echo.
echo      2 = Attribute bereinigen (fixArchiveBit) und zurueck zum Hauptmenue^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo      H = Zurueck zum Hauptmenue
echo -----------------------------------------------------------------------------------------------------
echo.

set /p fixattrib=     Bitte triff deine Auswahl: 
	if "%fixattrib%"=="1" GOTO fixattribweiter
	if "%fixattrib%"=="2" GOTO fixattribhaupt
	if /i "%fixattrib%"=="H" GOTO hauptmenue

REM ============================================================
:fixattribhaupt
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo                         Attribute werden korrigiert^^! 
echo                             (Fix archive bit) 
echo.
echo                    MacOS typische Dateien werden entfernt^^! 
echo.
echo                         Schreibschutz wird entfernt^^! 
echo.
echo      BITTE WARTEN...
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

if exist "%sd%:\atmosphere" (
	attrib -A -R /S /D %sd%:\atmosphere\*
	attrib -A -R %sd%:\atmosphere)
if exist "%sd%:\atmosphere\contents" (
	attrib -A -R /S /D %sd%:\atmosphere\contents\*
	attrib -A -R %sd%:\atmosphere\contents)
if exist "%sd%:\bootloader" (
	attrib -A -R /S /D %sd%:\bootloader\*
	attrib -A -R %sd%:\bootloader)
if exist "%sd%:\config" (
	attrib -A -R /S /D %sd%:\config\*
	attrib -A -R %sd%:\config)
if exist "%sd%:\emuiibo" (
	attrib -A -R /S /D %sd%:\emuiibo\*
	attrib -A -R %sd%:\emuiibo)
if exist "%sd%:\NSPs" (
	attrib -A -R /S /D %sd%:\NSPs\*
	attrib -A -R %sd%:\NSPs)
if exist "%sd%:\SaltySD" (
	attrib -A -R /S /D %sd%:\SaltySD\*
	attrib -A -R %sd%:\SaltySD)
if exist "%sd%:\switch" (
	attrib -A -R /S /D %sd%:\switch\*
	attrib -A -R %sd%:\switch)
if exist "%sd%:\tegraexplorer" (
	attrib -A -R /S /D %sd%:\tegraexplorer\*
	attrib -A -R %sd%:\tegraexplorer)
if exist "%sd%:\themes" (
	attrib -A -R /S /D %sd%:\themes\*
	attrib -A -R %sd%:\themes)
if exist "%sd%:\warmboot" (
	attrib -A -R /S /D %sd%:\warmboot\*
	attrib -A -R %sd%:\warmboot)
if exist "%sd%:\BasisApps.txt" (attrib -A -R %sd%:\BasisApps.txt)
if exist "%sd%:\boot.dat" (attrib -A -R %sd%:\boot.dat)
if exist "%sd%:\boot.ini" (attrib -A -R %sd%:\boot.ini)
if exist "%sd%:\exosphere.ini" (attrib -A -R %sd%:\exosphere.ini)
if exist "%sd%:\hbmenu.nro" (attrib -A -R %sd%:\hbmenu.nro)
if exist "%sd%:\payload.bin" (attrib -A -R %sd%:\payload.bin)
if exist "%sd%:\SB.ico" (attrib -A -R %sd%:\SB.ico)
rem Entfernen typischer MacOS Dateien (die sind ueberall die Bruedaz)
if exist .DS_STORE del /s /q /f /a .DS_STORE
if exist ._.* del /s /q /f /a ._.*
GOTO hauptmenue

REM ============================================================
:fixattribweiter
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo                         Attribute werden korrigiert^^! 
echo                             (Fix archive bit) 
echo.
echo                    MacOS typische Dateien werden entfernt^^! 
echo.
echo                         Schreibschutz wird entfernt^^! 
echo.
echo      BITTE WARTEN...
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

if exist "%sd%:\atmosphere" (
	attrib -A -R /S /D %sd%:\atmosphere\*
	attrib -A -R %sd%:\atmosphere)
if exist "%sd%:\atmosphere\contents" (
	attrib -A -R /S /D %sd%:\atmosphere\contents\*
	attrib -A -R %sd%:\atmosphere\contents)
if exist "%sd%:\bootloader" (
	attrib -A -R /S /D %sd%:\bootloader\*
	attrib -A -R %sd%:\bootloader)
if exist "%sd%:\config" (
	attrib -A -R /S /D %sd%:\config\*
	attrib -A -R %sd%:\config)
if exist "%sd%:\emuiibo" (
	attrib -A -R /S /D %sd%:\emuiibo\*
	attrib -A -R %sd%:\emuiibo)
if exist "%sd%:\NSPs" (
	attrib -A -R /S /D %sd%:\NSPs\*
	attrib -A -R %sd%:\NSPs)
if exist "%sd%:\SaltySD" (
	attrib -A -R /S /D %sd%:\SaltySD\*
	attrib -A -R %sd%:\SaltySD)
if exist "%sd%:\switch" (
	attrib -A -R /S /D %sd%:\switch\*
	attrib -A -R %sd%:\switch)
if exist "%sd%:\tegraexplorer" (
	attrib -A -R /S /D %sd%:\tegraexplorer\*
	attrib -A -R %sd%:\tegraexplorer)
if exist "%sd%:\themes" (
	attrib -A -R /S /D %sd%:\themes\*
	attrib -A -R %sd%:\themes)
if exist "%sd%:\warmboot" (
	attrib -A -R /S /D %sd%:\warmboot\*
	attrib -A -R %sd%:\warmboot)
if exist "%sd%:\BasisApps.txt" (attrib -A -R %sd%:\BasisApps.txt)
if exist "%sd%:\boot.dat" (attrib -A -R %sd%:\boot.dat)
if exist "%sd%:\boot.ini" (attrib -A -R %sd%:\boot.ini)
if exist "%sd%:\exosphere.ini" (attrib -A -R %sd%:\exosphere.ini)
if exist "%sd%:\hbmenu.nro" (attrib -A -R %sd%:\hbmenu.nro)
if exist "%sd%:\payload.bin" (attrib -A -R %sd%:\payload.bin)
if exist "%sd%:\SB.ico" (attrib -A -R %sd%:\SB.ico)
rem Entfernen typischer MacOS Dateien (die sind ueberall die Bruedaz)
if exist .DS_STORE del /s /q /f /a .DS_STORE
if exist ._.* del /s /q /f /a ._.*

REM ============================================================
:hekateusb
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Volle USB3 Geschwindigkeit mit hekate USM Modus^^!
echo.
echo      1 = USB3 in die Registry eintragen und weiter im Skript^^!
echo          (muss nur einmal fuer einen PC ausgefuehrt werden)
echo.
echo.
echo      2 = USB3 nicht in die Registry eintragen und weiter im Skript^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo      H = Zurueck zum Hauptmenue
echo -----------------------------------------------------------------------------------------------------
echo.

set /p usb3=     Welche USB3 Einstellung: 
	if "%usb3%"=="1" GOTO usb3weiter
	if "%usb3%"=="2" GOTO aufraeumen
	if /i "%usb3%"=="H" GOTO hauptmenue

:usb3weiter
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\usbstor\11ECA7E0 /v MaximumTransferLength /t REG_DWORD /d 00100000 /f>nul 2>&1
GOTO aufraeumen

REM ============================================================
:aufraeumen
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      So, machen wir mal klar Schiff hier und raeumen hinter uns auf^^!
echo.
echo      Das heisst Installationsordner loeschen und deine Modchip Einstellung uebernehmen^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo      Bitte Warten^^!
echo -----------------------------------------------------------------------------------------------------
echo.

if exist "%sd%:\SwitchBros_BasisPaket" (RD /s /q "%sd%:\SwitchBros_BasisPaket")
if exist "%sd%:\switchbros" (RD /s /q "%sd%:\switchbros")
if exist "%sd%:\updatebak" (RD /s /q "%sd%:\updatebak")
if exist "%sd%:\switch\switchbros-updater\update.te" (del "%sd%:\switch\switchbros-updater\update.te")
if exist "%sd%:\System Volume Information" (RD /s /q "%sd%:\System Volume Information")
if exist "%sd%:\*.bat" (del "%sd%:\*.bat")
if exist "%sd%:\*.te" (del "%sd%:\*.te")
if exist "%sd%:\*.exe" (del "%sd%:\*.exe")
if exist "%sd%:\*.bak" (del "%sd%:\*.bak")
if exist "%sd%:\*.md" (del "%sd%:\*.md")
if exist "%sd%:\licence" (del "%sd%:\licence")
if exist "%sd%:\SwitchBros_BasisPaket.zip" (del "%sd%:\SwitchBros_BasisPaket.zip")
if exist "%sd%:\bootloader\ini\!switchbros_updater.ini" (del "%sd%:\bootloader\ini\!switchbros_updater.ini")
if exist "%sd%:\bootloader\ini\switchbros_updater.ini" (del "%sd%:\bootloader\ini/switchbros_updater.ini")
if exist "%sd%:\SwitchBros.txt" (del "%sd%:\SwitchBros.txt")
if exist "%sd%:\switch\switchbrosupdater" (RD /s /q "%sd%:\switch\switchbrosupdater")

if %bootdat%==0 (
	if exist "%sd%:\bootloader\memloader" (RD /s /q "%sd%:\bootloader\memloader")
	if exist "%sd%:\bootloader\payloads\hwfly_toolbox.bin" (del "%sd%:\bootloader\payloads\hwfly_toolbox.bin")
	if exist "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp" (del "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp")
	if exist "%sd%:\bootloader\ini\hwfly_toolbox.ini" (del "%sd%:\bootloader\ini\hwfly_toolbox.ini")
	if exist "%sd%:\boot.dat" (del "%sd%:\boot.dat")
	if exist "%sd%:\boot.ini" (del "%sd%:\boot.ini") 
	if exist "%sd%:\payload.bin" (del "%sd%:\payload.bin")
	)
if %bootdat%==1 (
	if exist "%sd%:\bootloader\memloader" (RD /s /q "%sd%:\bootloader\memloader")
	if exist "%sd%:\config\Fizeau" (RD /s /q "%sd%:\config\Fizeau")
	if exist "%sd%:\switch\Fizeau" (RD /s /q "%sd%:\switch\Fizeau")
	if exist "%sd%:\switch\.overlays\5_Fizeau.ovl" (del "%sd%:\switch\.overlays\*fizeau*.ovl")
	if exist "%sd%:\atmosphere\contents\0100000000000F12" (RD /s /q "%sd%:\atmosphere\contents\0100000000000F12")
)
if %bootdat%==2 (
	if exist "%sd%:\bootloader\payloads\hwfly_toolbox.bin" (del "%sd%:\bootloader\payloads\hwfly_toolbox.bin")
	if exist "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp" (del "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp")
	if exist "%sd%:\bootloader\ini\hwfly_toolbox.ini" (del "%sd%:\bootloader\ini\hwfly_toolbox.ini")
	)

cd %sd%:\
GOTO endemutig

REM ============================================================
:falschesdkarte
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo                 Gewaehlter Laufwerksbuchstabe: %sd%:/
echo                    Keine SD-Karte in Laufwerk: %sd%:/
echo.
echo.
echo      1.  Laufwerksbuchstabe ist korrekt^^!
echo      2.  Anderen Laufwerksbuchstaben waehlen
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      B.  Beenden
echo.

set /p st=     Auswahl: 

for %%A in ("J" "j" "1" "?" "?") do if "%st%"==%%A (GOTO hauptmenue)
for %%A in ("N" "n" "2" "?" "?") do if "%st%"==%%A (GOTO neuekarte)
for %%A in ("B" "b" "?" "?") do if "%st%"==%%A (GOTO endemutig)

REM ============================================================
:endemutig
COLOR 0A
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo                                         Alles abgeschlossen^^!^^!^^!
echo.
echo                    Viel Spass mit unserem Paket und Willkommen in der Switch Bros. Community
echo.
echo.
echo      Soll dieses Programm jetzt beendet werden?
echo.
echo      J = Dieses Programm beenden^^!
echo      N = Zurueck zum Hauptmenue^^!
echo.  
echo -----------------------------------------------------------------------------------------------------

set /p ende=Soll das Programm beendet werden? (J/N): 
	if /i "%ende%"=="N" GOTO hauptmenue
	if /i "%ende%"=="J" (
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Das Programm wird automatisch beendet und geschlossen^^! 
echo.
echo      BITTE WARTEN...
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
powershell -Command "Start-Sleep -Seconds 7"
exit
)

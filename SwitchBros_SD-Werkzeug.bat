@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
chcp 1252 >nul 2>&1
title SwitchBros. SD-Werkzeug
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
ECHO OFF
COLOR 0C
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo                            _-== WARNUNG - WARNUNG - WARNUNG - WARNUNG ==-_
echo.
echo      Wenn du dieses Skript (SD-Werkzeug.bat) von deiner SD-Karte aus gestartet hast, dann
echo          SCHLIESSE es bitte SOFORT^^! NICHT von SD-Karte aus starten^^!
echo.
echo      Bitte starte die SD-Werkzeug.bat ^>NUR^< aus dem "BasisPaket" Ordner von deinem PC^^!
echo.
echo =====================================================================================================
echo.
echo      Hast du dieses Skript aus dem "SwitchBros_BasisPaket" heraus gestartet, dann gib jetzt
echo      bitte ^>NUR^< den Laufwerksbuchstaben deiner SD-Karte ein^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

for /f "tokens=3-6 delims=: " %%a in ('WMIC LOGICALDISK GET FreeSpace^,Name^,Size^,filesystem^,description ^|FINDSTR /I "Removable" ^|findstr /i "exFAT FAT32"') do (@echo wsh.echo "Laufwerksbuchstabe: %%c;" ^& " frei: " ^& FormatNumber^(cdbl^(%%b^)/1024/1024/1024, 2^)^& " GB;"^& " Groesse: " ^& FormatNumber^(cdbl^(%%d^)/1024/1024/1024, 2^)^& " GB;" ^& " Dateisystem: %%a" > %temp%\tmp.vbs & @if not "%%c"=="" @echo( & @cscript //nologo %temp%\tmp.vbs & del %temp%\tmp.vbs)
echo.
set /P sd="Laufwerksbuchstabe der SD-Karte: "

if not exist "%sd%:\" (
	set word=        Es befindet sich keine SD-Karte im Laufwerk %sd%         
	GOTO falschesdkarte
) else (
	if not exist "%sd%:\*" (GOTO falschesdkarte)
)

REM ============================================================
:modchip
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Wenn du einen Modchip in deiner Konsole hast, dann gib es bitte hier an^^!
echo.
echo      1 = Ja, ich habe einen Modchip verbaut (v2, lite, OLED, trinketm0 in der v1)
echo      2 = Nein, ich habe keinen Modchip verbaut
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set /p modchip="Ist ein Modchip verbaut: "
if "%modchip%"=="1" SET bootdat=1
if "%modchip%"=="2" SET bootdat=0

REM ============================================================
:datensichern
if exist "%sd%:\bootloader\hekate_ipl.ini" (xcopy /y "%sd%:\bootloader\hekate_ipl.ini" "%sd%:\switchbros\backup\*") >nul 2>nul
if exist "%sd%:\bootloader\nyx.ini" (xcopy /y "%sd%:\bootloader\nyx.ini" "%sd%:\switchbros\backup\*") >nul 2>nul
if exist "%sd%:\config\fastCFWSwitch\config.ini" (xcopy /y "%sd%:\config\fastCFWSwitch\config.ini" "%sd%:\switchbros\backup\fastCFWSwitch\*") >nul 2>nul
if exist "%sd%:\config\Fizeau\config.ini" (xcopy /y "%sd%:\config\Fizeau\config.ini" "%sd%:\switchbros\backup\Fizeau\*") >nul 2>nul
if exist "%sd%:\config\IconGrabber\config.json" (xcopy /y "%sd%:\config\IconGrabber\config.json" "%sd%:\switchbros\backup\IconGrabber\*") >nul 2>nul
if exist "%sd%:\config\ftpd\ftpd.cfg" (xcopy /y "%sd%:\config\ftpd\ftpd.cfg" "%sd%:\switchbros\backup\ftpd\*") >nul 2>nul
if exist "%sd%:\switch\tinfoil\locations.conf" (xcopy /y "%sd%:\switch\tinfoil\locations.conf" "%sd%:\switchbros\backup\tinfoil\*") >nul 2>nul

REM ============================================================
:hauptmenue
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Bitte das GANZE Skript komplett durchgehen wenn du die CFW zum ersten Mal aufsetzt, oder wenn
echo      von einem anderen Paket kommst oder wenn es sich um eine neue SD-Karte handelt^^! DANKE^^!
echo.
echo      1 = SD-Karte bereinigen/einrichten und zum SwitchBros. Paket wechseln^^!
echo.
echo =====================================================================================================
echo.
echo      2 = Backup Ordner auf dem PC erstellen (fuer BOOT0, BOOT1, RAW GPP und KEYS)^^!
echo.
echo      3 = Gib die Systeme an die du spaeter nutzen wirst (Linux, LAKKA, Android)^^!
echo.
echo      4 = Kinder-Modus einrichten (verstecken von Apps zb Tinfoil)^^!
echo.
echo      5 = ThemeApps Paket installieren / deinstallieren^^!
echo.
echo      5a = SteamAPI fuer IconGrabber eingeben^^! (Nur wenn das ThemeApps_Paket oder Icongrabber installiert ist)
echo.
echo      6 = Tesla-Overlay installieren / deinstallieren / manuell^^!
echo.
echo      7 = Zusatz Apps installieren / deinstallieren^^!
echo.
echo      8 = Attribute (fix ArchiveBit) und MacOS Kram beseitigen^^!
echo.
echo      9 = Volle USB3 Geschwindigkeit in die Registry eintragen lassen^^!
echo.
echo.
echo      F = Unsicher, altes Paket behalten                             B = Dieses Skript Beenden
echo.     
echo -----------------------------------------------------------------------------------------------------
echo.

set /p neuistgut="Bitte gib deine Auswahl ein: "
if "%neuistgut%"=="1" GOTO sbgibgas
if "%neuistgut%"=="2" GOTO backupordner
if "%neuistgut%"=="3" GOTO systempartitionen
if "%neuistgut%"=="4" GOTO kindgerecht
if "%neuistgut%"=="5" GOTO themepaket
if "%neuistgut%"=="5a" GOTO steamapiangeben
if "%neuistgut%"=="6" GOTO systemmodule
if "%neuistgut%"=="7" GOTO zusatzapps
if "%neuistgut%"=="8" GOTO attributeundmac
if "%neuistgut%"=="9" GOTO hekateusb
if /i "%neuistgut%"=="F" GOTO endefeige
if /i "%neuistgut%"=="B" GOTO endemutig

REM ============================================================
:backupordner
ECHO OFF
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
echo        - Lockpick
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
set /p LW=Bitte gib einen gueltigen Laufwerksbuchstaben ein: 

if defined LW (
 (
    md "%LW%:\SwitchBackup\sysNAND"
    md "%LW%:\SwitchBackup\Lockpick\Prodkeys-Devkeys"
    md "%LW%:\SwitchBackup\Lockpick\Partial_AES_Keys"
    md "%LW%:\SwitchBackup\Lockpick\Amiibo_Keys"
    md "%LW%:\SwitchBackup\SD-Karten_Backup"
  ) 2>nul
    ECHO OFF
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
echo                           ZIEHE NICHT UEBER LOS^^! UND STREICHE KEINE 2000€ EIN^^!
echo.
echo.
echo.
echo      Druecke die Eingabetaste zum beenden
echo -----------------------------------------------------------------------------------------------------
echo.

if exist "%wd%" (RD /s /q "%wd%\*")
pause>nul 2>&1
exit

REM ======= ATMOSPHERE ORDNER ==================================
:sbgibgas
ECHO OFF
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
if exist "%sd%:\emuiibo" (RD /s /q "%sd%:\emuiibo")
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
if exist "%sd%:\switch\*.nro" (del "%sd%:\switch\*.nro")
if exist "%sd%:\switch\*.ini" (del "%sd%:\switch\*.ini")
if exist "%sd%:\switch\*.jar" (del "%sd%:\switch\*.jar")
if exist "%sd%:\switch\*.zip" (del "%sd%:\switch\*.zip")
if exist "%sd%:\switch\*.star" (del "%sd%:\switch\*.star")

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
echo                          Druecke die Eingabetaste und loese dich von der Matrix^^!
echo.
echo -----------------------------------------------------------------------------------------------------
pause>nul 2>&1

ECHO OFF
COLOR 0E
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
TIMEOUT /t 3 /nobreak
if exist "%sd%:\switchbros\backup\Fizeau\config.ini" (xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\ftpd\ftpd.cfg" (xcopy "%sd%:\switchbros\backup\ftpd\ftpd.cfg" "%sd%:\config\ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\icongrabber\config.json" (xcopy "%sd%:\switchbros\backup\icongrabber\config.json" "%sd%:\config\icongrabber\config.json\*" /H /Y /C /R /S /E /I) >nul 2>nul

REM ============================================================
:systempartitionen
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo     Waehle die hekate Systeme aus, die dir spaeter in hekate zur Verfuegung stehen sollen^^!
echo.
echo     Entweder sind die Systeme bereits bei dir installiert, oder du moechtest diese spaeter
echo     installieren = Die Partitionen dafuer nicht vergessen (Partiton nachtraeglich geht nicht)^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo     Achtung modchip Besitzer = LAKKA und Ubuntu Bionic Distro werden jetzt unterstuetzt^^!
echo.
echo     Android und die anderen Linux Distributionen z.Zt. NICHT^^!^^!^^!
echo -----------------------------------------------------------------------------------------------------
echo.
echo     0 = alte hekate_ipl.ini behalten (nicht empfohlen)
echo     1 = Basis (Standard)
echo     2 = Basis + Android
echo     3 = Basis + Linux
echo     4 = Basis + LAKKA
echo     5 = Basis + Android + Linux
echo     6 = Basis + Android + LAKKA
echo     7 = Basis + Android + Linux + LAKKA
echo     8 = Basis + Linux + LAKKA
echo.
echo     W = System(e) sind gewaehlt, weiter im Skript
echo.
echo -----------------------------------------------------------------------------------------------------
echo     H = Zurueck zum Hauptmenue
echo -----------------------------------------------------------------------------------------------------
echo.

set /p eingabe="Deine Systemkombination: "
if "%eingabe%"=="0" GOTO altesystembehalten
if "%eingabe%"=="1" GOTO nurbasissystem
if "%eingabe%"=="2" GOTO androidpartition
if "%eingabe%"=="3" GOTO linuxpartition
if "%eingabe%"=="4" GOTO lakkapartition
if "%eingabe%"=="5" GOTO androidlinux
if "%eingabe%"=="6" GOTO androidlakka
if "%eingabe%"=="7" GOTO androidlinuxlakka
if "%eingabe%"=="8" GOTO linuxlakka
if /i "%eingabe%"=="W" GOTO kindgerecht
if /i "%eingabe%"=="H" GOTO hauptmenue

REM ============================================================
:altesystembehalten
ECHO OFF
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
if exist "%sd%:\switchbros\backup\nyx.ini" (xcopy "%sd%:\switchbros\backup\nyx.ini" "%sd%:\bootloader\nyx.ini" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\hekate_ipl.ini" (xcopy "%sd%:\switchbros\backup\hekate_ipl.ini" "%sd%:\bootloader\hekate_ipl.ini" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\fastcfwswitch\config.ini" (xcopy "%sd%:\switchbros\backup\fastcfwswitch\config.ini" "%sd%:\config\fastCFWSwitch\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\Fizeau\config.ini" (xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\ftpd\ftpd.cfg" (xcopy "%sd%:\switchbros\backup\ftpd\ftpd.cfg" "%sd%:\config\ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\icongrabber\config.json" (xcopy "%sd%:\switchbros\backup\icongrabber\config.json" "%sd%:\config\icongrabber\config.json\*" /H /Y /C /R /S /E /I) >nul 2>nul
GOTO systempartitionen

REM ============================================================
:nurbasissystem
ECHO OFF
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
xcopy "%sd%:\switchbros\system\b\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
if exist "%sd%:\switchbros\backup\Fizeau\config.ini" (xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\ftpd\ftpd.cfg" (xcopy "%sd%:\switchbros\backup\ftpd\ftpd.cfg" "%sd%:\config\ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\icongrabber\config.json" (xcopy "%sd%:\switchbros\backup\icongrabber\config.json" "%sd%:\config\icongrabber\config.json\*" /H /Y /C /R /S /E /I) >nul 2>nul
GOTO systempartitionen

REM ============================================================
:androidpartition
ECHO OFF
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
xcopy "%sd%:\switchbros\system\ba\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\android\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
if exist "%sd%:\switchbros\backup\Fizeau\config.ini" (xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\ftpd\ftpd.cfg" (xcopy "%sd%:\switchbros\backup\ftpd\ftpd.cfg" "%sd%:\config\ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\icongrabber\config.json" (xcopy "%sd%:\switchbros\backup\icongrabber\config.json" "%sd%:\config\icongrabber\config.json\*" /H /Y /C /R /S /E /I) >nul 2>nul
GOTO systempartitionen

REM ============================================================
:linuxpartition
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Welche der vier Linux Distributionen wirst du spaeter nutzen?
echo.
echo      A = Arch Linux
echo      B = Ubuntu Bionic (empfohlen, wenn unsicher (L4T fuer modchip))
echo      C = Fedora Linux
echo      D = Ubuntu
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
set "Linux="
set /p Linux=Waehle deine Linux Distribution: 
if /i "%Linux%"=="A" (
xcopy "%sd%:\switchbros\system\bu\arch\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\arch\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
if /i "%Linux%"=="B" (
xcopy "%sd%:\switchbros\system\bu\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
if /i "%Linux%"=="C" (
xcopy "%sd%:\switchbros\system\bu\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
if /i "%Linux%"=="D" (
xcopy "%sd%:\switchbros\system\bu\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
if exist "%sd%:\switchbros\backup\Fizeau\config.ini" (xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\ftpd\ftpd.cfg" (xcopy "%sd%:\switchbros\backup\ftpd\ftpd.cfg" "%sd%:\config\ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\icongrabber\config.json" (xcopy "%sd%:\switchbros\backup\icongrabber\config.json" "%sd%:\config\icongrabber\config.json\*" /H /Y /C /R /S /E /I) >nul 2>nul
GOTO systempartitionen

REM ============================================================
:lakkapartition
ECHO OFF
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
xcopy "%sd%:\switchbros\system\bl\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\lakka\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
if exist "%sd%:\switchbros\backup\Fizeau\config.ini" (xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\ftpd\ftpd.cfg" (xcopy "%sd%:\switchbros\backup\ftpd\ftpd.cfg" "%sd%:\config\ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
GOTO systempartitionen

REM ============================================================
:androidlinux
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Welche der vier Linux Distributionen wirst du spaeter nutzen?
echo.
echo      A = Arch Linux
echo      B = Ubuntu Bionic (empfohlen, wenn unsicher (L4T fuer modchip))
echo      C = Fedora Linux
echo      D = Ubuntu
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
set "Linux="
set /p Linux=Waehle deine Linux Distribution: 
if /i "%Linux%"=="A" (
xcopy "%sd%:\switchbros\system\bau\arch\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\arch\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
if /i "%Linux%"=="B" (
xcopy "%sd%:\switchbros\system\bau\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
if /i "%Linux%"=="C" (
xcopy "%sd%:\switchbros\system\bau\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
if /i "%Linux%"=="D" (
xcopy "%sd%:\switchbros\system\bau\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
xcopy "%sd%:\switchbros\system\images\android\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
if exist "%sd%:\switchbros\backup\Fizeau\config.ini" (xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\ftpd\ftpd.cfg" (xcopy "%sd%:\switchbros\backup\ftpd\ftpd.cfg" "%sd%:\config\ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\icongrabber\config.json" (xcopy "%sd%:\switchbros\backup\icongrabber\config.json" "%sd%:\config\icongrabber\config.json\*" /H /Y /C /R /S /E /I) >nul 2>nul
GOTO systempartitionen

REM ============================================================
:androidlakka
ECHO OFF
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^! >nul 2>nul
echo.
echo -----------------------------------------------------------------------------------------------------
xcopy "%sd%:\switchbros\system\bal\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\lakka\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\android\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
if exist "%sd%:\switchbros\backup\Fizeau\config.ini" (xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\ftpd\ftpd.cfg" (xcopy "%sd%:\switchbros\backup\ftpd\ftpd.cfg" "%sd%:\config\ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\icongrabber\config.json" (xcopy "%sd%:\switchbros\backup\icongrabber\config.json" "%sd%:\config\icongrabber\config.json\*" /H /Y /C /R /S /E /I) >nul 2>nul
GOTO systempartitionen

REM ============================================================
:androidlinuxlakka
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Welche der vier Linux Distributionen wirst du spaeter nutzen?
echo.
echo      A = Arch Linux
echo      B = Ubuntu Bionic (empfohlen, wenn unsicher (L4T fuer modchip))
echo      C = Fedora Linux
echo      D = Ubuntu
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
set "Linux="
set /p Linux=Waehle deine Linux Distribution: 
if /i "%Linux%"=="A" (
xcopy "%sd%:\switchbros\system\balu\arch\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\arch\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
if /i "%Linux%"=="B" (
xcopy "%sd%:\switchbros\system\balu\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
if /i "%Linux%"=="C" (
xcopy "%sd%:\switchbros\system\balu\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
if /i "%Linux%"=="D" (
xcopy "%sd%:\switchbros\system\balu\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
xcopy "%sd%:\switchbros\system\images\android\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\lakka\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
if exist "%sd%:\switchbros\backup\Fizeau\config.ini" (xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\ftpd\ftpd.cfg" (xcopy "%sd%:\switchbros\backup\ftpd\ftpd.cfg" "%sd%:\config\ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\icongrabber\config.json" (xcopy "%sd%:\switchbros\backup\icongrabber\config.json" "%sd%:\config\icongrabber\config.json\*" /H /Y /C /R /S /E /I) >nul 2>nul
GOTO systempartitionen

REM ============================================================
:linuxlakka
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Welche der vier Linux Distributionen wirst du spaeter nutzen?
echo.
echo      A = Arch Linux
echo      B = Ubuntu Bionic (empfohlen, wenn unsicher (L4T fuer modchip))
echo      C = Fedora Linux
echo      D = Ubuntu
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
set "Linux="
set /p Linux=Waehle deine Linux Distribution: 
if /i "%Linux%"=="A" (
xcopy "%sd%:\switchbros\system\blu\arch\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\arch\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
if /i "%Linux%"=="B" (
xcopy "%sd%:\switchbros\system\blu\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
if /i "%Linux%"=="C" (
xcopy "%sd%:\switchbros\system\blu\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
if /i "%Linux%"=="D" (
xcopy "%sd%:\switchbros\system\blu\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\system\images\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
)
xcopy "%sd%:\switchbros\system\images\lakka\*" "%sd%:\" /H /Y /C /R /S /E /I
if exist "%sd%:\switchbros\backup\Fizeau\config.ini" (xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\ftpd\ftpd.cfg" (xcopy "%sd%:\switchbros\backup\ftpd\ftpd.cfg" "%sd%:\config\ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\icongrabber\config.json" (xcopy "%sd%:\switchbros\backup\icongrabber\config.json" "%sd%:\config\icongrabber\config.json\*" /H /Y /C /R /S /E /I) >nul 2>nul
GOTO systempartitionen

REM ============================================================
:kindgerecht
ECHO OFF
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

set /p kindgerecht=Waehle deine Tinfoil Version: 
	if "%kindgerecht%"=="1" GOTO tinfoila
	if "%kindgerecht%"=="2" GOTO tinfoilb
	if /i "%kindgerecht%"=="W" GOTO tinfoilno
	if /i "%kindgerecht%"=="H" GOTO hauptmenue

REM ============================================================
:tinfoila
ECHO OFF
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
xcopy "%sd%:\switchbros\kids\switch\*" "%sd%:\switch\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\kids\tinfoilhbmenu\*" "%sd%:\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\kids\NSPs\*" "%sd%:\NSPs\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\backup\Tinfoil\locations.conf" "%sd%:\switch\tinfoil\*" /H /Y /C /R /S /E /I >nul 2>nul
GOTO themepaket

REM ============================================================
:tinfoilb
ECHO OFF
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
xcopy "%sd%:\switchbros\kids\switch\*" "%sd%:\switch\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\kids\tinfoilhomescreen\*" "%sd%:\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\kids\NSPs\*" "%sd%:\NSPs\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\backup\Tinfoil\locations.conf" "%sd%:\switch\tinfoil\*" /H /Y /C /R /S /E /I >nul 2>nul
GOTO themepaket

REM ============================================================
:tinfoilno
ECHO OFF
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
RD /s /q "%sd%:\switch\tinfoil" >nul 2>nul
del "%sd%:\NSPs\Tinfoil [050000BADDAD0000][15.0][v0].nsp" >nul 2>nul
GOTO themepaket

REM ============================================================
:themepaket
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Hier kannst du unser SwitchBros_ThemeApps-Paket installieren lassen^^! 
echo.
echo      Das ThemeApps_Paket besteht aus folgenden Apps: 
echo.
echo      NX-ThemeInstaller = Theme-System einrichten und Themes installieren^^! 
echo.
echo      ThemezerNX = mehr als 1000 Themes suchen und downloaden^^! 
echo      Icongrabber = Verbinde dich ueber die steamgriddb.com Seite und
echo                    passe deine Spiele-Icons an (Steam API wird benoetigt (naechster Schritt))^^! 
echo      sys-tweak = Wird fuer Vertikale und horzontale Icons benoetigt^^! 
echo.
echo      1 = ThemeApps_Paket installieren^^!
echo.
echo      2 = ThemeApps_Paket deinstallieren^^!
echo.
echo      W = Ueberspringen und im Skript weiter gehen^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo      H = Zurueck zum Hauptmenue
echo -----------------------------------------------------------------------------------------------------
echo.

set /p themepaket=Sollen die ThemeApps installiert werden: 
	if "%themepaket%"=="1" GOTO themepaketinst
	if "%themepaket%"=="2" GOTO themepaketdeinst
	if /i "%themepaket%"=="W" GOTO systemmodule
	if /i "%themepaket%"=="H" GOTO hauptmenue

REM ============================================================
:themepaketinst
ECHO OFF
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
xcopy "%sd%:\switchbros\theme\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
if exist "%sd%:\backup\IconGrabber\config.json" (xcopy "%sd%:\backup\IconGrabber\config.json" "%sd%:\config\IconGrabber\*" /H /Y /C /R /S /E /I) >nul 2>nul
GOTO steamapiangeben

REM ============================================================
:steamapiangeben
ECHO OFF
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
echo      Drueckst du hier nur die Eingabetaste ohne Eingabe wird dieser Schritt uebersprungen^^!
echo      (Sinnvoll wenn du die API bereits in der IconGrabber config drin hast^^!)
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set /p steamapi=Bitte gib deine Steam API ein: 
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
ECHO OFF
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
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
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo     Das Tesla-Overlay Menue koennt ihr auf der Switch aufrufen mit: 
echo.
echo                          ZL + ZR + PLUS Taste 
echo.
echo     1 = Tesla-Overlay mit allen Modulen (nicht empfohlen)!
echo     2 = Tesla-Overlay mit Standard SwitchBros Modulen (empfohlen wenn unsicher)!
echo     3 = Tesla-Overlay mit einzeln ausgewaehlten Modulen (empfohlen)!
echo.
echo     W = Ueberspringen und im Skript weiter gehen^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo     H = Zurueck zum Hauptmenue
echo -----------------------------------------------------------------------------------------------------
echo.

set /p sysmod=Welches Tesla-Overlay soll installiert werden?: 
	if "%sysmod%"=="1" GOTO teslakomplett
	if "%sysmod%"=="2" GOTO teslaminimal
	if "%sysmod%"=="3" GOTO teslamodintro
	if /i "%sysmod%"=="W" GOTO attributeundmac
	if /i "%sysmod%"=="H" GOTO hauptmenue

REM ============================================================
:teslakomplett
ECHO OFF
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
	xcopy "%sd%:\switchbros\sys-modul\Tesla-menu\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\BootSoundNX\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\EdiZon\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\emuiibo\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\fastcfwswitch\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\Fizeau\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\ldnmitm\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\MissionControl\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\ovlSysmodule\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\Status-Monitor-Overlay\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\sys-clk\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\sys-clk-Editor\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\sys-con\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\sysdvr-overlay\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps

REM ============================================================
:teslaminimal
ECHO OFF
COLOR 0E
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      BITTE WARTEN...^^! >nul 2>nul
echo.
echo -----------------------------------------------------------------------------------------------------
	xcopy "%sd%:\switchbros\sys-modul\Tesla-menu\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\fastcfwswitch\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\MissionControl\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\ovlSysmodule\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\Status-Monitor-Overlay\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\sys-clk\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\sys-clk-Editor\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\sys-modul\sys-con\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	RD /s /q "%sd%:\atmosphere\contents\00FF0000000002AA"
	RD /s /q "%sd%:\config\BootSoundNX"
	RD /s /q "%sd%:\atmosphere\contents\054e4f4558454000"
	RD /s /q "%sd%:\atmosphere\contents\010000000000000D"
	RD /s /q "%sd%:\atmosphere\contents\0100000000001013"
	RD /s /q "%sd%:\switch\EdiZon"
	RD /s /q "%sd%:\switch\breeze"
	RD /s /q "%sd%:\switch\appstore\.get\packages\EdiZon"
	del "%sd%:\switch\.overlays\4_ovlEdiZon.ovl"
	RD /s /q "%sd%:\atmosphere\contents\0100000000000352"
	RD /s /q "%sd%:\emuiibo"
	RD /s /q "%sd%:\switch\appstore\.get\packages\emuiibo"
	del "%sd%:\switch\.overlays\2_emuiibo.ovl"
	RD /s /q "%sd%:\atmosphere\contents\0100000000000F12"
	RD /s /q "%sd%:\config\Fizeau"
	RD /s /q "%sd%:\switch\Fizeau"
	RD /s /q "%sd%:\switch\appstore\.get\packages\Fizeau"
	del "%sd%:\switch\.overlays\5_Fizeau.ovl"
	RD /s /q "%sd%:\atmosphere\contents\4200000000000010"
	RD /s /q "%sd%:\switch\ldn_mitm_config"
	RD /s /q "%sd%:\switch\appstore\.get\packages\ldn_mitm_config"
	del "%sd%:\switch\.overlays\1_ldnmitm_config"
	RD /s /q "%sd%:\atmosphere\contents\00FF0000A53BB665"
	RD /s /q "%sd%:\config\sysdvr"
	RD /s /q "%sd%:\switch\.overlays\6_sysdvr-overlay.ovl"
	RD /s /q "%sd%:\switch\appstore\.get\packages\SysDVR-conf"
	RD /s /q "%sd%:\switch\appstore\.get\packages\sysdvr-overlay"
	RD /s /q "%sd%:\switch\SysDVR-conf"
	GOTO zusatzapps

REM ============================================================
:teslamodintro
COLOR 0E
xcopy "%sd%:\switchbros\sys-modul\Tesla-menu\*" "%sd%:\" /H /Y /C /R /S /E /I
GOTO teslamodular

REM ============================================================
:teslamodular
ECHO OFF
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
echo       2 = Edizon (Cheats nutzen)
echo       3 = emuiibo (damit kann man virtuelle amiibos nutzen)
echo       4 = fastCFWswitch (Launcher fuer Payloads (nicht fuer Modchip))
echo       5 = Fizeau (Bildschirmanzeige optimieren/verbessern)
echo       6 = ldn_mitm (LAN-Play App)
echo       7 = MissionControl (fremd Controller ueber Bluetooth)
echo       8 = ovlSysmodule (Tesla-Overlay module aktivieren/deaktivieren)
echo       9 = Status-Monitor-Overlay (Werte der Switch an anzeigen)
echo      10 = sys-clk (Switch Uebertakten/Untertakten)
echo      11 = sys-clk-Editor (Werte in die config.ini von sys-clk eintragen)
echo      12 = sys-con (fremd Controller ueber USB)
echo      13 = SysDVR-Overlay (Switch Bildschirm auf den PC uebertragen)
echo.
echo       W = Ueberspringen und im Skript weiter gehen^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo       H = Zurueck zum Hauptmenue
echo -----------------------------------------------------------------------------------------------------
echo.

set "teslamods="
set /p teslamods=Welche Tesla-Overlay Module sollen installiert werden?: 
	if "%teslamods%"=="1" GOTO bootsoundnx
	if "%teslamods%"=="2" GOTO edizon
	if "%teslamods%"=="3" GOTO emuiibo
	if "%teslamods%"=="4" GOTO fastcfwswitch
	if "%teslamods%"=="5" GOTO fizeau
	if "%teslamods%"=="6" GOTO ldnmitm
	if "%teslamods%"=="7" GOTO missioncontrol
	if "%teslamods%"=="8" GOTO ovlssysmodule
	if "%teslamods%"=="9" GOTO statmon
	if "%teslamods%"=="10" GOTO sysclk
	if "%teslamods%"=="11" GOTO sysclkedit
	if "%teslamods%"=="12" GOTO syscon
	if "%teslamods%"=="13" GOTO sysdvr
	if /i "%teslamods%"=="W" GOTO zusatzapps
	if /i "%teslamods%"=="H" GOTO hauptmenue

REM ============================================================
:bootsoundnx
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll BootSoundNX installiert oder deinstalliert werden?
echo.
echo    1 = BootSoundNX installieren
echo    2 = BootSoundNX deinstallieren
echo.
echo    T = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "bootsoundnx="
set /p bootsoundnx=Bitte triff deine Auswahl: 
	if "%bootsoundnx%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\BootSoundNX\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO teslamodular
	)
	if "%bootsoundnx%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\00FF0000000002AA"
	RD /s /q "%sd%:\config\BootSoundNX"
	GOTO teslamodular
	)
	if "%bootsoundnx%"=="3" GOTO teslamodular

REM ============================================================
:edizon
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll EdiZon installiert oder deinstalliert werden?
echo.
echo    1 = EdiZon installieren
echo    2 = EdiZon deinstallieren
echo.
echo    T = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "edizon="
set /p edizon=Bitte triff deine Auswahl: 
	if "%edizon%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\EdiZon\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO teslamodular
	)
	if "%edizon%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\054e4f4558454000"
	RD /s /q "%sd%:\atmosphere\contents\010000000000000D"
	RD /s /q "%sd%:\atmosphere\contents\0100000000001013"
	RD /s /q "%sd%:\switch\EdiZon"
	RD /s /q "%sd%:\switch\breeze"
	RD /s /q "%sd%:\switch\appstore\.get\packages\EdiZon"
	del "%sd%:\switch\.overlays\4_ovlEdiZon.ovl"
	GOTO teslamodular
	)
	if "%edizon%"=="3" GOTO teslamodular

REM ============================================================
:emuiibo
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll emuiibo installiert oder deinstalliert werden?
echo.
echo    1 = emuiibo installieren
echo    2 = emuiibo deinstallieren
echo.
echo    T = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "emuiibo="
set /p emuiibo=Bitte triff deine Auswahl: 
	if "%emuiibo%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\emuiibo\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO teslamodular
	)
	if "%emuiibo%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\0100000000000352"
	RD /s /q "%sd%:\emuiibo"
	RD /s /q "%sd%:\switch\appstore\.get\packages\emuiibo"
	del "%sd%:\switch\.overlays\2_emuiibo.ovl"
	GOTO teslamodular
	)
	if "%emuiibo%"=="3" GOTO teslamodular

REM ============================================================
:fastcfwswitch
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll fastCFWSwitch installiert oder deinstalliert werden?
echo.
echo    1 = fastCFWSwitch installieren
echo    2 = fastCFWSwitch deinstallieren
echo.
echo    T = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "fastcfwswitch="
set /p fastcfwswitch=Bitte triff deine Auswahl: 
	if "%fastcfwswitch%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\fastCFWSwitch\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	if exist "%sd%:\switchbros\backup\fastcfwswitch\config.ini" (xcopy "%sd%:\switchbros\backup\fastcfwswitch\config.ini" "%sd%:\config\fastCFWSwitch\*" /H /Y /C /R /S /E /I) >nul 2>nul
	GOTO teslamodular
	)
	if "%fastcfwswitch%"=="2" (
	RD /s /q "%sd%:\config\fastCFWSwitch"
	RD /s /q "%sd%:\switch\appstore\.get\packages\fastCFWSwitch"
	del "%sd%:\switch\.overlays\0_fastCFWswitch.ovl"
	GOTO teslamodular
	)
	if "%fastcfwswitch%"=="3" GOTO teslamodular

REM ============================================================
:fizeau
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll Fizeau installiert oder deinstalliert werden?
echo.
echo    1 = Fizeau installieren
echo    2 = Fizeau deinstallieren
echo.
echo    T = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "fizeau="
set /p fizeau=Bitte triff deine Auswahl: 
	if "%fizeau%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\Fizeau\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\config.ini" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO teslamodular
	)
	if "%fizeau%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\0100000000000F12"
	RD /s /q "%sd%:\config\Fizeau"
	RD /s /q "%sd%:\switch\Fizeau"
	RD /s /q "%sd%:\switch\appstore\.get\packages\Fizeau"
	del "%sd%:\switch\.overlays\5_Fizeau.ovl"
	GOTO teslamodular
	)
	if "%fizeau%"=="3" GOTO teslamodular

REM ============================================================
:ldnmitm
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll ldnmitm installiert oder deinstalliert werden?
echo.
echo    1 = ldnmitm installieren
echo    2 = ldnmitm deinstallieren
echo.
echo    T = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "ldnmitm="
set /p ldnmitm=Bitte triff deine Auswahl: 
	if "%ldnmitm%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\ldnmitm\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO teslamodular
	)
	if "%ldnmitm%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\4200000000000010"
	RD /s /q "%sd%:\switch\ldn_mitm_config"
	RD /s /q "%sd%:\switch\appstore\.get\packages\ldn_mitm_config"
	del "%sd%:\switch\.overlays\1_ldnmitm_config"
	GOTO teslamodular
	)
	if "%ldnmitm%"=="3" GOTO teslamodular

REM ============================================================
:missioncontrol
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll MissionControl installiert oder deinstalliert werden?
echo.
echo    1 = MissionControl installieren
echo    2 = MissionControl deinstallieren
echo.
echo    T = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "missioncontrol="
set /p missioncontrol=Bitte triff deine Auswahl: 
	if "%missioncontrol%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\MissionControl\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO teslamodular
	)
	if "%missioncontrol%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\010000000000bd00"
	RD /s /q "%sd%:\atmosphere\contents\exefs_patches\bluetooth_patches"
	RD /s /q "%sd%:\config\MissionControl"
	RD /s /q "%sd%:\switch\appstore\.get\packages\missioncontrol"
	GOTO teslamodular
	)
	if "%missioncontrol%"=="3" GOTO teslamodular

REM ============================================================
:ovlssysmodule
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll ovl-Sysmodul installiert oder deinstalliert werden?
echo.
echo    1 = ovl-Sysmodul installieren
echo    2 = ovl-Sysmodul deinstallieren
echo.
echo    T = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "ovlssysmodule="
set /p ovlssysmodule=Bitte triff deine Auswahl: 
	if "%ovlssysmodule%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\ovlSysmodule\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO teslamodular
	)
	if "%ovlssysmodule%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\ovlssysmodule"
	del "%sd%:\switch\.overlays\7_ovlSysmodules.ovl"
	GOTO teslamodular
	)
	if "%ovlssysmodule%"=="3" GOTO teslamodular

REM ============================================================
:statmon
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll Status-Monitor-Overlay installiert oder deinstalliert werden?
echo.
echo    1 = Status-Monitor-Overlay installieren
echo    2 = Status-Monitor-Overlay deinstallieren
echo.
echo    T = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "statmon="
set /p statmon=Bitte triff deine Auswahl: 
	if "%statmon%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\Status-Monitor-Overlay\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO teslamodular
	)
	if "%statmon%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\Status-Monitor-Overlay"
	del "%sd%:\switch\.overlays\8_Status-Monitor-Overlay.ovl"
	GOTO teslamodular
	)
	if "%statmon%"=="3" GOTO teslamodular

REM ============================================================
:sysclk
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll sys-clk installiert oder deinstalliert werden?
echo.
echo    1 = sys-clk installieren
echo    2 = sys-clk deinstallieren
echo.
echo    T = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "sysclk="
set /p sysclk=Bitte triff deine Auswahl: 
	if "%sysclk%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\sys-clk\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO teslamodular
	)
	if "%sysclk%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\00FF0000636C6BFF"
	RD /s /q "%sd%:\config\sys-clk"
	RD /s /q "%sd%:\switch\.overlays\3_sys-clk-overlay"
	RD /s /q "%sd%:\switch\appstore\.get\packages\sys-clk-manager"
	RD /s /q "%sd%:\switch\sys-clk-manager"
	GOTO teslamodular
	)
	if "%sysclk%"=="3" GOTO teslamodular

REM ============================================================
:sysclkedit
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll sys-clk-Editor installiert oder deinstalliert werden?
echo.
echo    1 = sys-clk-Editor installieren
echo    2 = sys-clk-Editor deinstallieren
echo.
echo    T = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "sysclkedit="
set /p sysclkedit=Bitte triff deine Auswahl: 
	if "%sysclkedit%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\sys-clk-Editor\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO teslamodular
	)
	if "%sysclkedit%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\sys-clk-Editor"
	RD /s /q "%sd%:\switch\sys-clk-Editor"
	GOTO teslamodular
	)
	if "%sysclkedit%"=="3" GOTO teslamodular

REM ============================================================
:syscon
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll sys-con installiert oder deinstalliert werden?
echo.
echo    1 = sys-con installieren
echo    2 = sys-con deinstallieren
echo.
echo    T = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "syscon="
set /p syscon=Bitte triff deine Auswahl: 
	if "%syscon%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\sys-con\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO teslamodular
	)
	if "%syscon%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\690000000000000D"
	RD /s /q "%sd%:\config\sys-con"
	RD /s /q "%sd%:\switch\appstore\.get\packages\sys-con"
	GOTO teslamodular
	)
	if "%syscon%"=="3" GOTO teslamodular

REM ============================================================
:sysdvr
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll sysDVR installiert oder deinstalliert werden?
echo.
echo    1 = sysDVR installieren
echo    2 = sysDVR deinstallieren
echo.
echo    T = Zurueck zum Tesla-Overlay Einzelmodul Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "syscon="
set /p syscon=Bitte triff deine Auswahl: 
	if "%syscon%"=="1" (
	xcopy "%sd%:\switchbros\sys-modul\sysdvr-overlay\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO teslamodular
	)
	if "%syscon%"=="2" (
	RD /s /q "%sd%:\atmosphere\contents\00FF0000A53BB665"
	RD /s /q "%sd%:\config\sysdvr"
	RD /s /q "%sd%:\switch\.overlays\6_sysdvr-overlay.ovl"
	RD /s /q "%sd%:\switch\appstore\.get\packages\SysDVR-conf"
	RD /s /q "%sd%:\switch\appstore\.get\packages\sysdvr-overlay"
	RD /s /q "%sd%:\switch\SysDVR-conf"
	GOTO teslamodular
	)
	if "%syscon%"=="3" GOTO teslamodular

REM ============================================================
:zusatzapps
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo     Waehle hier ein paar Apps die zusaetzlich installiert / deinstalliert werden sollen^^! 
echo.
echo     Erst wenn du auf 'Weiter' gehst wird das Skript fortgesetzt^^! 
echo.
echo      1 = Amiibo Generator (Generiert Amiibos)
echo      2 = Amiigo (Amiibos ueber emuiibo im Tesla-Overlay nutzen)
echo      3 = chiaki (PS4/PS5 auf der Switch streamen)
echo      4 = fake08 (Pico8 Emulator)
echo      5 = Goldleaf (NSP installieren und andere Dinge)
echo      6 = Homebrew-Details (App Details von hbmenu Apps)
echo      7 = MelonDS (NintendoDS Emulator)
echo      8 = MiiPort (Mii importieren/exportieren)
echo      9 = Moonlight (PC auf der Switch streamen)
echo     10 = Neumann (Spielstände sichern/wiederherstellen)
echo     11 = NX-Activity-Log (Aktivitaeten auf der Switch anzeigen lassen)
echo     12 = NX-Locale-Switcher (Region aendern)
echo     13 = NX-Shell (Dateimanager)
echo     14 = NX-Gallery (Switch Album am PC oder Handy ansehen)
echo     15 = NXMP (Mediaplayer)
echo     16 = Switch-Remote-Play (PC auf der Switch streamen)
echo     17 = TencentSwitcherGui (Chinesisch auf englisch stellen)
echo     18 = vgedit (Dateien auf der Switch bearbeiten)
echo.
echo      W = Ueberspringen und im Skript weiter gehen^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo      H = Zurueck zum Hauptmenue
echo -----------------------------------------------------------------------------------------------------
echo.

set "datenapps="
set /p datenapps=Welche Tesla-Overlay Module sollen installiert werden?: 
	if "%datenapps%"=="1" GOTO amiibogenerator
	if "%datenapps%"=="2" GOTO amiigo
	if "%datenapps%"=="3" GOTO chiaki
	if "%datenapps%"=="4" GOTO fake08
	if "%datenapps%"=="5" GOTO goldleaf
	if "%datenapps%"=="6" GOTO homebrewdetails
	if "%datenapps%"=="7" GOTO melonds
	if "%datenapps%"=="8" GOTO miiport
	if "%datenapps%"=="9" GOTO moonlight
	if "%datenapps%"=="10" GOTO neumann
	if "%datenapps%"=="11" GOTO nxactivitylog
	if "%datenapps%"=="12" GOTO nxlocaleswitcher
	if "%datenapps%"=="13" GOTO nxshell
	if "%datenapps%"=="14" GOTO nxgallery
	if "%datenapps%"=="15" GOTO nxmp
	if "%datenapps%"=="16" GOTO switchremoteplay
	if "%datenapps%"=="17" GOTO tencentswitcher
	if "%datenapps%"=="18" GOTO vgedit
	if /i "%datenapps%"=="W" GOTO attributeundmac
	if /i "%datenapps%"=="H" GOTO hauptmenue

REM ============================================================
:amiibogenerator
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll Amiibo Generator installiert oder deinstalliert werden?
echo.
echo    1 = Amiibo Generator installieren
echo    2 = Amiibo Generator deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "amiibogenerator="
set /p amiibogenerator=Bitte triff deine Auswahl: 
	if "%amiibogenerator%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\AmiiboGenerator\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%amiibogenerator%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\AmiiboGenerator"
	RD /s /q "%sd%:\switch\AmiiboGenerator"
	GOTO zusatzapps
	)
	if "%amiibogenerator%"=="3" GOTO zusatzapps

REM ============================================================
:amiigo
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll Amiigo installiert oder deinstalliert werden?
echo.
echo    1 = Amiigo installieren
echo    2 = Amiigo deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "amiigo="
set /p amiigo=Bitte triff deine Auswahl: 
	if "%amiigo%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\Amiigo\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%amiigo%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\Amiigo"
	RD /s /q "%sd%:\switch\Amiigo"
	GOTO zusatzapps
	)
	if "%amiigo%"=="3" GOTO zusatzapps

REM ============================================================
:chiaki
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll chiaki installiert oder deinstalliert werden?
echo.
echo    1 = chiaki installieren
echo    2 = chiaki deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "chiaki="
set /p chiaki=Bitte triff deine Auswahl: 
	if "%chiaki%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\chiaki\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%chiaki%"=="2" (
	RD /s /q "%sd%:\switch\chiaki"
	GOTO zusatzapps
	)
	if "%chiaki%"=="3" GOTO zusatzapps

REM ============================================================
:fake08
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll Fake-08 installiert oder deinstalliert werden?
echo.
echo    1 = Fake-08 installieren
echo    2 = Fake-08 deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "fake08="
set /p fake08=Bitte triff deine Auswahl: 
	if "%fake08%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\fake08\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%fake08%"=="2" (
	RD /s /q "%sd%:\switch\fake08"
	GOTO zusatzapps
	)
	if "%fake08%"=="3" GOTO zusatzapps

REM ============================================================
:goldleaf
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll Goldleaf installiert oder deinstalliert werden?
echo.
echo    1 = Goldleaf installieren
echo    2 = Goldleaf deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "goldleaf="
set /p goldleaf=Bitte triff deine Auswahl: 
	if "%goldleaf%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\Goldleaf\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%goldleaf%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\Goldleaf"
	RD /s /q "%sd%:\switch\Goldleaf"
	GOTO zusatzapps
	)
	if "%goldleaf%"=="3" GOTO zusatzapps

REM ============================================================
:homebrewdetails
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll Homebrew-Details installiert oder deinstalliert werden?
echo.
echo    1 = Homebrew-Details installieren
echo    2 = Homebrew-Details deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "homebrewdetails="
set /p homebrewdetails=Bitte triff deine Auswahl: 
	if "%homebrewdetails%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\Homebrew-Details\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%homebrewdetails%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\Homebrew-Details"
	RD /s /q "%sd%:\switch\Homebrew-Details"
	GOTO zusatzapps
	)
	if "%homebrewdetails%"=="3" GOTO zusatzapps

REM ============================================================
:melonds
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll MelonDS installiert oder deinstalliert werden?
echo.
echo    1 = MelonDS installieren
echo    2 = MelonDS deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "melonds="
set /p melonds=Bitte triff deine Auswahl: 
	if "%melonds%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\melonDS\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%melonds%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\melonDS"
	RD /s /q "%sd%:\switch\melonDS"
	GOTO zusatzapps
	)
	if "%melonds%"=="3" GOTO zusatzapps

REM ============================================================
:miiport
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll MiiPort installiert oder deinstalliert werden?
echo.
echo    1 = MiiPort installieren
echo    2 = MiiPort deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "miiport="
set /p miiport=Bitte triff deine Auswahl: 
	if "%miiport%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\MiiPort\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%miiport%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\MiiPort"
	RD /s /q "%sd%:\switch\MiiPort"
	GOTO zusatzapps
	)
	if "%miiport%"=="3" GOTO zusatzapps

REM ============================================================
:moonlight
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll Moonlight installiert oder deinstalliert werden?
echo.
echo    1 = Moonlight installieren
echo    2 = Moonlight deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "moonlight="
set /p moonlight=Bitte triff deine Auswahl: 
	if "%moonlight%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\Moonlight\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%moonlight%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\Moonlight-Switch"
	RD /s /q "%sd%:\switch\Moonlight-Switch"
	GOTO zusatzapps
	)
	if "%moonlight%"=="3" GOTO zusatzapps

REM ============================================================
:neumann
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll Neumann installiert oder deinstalliert werden?
echo.
echo    1 = Neumann installieren
echo    2 = Neumann deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "neumann="
set /p neumann=Bitte triff deine Auswahl: 
	if "%neumann%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\Neumann\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%neumann%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\Neumann"
	RD /s /q "%sd%:\switch\Neumann"
	GOTO zusatzapps
	)
	if "%neumann%"=="3" GOTO zusatzapps

REM ============================================================
:nxactivitylog
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll NX-Activity-Log installiert oder deinstalliert werden?
echo.
echo    1 = NX-Activity-Log installieren
echo    2 = NX-Activity-Log deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "nxactivitylog="
set /p nxactivitylog=Bitte triff deine Auswahl: 
	if "%nxactivitylog%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\NX-Activity-Log\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%nxactivitylog%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\NX-Activity-Log"
	RD /s /q "%sd%:\switch\NX-Activity-Log"
	GOTO zusatzapps
	)
	if "%nxactivitylog%"=="3" GOTO zusatzapps

REM ============================================================
:nxlocaleswitcher
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll NX-Locale-Switcher installiert oder deinstalliert werden?
echo.
echo    1 = NX-Locale-Switcher installieren
echo    2 = NX-Locale-Switcher deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "nxlocaleswitcher="
set /p nxlocaleswitcher=Bitte triff deine Auswahl: 
	if "%nxlocaleswitcher%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\nx-locale-switcher\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%nxlocaleswitcher%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\nx-locale-switcher"
	RD /s /q "%sd%:\switch\nx-locale-switcher"
	GOTO zusatzapps
	)
	if "%nxlocaleswitcher%"=="3" GOTO zusatzapps

REM ============================================================
:nxshell
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll NX-Shell installiert oder deinstalliert werden?
echo.
echo    1 = NX-Shell installieren
echo    2 = NX-Shell deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "nxshell="
set /p nxshell=Bitte triff deine Auswahl: 
	if "%nxshell%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\NX-Shell\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%nxshell%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\NX-Shell"
	RD /s /q "%sd%:\switch\NX-Shell"
	GOTO zusatzapps
	)
	if "%nxshell%"=="3" GOTO zusatzapps

REM ============================================================
:nxgallery
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll NXGallery installiert oder deinstalliert werden?
echo.
echo    1 = NXGallery installieren
echo    2 = NXGallery deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "nxgallery="
set /p nxgallery=Bitte triff deine Auswahl: 
	if "%nxgallery%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\NXGallery\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%nxgallery%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\NXGallery"
	RD /s /q "%sd%:\switch\NXGallery"
	GOTO zusatzapps
	)
	if "%nxgallery%"=="3" GOTO zusatzapps

REM ============================================================
:nxmp
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll NXMP installiert oder deinstalliert werden?
echo.
echo    1 = NXMP installieren
echo    2 = NXMP deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "nxmp="
set /p nxmp=Bitte triff deine Auswahl: 
	if "%nxmp%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\nxmp\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%nxmp%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\nxmp"
	RD /s /q "%sd%:\switch\nxmp"
	GOTO zusatzapps
	)
	if "%nxmp%"=="3" GOTO zusatzapps

REM ============================================================
:switchremoteplay
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll Switch-Remote-Play installiert oder deinstalliert werden?
echo.
echo    1 = Switch-Remote-Play installieren
echo    2 = Switch-Remote-Play deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "switchremoteplay="
set /p switchremoteplay=Bitte triff deine Auswahl: 
	if "%switchremoteplay%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\switch-remote-play\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%switchremoteplay%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\switch-remote-play"
	RD /s /q "%sd%:\switch\switch-remote-play"
	GOTO zusatzapps
	)
	if "%switchremoteplay%"=="3" GOTO zusatzapps

REM ============================================================
:tencentswitcher
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll TencentSwitcherGui installiert oder deinstalliert werden?
echo.
echo    1 = TencentSwitcherGui installieren
echo    2 = TencentSwitcherGui deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "tencentswitcher="
set /p tencentswitcher=Bitte triff deine Auswahl: 
	if "%tencentswitcher%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\TencentSwitcherGui\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%tencentswitcher%"=="2" (
	RD /s /q "%sd%:\switch\TencentSwitcherGui"
	GOTO zusatzapps
	)
	if "%tencentswitcher%"=="3" GOTO zusatzapps

REM ============================================================
:vgedit
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo    Soll vgedit installiert oder deinstalliert werden?
echo.
echo    1 = vgedit installieren
echo    2 = vgedit deinstallieren
echo.
echo    T = Zurueck zum Zusatz-Apps Uebersicht Menue^^!
echo -----------------------------------------------------------------------------------------------------
echo.

set "vgedit="
set /p vgedit=Bitte triff deine Auswahl: 
	if "%vgedit%"=="1" (
	xcopy "%sd%:\switchbros\zusatzapps\vgedit\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
	GOTO zusatzapps
	)
	if "%vgedit%"=="2" (
	RD /s /q "%sd%:\switch\appstore\.get\packages\vgedit"
	RD /s /q "%sd%:\switch\vgedit"
	GOTO zusatzapps
	)
	if "%vgedit%"=="3" GOTO zusatzapps

REM ============================================================
:attributeundmac
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo     Attribute in Ordnung bringen und MacOS Dateien entfernen^^!
echo.
echo.
echo.
echo     1 = Attribute bereinigen (fixArchiveBit) und weiter im Skript^^!
echo.
echo.
echo     2 = Attribute bereinigen (fixArchiveBit) und zurueck zum Hauptmenue^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo     H = Zurueck zum Hauptmenue
echo -----------------------------------------------------------------------------------------------------
echo.

set /p fixattrib=Welches Tesla-Overlay soll installiert werden?: 
	if "%fixattrib%"=="1" GOTO fixattribweiter
	if "%fixattrib%"=="2" GOTO fixattribhaupt
	if /i "%fixattrib%"=="H" GOTO hauptmenue

REM ============================================================
:fixattribhaupt
ECHO OFF
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
echo       BITTE WARTEN...
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
if exist "%sd%:\NSPs" (
	attrib -A -R /S /D %sd%:\NSPs\*
	attrib -A -R %sd%:\NSPs)
if exist "%sd%:\emuiibo" (
	attrib -A -R /S /D %sd%:\emuiibo\*
	attrib -A -R %sd%:\emuiibo)
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
if exist "%sd%:\hbmenu.nro" (attrib -A -R %sd%:\hbmenu.nro)
if exist "%sd%:\boot.dat" (attrib -A -R %sd%:\boot.dat)
if exist "%sd%:\boot.ini" (attrib -A -R %sd%:\boot.ini)
if exist "%sd%:\payload.bin" (attrib -A -R %sd%:\payload.bin)
if exist "%sd%:\exosphere.ini" (attrib -A -R %sd%:\exosphere.ini)
rem Entfernen typischer MacOS Dateien (die sind ueberall die Bruedaz)
if exist .DS_STORE del /s /q /f /a .DS_STORE
if exist ._.* del /s /q /f /a ._.*
GOTO hauptmenue

REM ============================================================
:fixattribweiter
ECHO OFF
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
echo       BITTE WARTEN...
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
if exist "%sd%:\NSPs" (
	attrib -A -R /S /D %sd%:\NSPs\*
	attrib -A -R %sd%:\NSPs)
if exist "%sd%:\emuiibo" (
	attrib -A -R /S /D %sd%:\emuiibo\*
	attrib -A -R %sd%:\emuiibo)
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
if exist "%sd%:\hbmenu.nro" (attrib -A -R %sd%:\hbmenu.nro)
if exist "%sd%:\boot.dat" (attrib -A -R %sd%:\boot.dat)
if exist "%sd%:\boot.ini" (attrib -A -R %sd%:\boot.ini)
if exist "%sd%:\payload.bin" (attrib -A -R %sd%:\payload.bin)
if exist "%sd%:\exosphere.ini" (attrib -A -R %sd%:\exosphere.ini)
rem Entfernen typischer MacOS Dateien (die sind ueberall die Bruedaz)
if exist .DS_STORE del /s /q /f /a .DS_STORE
if exist ._.* del /s /q /f /a ._.*

REM ============================================================
:hekateusb
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo     Volle USB3 Geschwindigkeit mit hekate USM Modus^^!
echo.
echo     1 = USB3 in die Registry eintragen und weiter im Skript^^!
echo         (muss nur einmal fuer einen PC ausgefuehrt werden)
echo.
echo.
echo     2 = USB3 nicht in die Registry eintragen und weiter im Skript^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo     H = Zurueck zum Hauptmenue
echo -----------------------------------------------------------------------------------------------------
echo.

set /p usb3=Welche USB3 Einstellung: 
	if "%usb3%"=="1" GOTO usb3weiter
	if "%usb3%"=="2" GOTO aufraeumen
	if /i "%usb3%"=="H" GOTO hauptmenue

:usb3weiter
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\usbstor\11ECA7E0 /v MaximumTransferLength /t REG_DWORD /d 00100000 /f>nul 2>&1
GOTO aufraeumen

REM ============================================================
:aufraeumen
if exist "%sd%:\SwitchBros_BasisPaket" (RD /s /q "%sd%:\SwitchBros_BasisPaket")
if exist "%sd%:\switchbros" (RD /s /q "%sd%:\switchbros")
if exist "%sd%:\switch\switchbros-updater\update.te" (del "%sd%:\switch\switchbros-updater\update.te")
if exist "%sd%:\System Volume Information" (RD /s /q "%sd%:\System Volume Information")
if exist "%sd%:\*.bat" (del "%sd%:\*.bat")
if exist "%sd%:\*.te" (del "%sd%:\*.te")
if exist "%sd%:\*.exe" (del "%sd%:\*.exe")
if exist "%sd%:\*.bak" (del "%sd%:\*.bak")
if exist "%sd%:\SwitchBros_BasisPaket.zip" (del "%sd%:\SwitchBros_BasisPaket.zip")
if exist "%sd%:\SwitchBros.txt" (del "%sd%:\SwitchBros.txt")
if exist "%sd%:\switch\switchbrosupdater" (RD /s /q "%sd%:\switch\switchbrosupdater")

if %bootdat%==0 (
  (
	if exist "%sd%:\bootloader\payloads\hwfly_toolbox.bin" (del "%sd%:\bootloader\payloads\hwfly_toolbox.bin")
	if exist "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp" (del "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp")
	if exist "%sd%:\boot.dat" (del "%sd%:\boot.dat")
	if exist "%sd%:\boot.ini" (del "%sd%:\boot.ini") 
	if exist "%sd%:\payload.bin" (del "%sd%:\payload.bin")
	if exist "%sd%:\sdloader.enc" (del "%sd%:\sdloader.enc")
	if exist "%sd%:\firmware.bin" (del "%sd%:\firmware.bin")
	) 
) else (
	if exist "%sd%:\config\fastCFWSwitch" (RD /s /q "%sd%:\config\fastCFWSwitch")
	if exist "%sd%:\config\Fizeau" (RD /s /q "%sd%:\config\Fizeau")
	if exist "%sd%:\switch\Fizeau" (RD /s /q "%sd%:\switch\Fizeau")
	if exist "%sd%:\switch\.overlays\5_Fizeau.ovl" (del "%sd%:\switch\.overlays\*fizeau*.ovl")
	if exist "%sd%:\atmosphere\contents\0100000000000F12" (RD /s /q "%sd%:\atmosphere\contents\0100000000000F12")
	if exist "%sd%:\switch\.overlays\0_fastCFWswitch.ovl" (del "%sd%:\switch\.overlays\fastCFWswitch.ovl")
	if exist "%sd%:\bootloader\payloads\CommonProblemResolver.bin" (del "%sd%:\bootloader\payloads\CommonProblemResolver.bin")
	if not exist "%sd%:\sdloader.enc" (xcopy "%sd%:\switchbros\hwfly\*" "%sd%:\" /H /Y /C /R /S /E /I)
)

cd %sd%:\
GOTO endemutig

REM ============================================================
:falschesdkarte
ECHO OFF
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo                 Gewaehlter Laufwerksbuchstabe: %sd%:/
echo                    Keine SD-Karte in Laufwerk: %sd%:/
echo.
echo.
echo     1.  Laufwerksbuchstabe ist korrekt^^!
echo     2.  Anderen Laufwerksbuchstaben waehlen
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo     B.  Beenden
echo.

set st=
set /p st=:

for %%A in ("J" "j" "1" "?" "?") do if "%st%"==%%A (GOTO hauptmenue)
for %%A in ("N" "n" "2" "?" "?") do if "%st%"==%%A (GOTO neuekarte)
for %%A in ("B" "b" "?" "?") do if "%st%"==%%A (GOTO endemutig)

REM ============================================================
:endemutig
ECHO OFF
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
echo    Soll dieses Programm jetzt beendet werden?
echo.
echo    J = Dieses Programm beenden^^!
echo    N = Zurueck zum Hauptmenue^^!
echo.  
echo -----------------------------------------------------------------------------------------------------

set /p ende=Soll das Programm beendet werden? (J/N): 
	if /i "%ende%"=="N" GOTO hauptmenue
	if /i "%ende%"=="J" (
powershell -Command "Start-Sleep -Seconds 5"
exit
)

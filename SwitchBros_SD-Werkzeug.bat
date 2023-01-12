@echo off
SETLOCAL EnableDelayedExpansion
chcp 1252 >nul 2>&1
title SwitchBros. SD-Werkzeug
rem Dieses Skript basiert auf der Batch-Datei von rashevskyv seinem Kefir Paket
rem der ebenfalls Entwickler von DBI ist! RIESEN DANK!!! an diesen tollen Entwickler!

COLOR 0E
set wd=%temp%\files
set clear=0
set cfw=AMS
set cfwname=Atmosphere
set theme_flag=0
set theme=0
set syscon=1
set missioncontrol=1
set bootdat=1
set payloadbin=1

set sd=%1
if not defined %sd% (GOTO anfang)

REM =========================================================================
:neuekarte
echo.
cls
echo ------------------------------------------------------------------------
echo.
echo                             Willkommen zum
echo.
echo                       ..--== Switch Bros. ==--..
echo.
echo                        SD-Werkzeug fuer Windows
echo.
echo     Switch Bros. - The Switch Hacking, Modding and Themes Community!
echo.
echo ------------------------------------------------------------------------
echo                     - WARNUNG - WARNUNG - WARNUNG -
echo. 
echo   Wenn du dieses Skript (SD-Werkzeug.bat) von deiner SD-Karte aus
echo   gestartet hast, dann schliesse es bitte sofort!
echo. 
echo   Starte die SD-Werkzeug.bat NUR aus dem "Basis" Ordner von deinem PC!
echo ------------------------------------------------------------------------
echo.
echo   Schritt 1 = Stecke deine SD-Karte in deinen PC
echo   Schritt 2 = Navigiere zum Basis Ordner auf deinem PC und fuehre dort
echo               diese Datei hier aus (SD-Werkzeug.bat)
echo.
echo   Bitte gib (NUR) den Laufwerksbuchstaben deiner SD-Karte ein
echo.
echo ------------------------------------------------------------------------
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

REM =========================================================================
:anfang
if not exist "%sd%:\boot.dat" (if exist "%sd%:\atmosphere" (set bootdat=0))
if not exist "%sd%:\atmosphere\contents\690000000000000D\flags\boot2.flag" (set syscon=0)
if not exist "%sd%:\atmosphere\contents\010000000000bd00\flags\boot2.flag" (set missioncontrol=0)
if not exist "%sd%:\switchbros\backup" (
	md "%sd%:\switchbros\backup"
	md "%sd%:\switchbros\backup\fastCFWSwitch"
	md "%sd%:\switchbros\backup\Fizeau"
	md "%sd%:\switchbros\backup\Tinfoil"
	md "%sd%:\switchbros\backup\ftpd"
)

echo.
cls
echo ------------------------------------------------------------------------
echo.
echo          Dein altes Paket (egal welches) wird jetzt bereinigt!
echo.
echo          Du entscheidest wie es weiter geht Neo!
echo.
echo A = Du waehlst die rote Pille und begibst dich in die tiefen der
echo     Switch Bros. Community! TOP! Sehr gute Wahl!
echo.
echo B = Du nimmst die blaue Pille und wachst in deinem Zimmer auf,
echo     immer noch mit deinem alten langweiligen Paket :P
echo.
echo ------------------------------------------------------------------------
echo.

set /p neuistgut="Waehle deine Pille: "
if /i "%neuistgut%"=="A" GOTO sbgibgas
if /i "%neuistgut%"=="B" GOTO endefeige

REM =========================================================================
:endefeige
COLOR 09
echo. 
cls
echo ------------------------------------------------------------------------
echo                       JA HAU DOCH AB DU LUTSCHA!!!
echo.
echo                      BLEIB BEI DEINEM BLOEDEN PAKET!
echo. 
echo                   Druecke die Eingabetaste zum beenden
echo ------------------------------------------------------------------------

if exist "%wd%" (RD /s /q "%wd%\*")
pause>nul 2>&1
exit

REM =========================================================================
:sbgibgas
if exist "%sd%:\bootloader\hekate_ipl.ini" (
	xcopy "%sd%:\bootloader\hekate_ipl.ini" "%sd%:\switchbros\backup" /H /Y /C /R /S /E /I
)
if exist "%sd%:\bootloader\nyx.ini" (
	xcopy "%sd%:\bootloader\nyx.ini" "%sd%:\switchbros\backup" /H /Y /C /R /S /E /I
)
if exist "%sd%:\config\fastCFWSwitch\config.ini" (
	xcopy "%sd%:\config\fastCFWSwitch" "%sd%:\switchbros\backup\fastCFWSwitch" /H /Y /C /R /S /E /I
)
if exist "%sd%:\config\Fizeau\config.ini" (
	xcopy "%sd%:\config\Fizeau" "%sd%:\switchbros\backup\Fizeau" /H /Y /C /R /S /E /I
)
if exist "%sd%:\config\ftpd\config.ini" (
	xcopy "%sd%:\config\ftpd" "%sd%:\switchbros\backup\ftpd" /H /Y /C /R /S /E /I
)
if exist "%sd%:\switch\tinfoil\locations.conf" (
	xcopy "%sd%:\switch\tinfoil\locations.conf" "%sd%:\switchbros\backup\tinfoil" /H /Y /C /R /S /E /I
)

if exist "%sd%:\atmosphere\titles" (rename %sd%:\atmosphere\titles contents)
if exist "%sd%:\atmosphere\title" (rename %sd%:\atmosphere\title contents)
if exist "%sd%:\atmosphere\content" (rename %sd%:\atmosphere\content contents)

if exist "%sd%:\atmosphere\config*" (RD /s /q "%sd%:\atmosphere\config*")
if exist "%sd%:\atmosphere\*reports*" (RD /s /q "%sd%:\atmosphere\*reports*")
if exist "%sd%:\atmosphere\exefs_patches" (RD /s /q "%sd%:\atmosphere\exefs_patches")
if exist "%sd%:\atmosphere\extras" (RD /s /q "%sd%:\atmosphere\extras")
if exist "%sd%:\atmosphere\fatal_errors" (RD /s /q "%sd%:\atmosphere\fatal_errors")
if exist "%sd%:\atmosphere\flags" (RD /s /q "%sd%:\atmosphere\flags")
if exist "%sd%:\atmosphere\hosts" (RD /s /q  "%sd%:\atmosphere\hosts")
if exist "%sd%:\atmosphere\*kip*" (RD /s /q "%sd%:\atmosphere\*kip*")
if exist "%sd%:\atmosphere\logs" (RD /s /q  "%sd%:\atmosphere\logs")

if exist "%sd%:\atmosphere\package3" (del "%sd%:\atmosphere\package3")
if exist "%sd%:\atmosphere\*.bin" (del "%sd%:\atmosphere\*.bin")
if exist "%sd%:\atmosphere\*.nsp" (del "%sd%:\atmosphere\*.nsp")
if exist "%sd%:\atmosphere\*.romfs" (del "%sd%:\atmosphere\*.romfs")
if exist "%sd%:\atmosphere\*.sig" (del "%sd%:\atmosphere\*.sig")
if exist "%sd%:\atmosphere\*.json" (del "%sd%:\atmosphere\*.json")
if exist "%sd%:\atmosphere\*.ini" (del "%sd%:\atmosphere\*.ini")

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

if exist "%sd%:\bootloader" (RD /s /q "%sd%:\bootloader")
if exist "%sd%:\modules" (RD /s /q "%sd%:\modules")
if exist "%sd%:\NSPs" (RD /s /q "%sd%:\NSPs")
if exist "%sd%:\*firmware*" (RD /s /q "%sd%:\*firmware*")
if exist "%sd%:\*Custom*" (RD /s /q "%sd%:\*Custom*")
if exist "%sd%:\SaltySD" (RD /s /q "%sd%:\SaltySD")
if exist "%sd%:\atmo" (RD /s /q "%sd%:\atmo")
if exist "%sd%:\ams" (RD /s /q "%sd%:\ams")
if exist "%sd%:\scripts" (RD /s /q "%sd%:\scripts")
if exist "%sd%:\music" (RD /s /q "%sd%:\music")
if exist "%sd%:\tools*" (RD /s /q "%sd%:\tools*")
if exist "%sd%:\config" (RD /s /q "%sd%:\config")
if exist "%sd%:\games" (RD /s /q "%sd%:\games")
if exist "%sd%:\pegascape" (RD /s /q "%sd%:\pegascape")
if exist "%sd%:\TinGen" (RD /s /q "%sd%:\TinGen")
if exist "%sd%:\sept" (RD /s /q  "%sd%:\sept")
if exist "%sd%:\.git" (RD /s /q "%sd%:\.git")
if exist "%sd%:\hbmenu.nro" (del "%sd%:\hbmenu.nro")
if exist "%sd%:\startup.te" (del "%sd%:\startup.te")
if exist "%sd%:\*.ini" (del "%sd%:\*.ini")
if exist "%sd%:\*.bin" (del "%sd%:\*.bin")
if exist "%sd%:\*.txt" (del "%sd%:\*.txt")
if exist "%sd%:\*.dat" (del "%sd%:\*.dat")
if exist "%sd%:\*.log" (del "%sd%:\*.log")

if exist "%sd%:\*sxos*" (RD /s /q  "%sd%:\*sxos*")

if exist "%sd%:\switch\*amsPack*" (RD /s /q "%sd%:\switch\*amsPack*")
if exist "%sd%:\switch\*DeepSea*" (RD /s /q "%sd%:\switch\*DeepSea*")
if exist "%sd%:\switch\*ShallowSea*" (RD /s /q "%sd%:\switch\*ShallowSea*")
if exist "%sd%:\switch\tinwoo*" (RD /s /q "%sd%:\switch\tinwoo*")
if exist "%sd%:\switch\tinleaf*" (RD /s /q "%sd%:\switch\tinleaf*")
if exist "%sd%:\switch\daybreak*" (RD /s /q "%sd%:\switch\daybreak*")
if exist "%sd%:\switch\*kefir*" (RD /s /q "%sd%:\switch\*kefir*")
if exist "%sd%:\switch\*download*" (RD /s /q "%sd%:\switch\*download*")
if exist "%sd%:\switch\*updater*" (RD /s /q "%sd%:\switch\*updater*")
if exist "%sd%:\switch\switch-time" (RD /s /q "%sd%:\switch\switch-time")
if exist "%sd%:\switch\NXMPforMe" (RD /s /q "%sd%:\switch\NXMPforMe")
if exist "%sd%:\switch\lithium" (RD /s /q "%sd%:\switch\lithium")
if exist "%sd%:\switch\LinkUser" (RD /s /q "%sd%:\switch\LinkUser")
if exist "%sd%:\switch\TriPlayer" (RD /s /q "%sd%:\switch\TriPlayer")
if exist "%sd%:\switch\KosmosToolbox" (RD /s /q "%sd%:\switch\KosmosToolbox")
if exist "%sd%:\switch\mercury" (RD /s /q "%sd%:\switch\mercury")
if exist "%sd%:\switch\Fizeau" (RD /s /q "%sd%:\switch\Fizeau\")
if exist "%sd%:\switch\FreshHay" (RD /s /q "%sd%:\switch\FreshHay\")
if exist "%sd%:\switch\nx-ntpc" (RD /s /q "%sd%:\switch\nx-ntpc\")
if exist "%sd%:\switch\incognito" (RD /s /q "%sd%:\switch\incognito")
if exist "%sd%:\switch\fakenews-injector" (RD /s /q "%sd%:\switch\fakenews-injector")
if exist "%sd%:\switch\ChoiDujourNX" (RD /s /q "%sd%:\switch\ChoiDujourNX")
if exist "%sd%:\switch\Reboot_to_Payload" (RD /s /q "%sd%:\switch\Reboot_to_Payload")
if exist "%sd%:\switch\pplay" (RD /s /q "%sd%:\switch\pplay")
if exist "%sd%:\switch\SX*" (RD /s /q "%sd%:\switch\SX*")
if exist "%sd%:\switch\tinfoil" (RD /s /q "%sd%:\switch\tinfoil")
if exist "%sd%:\switch\.overlays" (RD /s /q "%sd%:\switch\.overlays")
if exist "%sd%:\switch\*.nro" (del "%sd%:\switch\*.nro")
if exist "%sd%:\switch\*.ini" (del "%sd%:\switch\*.ini")
if exist "%sd%:\switch\*.jar" (del "%sd%:\switch\*.jar")
if exist "%sd%:\switch\*.zip" (del "%sd%:\switch\*.zip")
if exist "%sd%:\switch\*.star" (del "%sd%:\switch\*.star")
if exist "%sd%:\switch\dbi\dbi.nro" (del "%sd%:\switch\dbi\dbi.nro")
if exist "%sd%:\switch\dbi\dbi.config" (
	xcopy /Y "%sd%:\switch\dbi\dbi.config" "%sd%:\switchbros\backup\dbi.config" /H /Y /C /R /S /E /I
)
if exist "%sd%:\switch\dbi\dbi.config" (del "%sd%:\switch\dbi\dbi.config")

REM =========================================================================
:backupordner
echo.
cls
echo ------------------------------------------------------------------------
echo.
echo     Bevor es losgeht, kann das Script fuer dich Backup-Ordner
echo     erstellen in denen du spaeter die Backups von hekate
echo     einfuegen kannst (BOOT0, BOOT1 und RAW GPP - Keys, etc.)
echo.
echo     Die erstellten Backups von hekate sind nicht gerade klein!              
echo     Gib bitte ein Laufwerk angeben das ueber ausreichend
echo     freien Speicherplatz verfuegt (ca. 35GB bzw. fuer OLED 65GB)!
echo.
echo     Folgende (leere) Ordner werden im angegebenen Laufwerk,
echo     auf deinem PC, fuer dich angelegt:
echo.             
echo   - SwitchBackup
echo      - sysNAND (fuer BOOT0, BOOT1 und RAW GPP)
echo      - Lockpick
echo         - Prodkeys-Devkeys (prod.keys und dev.keys)
echo         - Partial_AES_Keys (partial_aes.keys (Mariko Chip))
echo         - Amiibo_Keys
echo      - SD-Karten_Backup (CFW eingerichtet = Ein Backup davon)
echo.
echo.
echo     Brauchst du die Ordner nicht dann druecke nur die Eingabetaste!
echo.
echo ------------------------------------------------------------------------
echo.
set "LW="
set /p LW=Bitte gib einen gueltigen Laufwerksbuchstabe ein: 

if defined LW (
 (
    md "%LW%:\SwitchBackup\sysNAND"
    md "%LW%:\SwitchBackup\Lockpick\Prodkeys-Devkeys"
    md "%LW%:\SwitchBackup\Lockpick\Partial_AES_Keys"
    md "%LW%:\SwitchBackup\Lockpick\Amiibo_Keys"
    md "%LW%:\SwitchBackup\SD-Karten_Backup"
  ) 2>nul
) else (
    GOTO sblegtlos
)

REM =========================================================================
:sblegtlos
echo.
cls
echo ------------------------------------------------------------------------
echo.
echo   Jetzt wird das satanarchaeoluegenialkohoellische Switch Bros. Paket              
echo                  direkt auf deine SD-Karte geballert!         
echo.
echo                    Du verdienst halt nur das BESTE!      
echo.
echo.
echo         Druecke die Eingabetaste und loese dich von der Matrix!
echo.
echo ------------------------------------------------------------------------
pause>nul 2>&1

xcopy "%~dp0*" "%sd%:\" /H /Y /C /R /S /E

REM =========================================================================
:systempartitionen
echo.
cls
echo ------------------------------------------------------------------------
echo.
echo     Waehle die hekate Systeme aus, die dir spaeter in hekate zur
echo     Verfuegung stehen sollen!
echo.
echo     Entweder sind die Systeme bereits bei dir installiert, oder du
echo     moechtest diese spaeter installieren = Die Partitionen dafuer
echo     nicht vergessen (Partiton nachtraeglich geht nicht)!
echo.
echo ------------------------------------------------------------------------
echo     Achtung modchip Besitzer = LAKKA und Ubuntu Bionic
echo                                werden jetzt unterstuetzt!
echo.
echo     Android und die anderen Linux Distributionen z.Zt. NICHT!!!
echo ------------------------------------------------------------------------
echo.
echo 0 = alte hekate_ipl.ini behalten (nicht empfohlen)
echo 1 = Basis (Standard)
echo 2 = Basis + Android
echo 3 = Basis + Linux
echo 4 = Basis + LAKKA
echo 5 = Basis + Android + Linux
echo 6 = Basis + Android + LAKKA
echo 7 = Basis + Android + Linux + LAKKA
echo 8 = Basis + Linux + LAKKA
echo.
echo ------------------------------------------------------------------------
echo.

set /p eingabe="Deine Systemkombination: "
if /i "%eingabe%"=="0" GOTO altesystembehalten
if /i "%eingabe%"=="1" GOTO nurbasissystem
if /i "%eingabe%"=="2" GOTO androidpartition
if /i "%eingabe%"=="3" GOTO linuxpartition
if /i "%eingabe%"=="4" GOTO lakkapartition
if /i "%eingabe%"=="5" GOTO androidlinux
if /i "%eingabe%"=="6" GOTO androidlakka
if /i "%eingabe%"=="7" GOTO androidlinuxlakka
if /i "%eingabe%"=="8" GOTO linuxlakka

REM =========================================================================
:altesystembehalten
if exist "%sd%:\bootloader\nyx.bkp" (del "%sd%:\bootloader\nyx.bkp")
if exist "%sd%:\switchbros\backup\nyx.ini" (
	xcopy /Y "%sd%:\switchbros\backup\nyx.ini" "%sd%:\bootloader\nyx.ini" /H /Y /C /R /S /E /I
)
if exist "%sd%:\switchbros\backup\hekate_ipl.ini" (
	xcopy /Y "%sd%:\switchbros\backup\hekate_ipl.ini" "%sd%:\bootloader\hekate_ipl.ini" /H /Y /C /R /S /E /I
)
if exist "%sd%:\switchbros\backup\fastcfwswitch\config.ini" (
	xcopy /Y "%sd%:\switchbros\backup\fastcfwswitch\config.ini" "%sd%:\config\fastCFWSwitch\config.ini" /H /Y /C /R /S /E /I
)
GOTO kindgerecht

REM =========================================================================
:nurbasissystem
xcopy "%sd%:\switchbros\system\b\*" "%sd%:\" /H /Y /C /R /S /E /I
GOTO kindgerecht

REM =========================================================================
:androidpartition
xcopy "%sd%:\switchbros\system\ba\*" "%sd%:\" /H /Y /C /R /S /E /I
GOTO kindgerecht

REM =========================================================================
:linuxpartition
echo ------------------------------------------------------------------------
echo.
echo Welche der vier Linux Distributionen wirst du sp+�ter nutzen?
echo.
echo A = Arch Linux
echo B = Ubuntu Bionic (empfohlen, wenn unsicher (L4T fuer modchip))
echo C = Fedora Linux
echo D = Ubuntu
echo.
echo ------------------------------------------------------------------------
echo.
set "Linux="
set /p Linux=Waehle deine Linux Distribution: 
if /i "%Linux%"=="A" xcopy "%sd%:\switchbros\system\bu\arch\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i "%Linux%"=="B" xcopy "%sd%:\switchbros\system\bu\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i "%Linux%"=="C" xcopy "%sd%:\switchbros\system\bu\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i "%Linux%"=="D" xcopy "%sd%:\switchbros\system\bu\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I
GOTO kindgerecht

REM =========================================================================
:lakkapartition
xcopy "%sd%:\switchbros\system\bl\*" "%sd%:\" /H /Y /C /R /S /E /I
GOTO kindgerecht

REM =========================================================================
:androidlinux
echo ------------------------------------------------------------------------
echo.
echo Welche der vier Linux Distributionen wirst du sp+�ter nutzen?
echo.
echo A = Arch Linux
echo B = Ubuntu Bionic (empfohlen, wenn unsicher (L4T fuer modchip))
echo C = Fedora Linux
echo D = Ubuntu
echo.
echo ------------------------------------------------------------------------
echo.
set "Linux="
set /p Linux=Waehle deine Linux Distribution: 
if /i "%Linux%"=="A" xcopy "%sd%:\switchbros\system\bau\arch\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i "%Linux%"=="B" xcopy "%sd%:\switchbros\system\bau\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i "%Linux%"=="C" xcopy "%sd%:\switchbros\system\bau\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i "%Linux%"=="D" xcopy "%sd%:\switchbros\system\bau\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I
GOTO kindgerecht

REM =========================================================================
:androidlakka
xcopy "%sd%:\switchbros\system\bal\*" "%sd%:\" /H /Y /C /R /S /E /I
GOTO kindgerecht

REM =========================================================================
:androidlinuxlakka
echo ------------------------------------------------------------------------
echo.
echo Welche der vier Linux Distributionen wirst du sp+�ter nutzen?
echo.
echo A = Arch Linux
echo B = Ubuntu Bionic (empfohlen, wenn unsicher (L4T fuer modchip))
echo C = Fedora Linux
echo D = Ubuntu
echo.
echo ------------------------------------------------------------------------
echo.
set "Linux="
set /p Linux=Waehle deine Linux Distribution: 
if /i "%Linux%"=="A" xcopy "%sd%:\switchbros\system\balu\arch\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i "%Linux%"=="B" xcopy "%sd%:\switchbros\system\balu\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i "%Linux%"=="C" xcopy "%sd%:\switchbros\system\balu\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i "%Linux%"=="D" xcopy "%sd%:\switchbros\system\balu\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I
GOTO kindgerecht

REM =========================================================================
:linuxlakka
echo ------------------------------------------------------------------------
echo.
echo Welche der vier Linux Distributionen wirst du sp+�ter nutzen?
echo.
echo A = Arch Linux
echo B = Ubuntu Bionic (empfohlen, wenn unsicher (L4T fuer modchip))
echo C = Fedora Linux
echo D = Ubuntu
echo.
echo ------------------------------------------------------------------------
echo.
set "Linux="
set /p Linux=Waehle deine Linux Distribution: 
if /i "%Linux%"=="A" xcopy "%sd%:\switchbros\system\blu\arch\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i "%Linux%"=="B" xcopy "%sd%:\switchbros\system\blu\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i "%Linux%"=="C" xcopy "%sd%:\switchbros\system\blu\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i "%Linux%"=="D" xcopy "%sd%:\switchbros\system\blu\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I
GOTO kindgerecht

REM =========================================================================
:kindgerecht
echo.
cls
echo ------------------------------------------------------------------------
echo.
echo     Solltest du Kinder haben, und NICHT wollen das die App = Tinfoil 
echo     auf dem homescreen erscheint (empfohlen), dann kannst du hier
echo     auswaehlen welche Version von Tinfoil installiert werden soll!
echo.
echo     1. Tinfoil im hbmenu (nicht neben anderen Spielen auf dem homescreen)
echo.
echo     2. Tinfoil auf dem homescreen (aktualisiert sich spaeter selbst)
echo.
echo     W = Kein Tinfoil (Spiele manuell holen und installieren)
echo.
echo ------------------------------------------------------------------------
echo.

set /p kindgerecht=Waehle deine Tinfoil Version: 
	if /i "%kindgerecht%"=="1" (
		xcopy "%sd%:\switchbros\kids\tinfoilhbmenu\*" "%sd%:\" /H /Y /C /R /S /E /I
		xcopy "%sd%:\switchbros\kids\NSPs\*" "%sd%:\NSPs" /H /Y /C /R /S /E /I
		if exists "%sd%:\switchbros\backup\Tinfoil\locations.conf" (
			xcopy "%sd%:\switchbros\backup\Tinfoil\locations.conf" "%sd%:\switch\tinfoil\locations.conf" /H /Y /C /R /S /E /I
		)
	GOTO tinfoilhbmenu
	)
	if /i "%kindgerecht%"=="2" (
		xcopy "%sd%:\switchbros\kids\tinfoilhomescreen\*" "%sd%:\" /H /Y /C /R /S /E /I
		xcopy "%sd%:\switchbros\kids\NSPs\*" "%sd%:\NSPs" /H /Y /C /R /S /E /I
		if exists "%sd%:\switchbros\backup\Tinfoil\locations.conf" (
			xcopy "%sd%:\switchbros\backup\Tinfoil\locations.conf" "%sd%:\switch\tinfoil\locations.conf" /H /Y /C /R /S /E /I
		)
	GOTO tinfoilhbmenu
	)
	if /i "%kindgerecht%"=="W" (
		if exists "%sd%:\switch\tinfoil" (RD /s /q "%sd%:\switch\tinfoil")
		if exists "%sd%:\NSPs\Tinfoil[050000BADDAD0000][15.0][v0].nsp" (del "%sd%:\NSPs\Tinfoil[050000BADDAD0000][15.0][v0].nsp")
		GOTO themepaket
	)

REM =========================================================================
:themepaket
echo.
cls
echo ------------------------------------------------------------------------
echo.
echo     Hier kannst du unser SwitchBros_ThemeApps-Paket installieren lassen! 
echo                       (Geht auch spaeter manuell) 
echo.
echo     Das ThemeApps_Paket besteht aus folgenden Apps: 
echo.
echo     NX-ThemeInstaller = Theme-System einrichten und Themes installieren! 
echo     ThemezerNX = mehr als 1000 Themes suchen und downloaden! 
echo     Icongrabber = Verbinde dich ueber die steamgriddb.com Seite und
echo                   hole dir dein Lieblings-Icon (Steam API wird benoetigt)! 
echo     sys-tweak = Wird fuer Vertikale und horzontale Icons benoetigt! 
echo.
echo     Ja = ThemeApps_Paket installieren!
echo.
echo     Nein = Kein ThemeApps_Paket / Ueberspringen und Weiter! 
echo.
echo ------------------------------------------------------------------------
echo.

set /p themepaket=Sollen die ThemeApps installiert werden: 
	if /i "%themepaket%"=="Ja" GOTO themepaketinst
	if /i "%themepaket%"=="Nein" GOTO systemmodule

REM =========================================================================
:themepaketinst
    xcopy "%sd%:\switchbros\theme\*" "%sd%:\" /H /Y /C /R /S /E /I
	GOTO systemmodule

REM =========================================================================
:systemmodule
echo.
cls
echo ------------------------------------------------------------------------
echo.
echo     Das Tesla Overlay Menue wird aufgerufen mit: 
echo.
echo                          ZL + ZR + PLUS Taste 
echo.
echo 1. - Tesla-Overlay mit allen Modulen (nicht empfohlen)!
echo 2. - Tesla-Overlay mit Standard SwitchBros Modulen (empfohlen wenn unsicher)!
echo 3. - Tesla-Overlay mit einzeln ausgewaehlten Modulen (empfohlen)!
echo.
echo 4. - Kein Tesla-Overlay / Ueberspringen und Weiter!
echo.
echo ------------------------------------------------------------------------
echo.

set /p sysmod=Welches Tesla-Overlay soll installiert werden?: 
	if /i "%sysmod%"=="1" GOTO teslakomplett
	if /i "%sysmod%"=="2" GOTO teslaminimal
	if /i "%sysmod%"=="3" GOTO teslamodintro
	if /i "%sysmod%"=="4" GOTO fertisch

REM =========================================================================
:teslakomplett
	xcopy "%sd%:\switchbros\sys-modul\Tesla-menu\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\BootSoundNX\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\EdiZon\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\emuiibo\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\fastcfwswitch\*" "%sd%:\" /H /Y /C /R /S /E /I
	if exists "%sd%:\switchbros\backup\fastcfwswitch\config.ini" (
		xcopy "%sd%:\switchbros\backup\fastcfwswitch\config.ini" "%sd%:\config\fastCFWSwitch\config.ini" /H /Y /C /R /S /E /I
	)
	xcopy "%sd%:\switchbros\sys-modul\Fizeau\*" "%sd%:\" /H /Y /C /R /S /E /I
	if exists "%sd%:\switchbros\backup\Fizeau\config.ini" (
		xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\config.ini" /H /Y /C /R /S /E /I
	)
	xcopy "%sd%:\switchbros\sys-modul\ldnmitm\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\MissionControl\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\ovlSysmodule\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\Status-Monitor-Overlay\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\sys-clk\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\sys-clk-Editor\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\sys-con\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\sysdvr-overlay\*" "%sd%:\" /H /Y /C /R /S /E /I
	GOTO fertisch

REM =========================================================================
:teslaminimal
	xcopy "%sd%:\switchbros\sys-modul\Tesla-menu\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\BootSoundNX\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\emuiibo\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\fastcfwswitch\*" "%sd%:\" /H /Y /C /R /S /E /I
	if exists "%sd%:\switchbros\backup\fastcfwswitch\config.ini" (
		xcopy "%sd%:\switchbros\backup\fastcfwswitch\config.ini" "%sd%:\config\fastCFWSwitch\config.ini" /H /Y /C /R /S /E /I
	)
	xcopy "%sd%:\switchbros\sys-modul\Fizeau\*" "%sd%:\" /H /Y /C /R /S /E /I
	if exists "%sd%:\switchbros\backup\Fizeau\config.ini" (
		xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\config.ini" /H /Y /C /R /S /E /I
	)
	xcopy "%sd%:\switchbros\sys-modul\MissionControl\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\ovlSysmodule\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\Status-Monitor-Overlay\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\sys-clk\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\sys-clk-Editor\*" "%sd%:\" /H /Y /C /R /S /E /I
	xcopy "%sd%:\switchbros\sys-modul\sys-con\*" "%sd%:\" /H /Y /C /R /S /E /I
	GOTO fertisch

REM =========================================================================
:teslamodintro
	xcopy "%sd%:\switchbros\sys-modul\Tesla-menu\*" "%sd%:\" /H /Y /C /R /S /E /I
	GOTO teslamodular

REM =========================================================================
:teslamodular
echo.
cls
echo ------------------------------------------------------------------------
echo.
echo     Waehle hier die Module die du im Tesla-Overlay haben moechtest! 
echo     Das Tesla-Overlay ist bereits installiert! 
echo.
echo     Erst wenn du auf 'Weiter' gehst wird das Skript fortgesetzt! 
echo.
echo 1.  BootSoundNX (Bootsound.mp3 beim Starten der Switch abspielen)
echo 2.  Edizon (cheat app)
echo 3.  emuiibo (damit kann man virtuelle amiibos nutzen)
echo 4.  fastCFWswitch (ein launcher in alle Systeme (nicht fuer Modchip))
echo 5.  Fizeau ()
echo 6.  ldn_mitm (LAN-Play (Lokal mit anderen online spielen))
echo 7.  MissionControl (Controller mit echtem Bluetooth an der Switch nutzen)
echo 8.  ovlSysmodule
echo 9.  Status-Monitor-Overlay (zeigt einige Werte deiner Switch an (zum Beenden L3 + R3 druecken))
echo 10. sys-clk (app zum Uebertakten aber auch Untertakten)
echo 11. sys-clk-Editor (damit kann man neue Werte in die config.ini von sys-clk eintragen)
echo 12. sys-con (fremd Controller ueber USB nutzen)
echo 13. SysDVR-Overlay (Switch Bildschirm auf den PC uebertragen)
echo.
echo W = Weiter
echo.
echo ------------------------------------------------------------------------
echo.

set "teslamods="
set /p teslamods=Welche Tesla-Overlay Module sollen installiert werden?: 
	if /i "%teslamods%"=="1" GOTO bootsoundnx
	if /i "%teslamods%"=="2" GOTO edizon
	if /i "%teslamods%"=="3" GOTO emuiibo
	if /i "%teslamods%"=="4" GOTO fastcfwswitch
	if /i "%teslamods%"=="5" GOTO fizeau
	if /i "%teslamods%"=="6" GOTO ldnmitm
	if /i "%teslamods%"=="7" GOTO missioncontrol
	if /i "%teslamods%"=="8" GOTO ovlssysmodule
	if /i "%teslamods%"=="9" GOTO statmon
	if /i "%teslamods%"=="10" GOTO sysclk
	if /i "%teslamods%"=="11" GOTO sysclkedit
	if /i "%teslamods%"=="12" GOTO syscon
	if /i "%teslamods%"=="13" GOTO sysdvr
	if /i "%teslamods%"=="W" GOTO fertisch

REM =========================================================================
:bootsoundnx
	xcopy "%sd%:\switchbros\sys-modul\BootSoundNX\*" "%sd%:\" /H /Y /C /R /S /E /I
	GOTO teslamodular

REM =========================================================================
:edizon
	xcopy "%sd%:\switchbros\sys-modul\EdiZon\*" "%sd%:\" /H /Y /C /R /S /E /I
	GOTO teslamodular

REM =========================================================================
:emuiibo
	xcopy "%sd%:\switchbros\sys-modul\emuiibo\*" "%sd%:\" /H /Y /C /R /S /E /I
	GOTO teslamodular

REM =========================================================================
:fastcfwswitch
	xcopy "%sd%:\switchbros\sys-modul\fastcfwswitch\*" "%sd%:\" /H /Y /C /R /S /E /I
	if exists "%sd%:\switchbros\backup\fastcfwswitch\config.ini" (
		xcopy "%sd%:\switchbros\backup\fastcfwswitch\config.ini" "%sd%:\config\fastCFWSwitch\config.ini" /H /Y /C /R /S /E /I
	)
	GOTO teslamodular

REM =========================================================================
:fizeau
	xcopy "%sd%:\switchbros\sys-modul\Fizeau\*" "%sd%:\" /H /Y /C /R /S /E /I
	if exists "%sd%:\switchbros\backup\Fizeau\config.ini" (
		xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\config.ini" /H /Y /C /R /S /E /I
	)
	GOTO teslamodular

REM =========================================================================
:ldnmitm
	xcopy "%sd%:\switchbros\sys-modul\ldnmitm\*" "%sd%:\" /H /Y /C /R /S /E /I
	GOTO teslamodular

REM =========================================================================
:missioncontrol
	xcopy "%sd%:\switchbros\sys-modul\MissionControl\*" "%sd%:\" /H /Y /C /R /S /E /I
	GOTO teslamodular

REM =========================================================================
:ovlssysmodule
	xcopy "%sd%:\switchbros\sys-modul\ovlSysmodule\*" "%sd%:\" /H /Y /C /R /S /E /I
	GOTO teslamodular

REM =========================================================================
:statmon
	xcopy "%sd%:\switchbros\sys-modul\Status-Monitor-Overlay\*" "%sd%:\" /H /Y /C /R /S /E /I
	GOTO teslamodular

REM =========================================================================
:sysclk
	xcopy "%sd%:\switchbros\sys-modul\sys-clk\*" "%sd%:\" /H /Y /C /R /S /E /I
	GOTO teslamodular

REM =========================================================================
:sysclkedit
	xcopy "%sd%:\switchbros\sys-modul\sys-clk-Editor\*" "%sd%:\" /H /Y /C /R /S /E /I
	GOTO teslamodular

REM =========================================================================
:syscon
	xcopy "%sd%:\switchbros\sys-modul\sys-con\*" "%sd%:\" /H /Y /C /R /S /E /I
	GOTO teslamodular

REM =========================================================================
:sysdvr
	xcopy "%sd%:\switchbros\sys-modul\sysdvr-overlay\*" "%sd%:\" /H /Y /C /R /S /E /I
	GOTO teslamodular

REM =========================================================================
:fertisch
echo ------------------------------------------------------------------------
echo.
echo                       Attribute werden korrigiert! 
echo                          (Fix archive bit) 
echo.
echo                       Schreibschutz wird entfernt! 
echo.
echo ------------------------------------------------------------------------
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

rem Volle USB3 Geschwindigkeit in die Registry eintragen (hekate - USB3 Verbindung)
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\usbstor\11ECA7E0 /v MaximumTransferLength /t REG_DWORD /d 00100000 /f>nul 2>&1

rem Nach uns die Sintflut! Nein! Hinter uns wird natuerlich aufgeraemt :)
if exist "%sd%:\SwitchBros_BasisPaket" (RD /s /q "%sd%:\SwitchBros_BasisPaket")
if exist "%sd%:\switchbros" (RD /s /q "%sd%:\switchbros")
if exist "%sd%:\switch\switchbros-updater\update.te" (del "%sd%:\switch\switchbros-updater\update.te")
if exist "%wd%" (RD /s /q "%wd%\*")
if exist "%sd%:\startup.te" (del "%sd%:\startup.te")
if exist "%sd%:\bootloader\hekate_ipl_.bak" (del "%sd%:\bootloader\hekate_ipl_.bak")
if exist "%sd%:\bootloader\setup" (RD /s /q "%sd%:bootloader\setup")
if exist "%sd%:\System Volume Information" (RD /s /q "%sd%:\System Volume Information")
if exist "%sd%:\bootloader\nyx.ini_" (del "%sd%:\bootloader\nyx.ini_")
if exist "%sd%:\*.bat" (del "%sd%:\*.bat")
if exist "%sd%:\*.te" (del "%sd%:\*.te")
if exist "%sd%:\*.exe" (del "%sd%:\*.exe")
if exist "%sd%:\*.bak" (del "%sd%:\*.bak")
if exist "%sd%:\SwitchBros_BasisPaket.zip" (del "%sd%:\SwitchBros_BasisPaket.zip")
if exist "%sd%:\switch\switchbrosupdater" (RD /s /q "%sd%:\switch\switchbrosupdater")

if %syscon%==0 (
	RD /s /q "%sd%:\atmosphere\contents\690000000000000D"
	RD /s /q "%sd%:\config\sys-con"
	RD /s /q "%sd%:\switch\appstore\.get\packages\sys-con"
	)

if %missioncontrol%==0 (
	RD /s /q "%sd%:\atmosphere\contents\010000000000bd00"
	RD /s /q "%sd%:\atmosphere\contents\exefs_patches\bluetooth_patches"
	RD /s /q "%sd%:\config\MissionControl"
	RD /s /q "%sd%:\switch\appstore\.get\packages\missioncontrol"
	)

if %bootdat%==0 (
  (
	if exist "%sd%:\bootloader\payloads\hwfly_toolbox.bin" (del "%sd%:\bootloader\payloads\hwfly_toolbox.bin")
	if exist "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp" (del "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp")
	if exist "%sd%:\boot.dat" (del "%sd%:\boot.dat")
	if exist "%sd%:\boot.ini" (del "%sd%:\boot.ini") 
	if exist "%sd%:\payload.bin" (del "%sd%:\payload.bin")
	) 
) else (
	if exist "%sd%:\config\fastCFWSwitch" (RD /s /q "%sd%:\config\fastCFWSwitch")
	if exist "%sd%:\config\Fizeau" (RD /s /q "%sd%:\config\Fizeau")
	if exist "%sd%:\switch\Fizeau" (RD /s /q "%sd%:\switch\Fizeau")
	if exist "%sd%:\switch\.overlays\*Fizeau*.ovl" (del "%sd%:\switch\.overlays\*fizeau*.ovl")
	if exist "%sd%:\atmosphere\contents\0100000000000F12" (RD /s /q "%sd%:\atmosphere\contents\0100000000000F12")
	if exist "%sd%:\switch\.overlays\*fastCFWswitch*.ovl" (del "%sd%:\switch\.overlays\*fastCFWswitch*.ovl")
	if exist "%sd%:\bootloader\payloads\CommonProblemResolver.bin" (del "%sd%:\bootloader\payloads\CommonProblemResolver.bin")
)

cd %sd%:\

rem Entfernen typischer MacOS Dateien (die sind ueberall die Bruedaz)
if exist .DS_STORE del /s /q /f /a .DS_STORE
if exist ._.* del /s /q /f /a ._.*
GOTO endemutig

REM =========================================================================
:falschesdkarte
cls
COLOR 0C
echo ------------------------------------------------------------------------
echo                 Gewaehlter Laufwerksbuchstabe: %sd%:/
echo                    Keine SD-Karte in Laufwerk: %sd%:/
echo.
echo.
echo     1.  Laufwerksbuchstabe ist korrekt
echo     2.  Anderen Laufwerksbuchstaben waehlen
echo.
echo ------------------------------------------------------------------------
echo                                                             B.  Beenden
echo.

set st=
set /p st=:

for %%A in ("J" "j" "1" "?" "?") do if "%st%"==%%A (GOTO anfang)
for %%A in ("N" "n" "2" "?" "?") do if "%st%"==%%A (GOTO neuekarte)
for %%A in ("B" "b" "?" "?") do if "%st%"==%%A (GOTO endemutig)

REM =========================================================================
:rembkp

echo ------------------------------------------------------------------------
echo.
echo                         Entferne Backup Ordner
echo                             Bitte warten!
echo.
echo ------------------------------------------------------------------------

RD /s /q "%sd%:\_backup"
GOTO anfang

echo ------------------------------------------------------------------------
echo.
echo                         Entferne Backup Ordner
echo                             Bitte warten!
echo.
echo ------------------------------------------------------------------------

RD /s /q "%sd%:\_backup"
GOTO anfang

REM =========================================================================
:endemutig
echo. 
cls
COLOR 0A
echo ------------------------------------------------------------------------
echo                           Alles abgeschlossen
echo.
echo                    Viel Spass mit unserem Paket und
echo                 Willkommen in der Switch Bros. Community
echo.
echo.
echo                   Druecke irgendeine Taste zum beenden
echo ------------------------------------------------------------------------

if exist "%wd%" (RD /s /q "%wd%\*")
pause>nul 2>&1
exit
@echo off &setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1
title Switch Bros. SD-Werkzeug
rem Dieses Skript basiert auf der Batch-Datei von rashevskyv seinem Kefir Paket
rem der ebenfalls Entwickler von DBI ist! RIESEN DANK!!! an diesen tollen Entwickler!

COLOR 0E
set wd=%temp%\sdfiles
set clear=0
set cfw=AMS
set cfwname=Atmosphere
set theme_flag=0
set theme=0
set dbi=0
set tesla=0
set tesla_flag=1
set modchip=1
set bootdat=1
set syscon=1
set missioncontrol=1
set payloadbin=1
set nyx=0

:NEUEKARTE
COLOR 0E
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
echo.
echo          Bitte gib den Laufwerksbuchstaben deiner SD-Karte ein
echo                         NUR den Buchstaben!!!
echo.
echo ------------------------------------------------------------------------
echo.

for /f "tokens=3-6 delims=: " %%a in ('WMIC LOGICALDISK GET FreeSpace^,Name^,Size^,filesystem^,description ^|FINDSTR /I "Removable" ^|findstr /i "exFAT FAT32"') do (@echo wsh.echo "Laufwerksbuchstabe: %%c;" ^& " frei: " ^& FormatNumber^(cdbl^(%%b^)/1024/1024/1024, 2^)^& " GB;"^& " Groesse: " ^& FormatNumber^(cdbl^(%%d^)/1024/1024/1024, 2^)^& " GB;" ^& " FS: %%a" > %temp%\tmp.vbs & @if not "%%c"=="" @echo( & @cscript //nologo %temp%\tmp.vbs & del %temp%\tmp.vbs)
echo.
set /P sd="Laufwerksbuchstabe der SD-Karte: "

if not exist "%sd%:\" (
	set word=        Es befindet sich keine SD-Karte im Laufwerk %sd%         
	goto FALSCHESD
) else (
	if not exist "%sd%:\*" (goto FALSCHESD)
)

:MAIN
if not exist "%sd%:\boot.dat" (set bootdat=0)
if not exist "%sd%:\atmosphere\contents\690000000000000D\flags\boot2.flag" (set syscon=0)
if not exist "%sd%:\atmosphere\contents\010000000000bd00\flags\boot2.flag" (set missioncontrol=0)
if not exist "%sd%:\payload.bin" (set payloadbin=0)

echo.
cls
echo ------------------------------------------------------------------------
echo.
echo          Dein altes Paket (egal welches) wird jetzt bereinigt!
echo.
echo               Du entscheidest wie es weiter geht Neo?
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
if /i '%neuistgut%'=='A' goto GIBGAS
if /i '%neuistgut%'=='B' goto ENDEB

:ENDEB
COLOR 9
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

:GIBGAS

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
if exist "%sd%:\atmosphere\contents\0100000000000036" (RD /s /q "%sd%:\atmosphere\contents\0100000000000042")
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

if exist "%sd%:\bootloader\hekate_ipl.ini" (move /Y "%sd%:\bootloader\hekate_ipl.ini" "%wd%")
if exist "%sd%:\bootloader\nyx.ini" (move /Y "%sd%:\bootloader\nyx.ini" "%wd%")
if exist "%sd%:\config\fastCFWSwitch\config.ini" (move /Y "%sd%:\config\fastCFWSwitch\config.ini" "%wd%")
if exist "%sd%:\config\sys-ftpd\config.ini" (move /Y "%sd%:\config\sys-ftpd\config.ini" "%wd%\config.ftpd")

if exist "%sd%:\bootloader" (RD /s /q "%sd%:\bootloader")

if exist "%sd%:\modules" (RD /s /q "%sd%:\modules")
if exist "%sd%:\NSPs" (RD /s /q "%sd%:\NSPs")
if exist "%sd%:\*firmware*" (RD /s /q "%sd%:\*firmware*")
if exist "%sd%:\*Custom*" (RD /s /q "%sd%:\*Custom*")
if exist "%sd%:\SaltySD" (RD /s /q "%sd%:\SaltySD")
if exist "%sd%:\atmo" (RD /s /q "%sd%:\atmo")
if exist "%sd%:\scripts" (RD /s /q "%sd%:\scripts")
if exist "%sd%:\music" (RD /s /q "%sd%:\music")
if exist "%sd%:\tools*" (RD /s /q "%sd%:\tools*")
if exist "%sd%:\config" (RD /s /q "%sd%:\config")
if exist "%sd%:\games" (RD /s /q "%sd%:\games")
if exist "%sd%:\pegascape" (RD /s /q "%sd%:\pegascape")
if exist "%sd%:\TinGen" (RD /s /q "%sd%:\TinGen")
if exist "%sd%:\sept" (RD /s /q  "%sd%:\sept")
if exist "%sd%:\.git" (RD /s /q "%sd%:\.git")
if exist "%sd%:\*.ini" (del "%sd%:\*.ini")
if exist "%sd%:\*.bin" (del "%sd%:\*.bin")
if exist "%sd%:\*.txt" (del "%sd%:\*.txt")
if exist "%sd%:\*.dat" (del "%sd%:\*.dat")
if exist "%sd%:\*.log" (del "%sd%:\*.log")

if exist "%sd%:\hbmenu.nro" (del "%sd%:\hbmenu.nro")
if exist "%sd%:\startup.te" (del "%sd%:\startup.te")

if exist "%sd%:\sxos" (RD /s /q  "%sd%:\sxos")

if exist "%sd%:\switch\*amsPack*" (RD /s /q "%sd%:\switch\amsPack*")
if exist "%sd%:\switch\*DeepSea*" (RD /s /q "%sd%:\switch\DeepSea*")
if exist "%sd%:\switch\*ShallowSea*" (RD /s /q "%sd%:\switch\ShallowSea*")
if exist "%sd%:\switch\tinwoo*" (RD /s /q "%sd%:\switch\tinwoo*")
if exist "%sd%:\switch\tinleaf*" (RD /s /q "%sd%:\switch\tinleaf*")
if exist "%sd%:\switch\daybreak*" (RD /s /q "%sd%:\switch\daybreak*")
if exist "%sd%:\switch\*kefir*" (RD /s /q "%sd%:\switch\kefir*")
if exist "%sd%:\switch\*download*" (RD /s /q "%sd%:\switch\*download*")
if exist "%sd%:\switch\*updater*" (RD /s /q "%sd%:\switch\*updater*")
if exist "%sd%:\switch\switch-time" (RD /s /q "%sd%:\switch\switch-time")
if exist "%sd%:\switch\NXMPforMe" (RD /s /q "%sd%:\switch\NXPMforMe")
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
if exist "%sd%:\switch\dbi\dbi.config" (copy "%sd%:\switch\dbi\dbi.config" "%sd%:\switch\dbi\dbi.config.bak")
if exist "%sd%:\switch\dbi\dbi.config" (del "%sd%:\switch\dbi\dbi.config")

echo.
cls
echo ------------------------------------------------------------------------
echo.
echo       Bevor es losgeht, kann das Script fuer dich Backup-Ordner
echo          erstellen in denen du spaeter die Backups von hekate
echo        einfuegen kannst (BOOT0, BOOT1 und RAW GPP - Keys, etc.)
echo.
echo       Die erstellten Backups von hekate sind nicht gerade klein!              
echo   Deshalb solltest du bitte ein Laufwerk angeben das ueber ausreichend
echo      freien Speicherplatz verfuegt (ca. 35GB bzw. fuer OLED 65GB)!
echo.
echo Folgende (leere) Ordner werden im angegebenen LW fuer dich angelegt:              
echo   - SwitchBackup
echo      - sysNAND (fuer BOOT0, BOOT1 und RAW GPP)
echo      - Lockpick
echo         - Prodkeys-Devkeys (prod.keys und dev.keys)
echo         - Partial_AES_Keys (partial_aes.keys (Mariko Chip))
echo         - Amiibo_Keys
echo      - SD-Karten_Backup (CFW eingerichtet = Ein Backup davon)
echo.
echo.
echo   Moechtest du keine Ordner anlegen dann druecke nur die Eingabetaste!
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
    goto LOS
)

:LOS
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
echo               Druecke die Eingabetaste und zieh es durch!
echo.
echo ------------------------------------------------------------------------
pause>nul 2>&1

attrib -A -R "%~dp0*" /S /D
xcopy "%~dp0*" "%sd%:\" /H /Y /C /R /S /E

if exist "%sd%:\bootloader\nyx.bkp" (
	copy "%sd%:\bootloader\nyx.bkp" "%sd%:\bootloader\nyx.ini"
	del "%sd%:\bootloader\nyx.bkp"
	)

if exist "%wd%\config.ftpd" (copy /Y "%wd%\config.ftpd" "%sd%:config\sys-ftpd\config.ini")
if exist "%sd%:\nyx.ini" (copy /Y "%sd%:\nyx.ini" "%sd%:\bootloader\nyx.ini")

cls
echo ------------------------------------------------------------------------
echo.
echo       Waehle die hekate Systeme aus, die dir spaeter in hekate zur
echo       Verfuegung stehen sollen!
echo.
echo       Entweder sind die Systeme bereits bei dir installiert, oder du
echo       moechtest diese spaeter installieren = Die Partitionen dafuer
echo       nicht vergessen (Partiton nachtraeglich geht nicht)!
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
if /i '%eingabe%'=='0' goto behalten
if /i '%eingabe%'=='1' goto basis
if /i '%eingabe%'=='2' goto android
if /i '%eingabe%'=='3' goto linux
if /i '%eingabe%'=='4' goto lakka
if /i '%eingabe%'=='5' goto androidlinux
if /i '%eingabe%'=='6' goto androidlakka
if /i '%eingabe%'=='7' goto androidlinuxlakka
if /i '%eingabe%'=='8' goto linuxlakka

:behalten
if exist "%wd%:\hekate_ipl.ini" (copy /Y "%wd%:\hekate_ipl.ini" "%sd%:\bootloader\hekate_ipl.ini")
if exist "%wd%:\config.ini" (copy /Y "%wd%:\config.ini" "%sd%:\config\fastCFWSwitch\config.ini")
goto weiter

:basis
xcopy "%sd%:\switchbros\system\b\*" "%sd%:\" /H /Y /C /R /S /E /I
goto weiter

:android
xcopy "%sd%:\switchbros\system\ba\*" "%sd%:\" /H /Y /C /R /S /E /I
goto weiter

:linux
echo ------------------------------------------------------------------------
echo.
echo Welche der vier Linux Distributionen wirst du später nutzen?
echo.
echo A = Arch Linux
echo B = Ubuntu Bionic (empfohlen, wenn unsicher (modchip wird unterstuetzt))
echo C = Fedora Linux
echo D = Ubuntu
echo.
echo ------------------------------------------------------------------------
echo.
set "Linux="
set /p Linux=Waehle deine Linux Distribution: 
if /i '%Linux%'=='A' xcopy "%sd%:\switchbros\system\bu\arch\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i '%Linux%'=='B' xcopy "%sd%:\switchbros\system\bu\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i '%Linux%'=='C' xcopy "%sd%:\switchbros\system\bu\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i '%Linux%'=='D' xcopy "%sd%:\switchbros\system\bu\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I
goto weiter

:lakka
xcopy "%sd%:\switchbros\system\bl\*" "%sd%:\" /H /Y /C /R /S /E /I
goto weiter

:androidlinux
echo ------------------------------------------------------------------------
echo.
echo Welche der vier Linux Distributionen wirst du später nutzen?
echo.
echo A = Arch Linux
echo B = Ubuntu Bionic (empfohlen, wenn unsicher (modchip wird unterstuetzt))
echo C = Fedora Linux
echo D = Ubuntu
echo.
echo ------------------------------------------------------------------------
echo.
set "Linux="
set /p Linux=Waehle deine Linux Distribution: 
if /i '%Linux%'=='A' xcopy "%sd%:\switchbros\system\bau\arch\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i '%Linux%'=='B' xcopy "%sd%:\switchbros\system\bau\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i '%Linux%'=='C' xcopy "%sd%:\switchbros\system\bau\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i '%Linux%'=='D' xcopy "%sd%:\switchbros\system\bau\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I
goto weiter

:androidlakka
xcopy "%sd%:\switchbros\system\bal\*" "%sd%:\" /H /Y /C /R /S /E /I
goto weiter

:androidlinuxlakka
echo ------------------------------------------------------------------------
echo.
echo Welche der vier Linux Distributionen wirst du später nutzen?
echo.
echo A = Arch Linux
echo B = Ubuntu Bionic (empfohlen, wenn unsicher (modchip wird unterstuetzt))
echo C = Fedora Linux
echo D = Ubuntu
echo.
echo ------------------------------------------------------------------------
echo.
set "Linux="
set /p Linux=Waehle deine Linux Distribution: 
if /i '%Linux%'=='A' xcopy "%sd%:\switchbros\system\balu\arch\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i '%Linux%'=='B' xcopy "%sd%:\switchbros\system\balu\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i '%Linux%'=='C' xcopy "%sd%:\switchbros\system\balu\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i '%Linux%'=='D' xcopy "%sd%:\switchbros\system\balu\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I
goto weiter

:linuxlakka
echo ------------------------------------------------------------------------
echo.
echo Welche der vier Linux Distributionen wirst du später nutzen?
echo.
echo A = Arch Linux
echo B = Ubuntu Bionic (empfohlen, wenn unsicher (modchip wird unterstuetzt))
echo C = Fedora Linux
echo D = Ubuntu
echo.
echo ------------------------------------------------------------------------
echo.
set "Linux="
set /p Linux=Waehle deine Linux Distribution: 
if /i '%Linux%'=='A' xcopy "%sd%:\switchbros\system\blu\arch\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i '%Linux%'=='B' xcopy "%sd%:\switchbros\system\blu\bionic\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i '%Linux%'=='C' xcopy "%sd%:\switchbros\system\blu\fedora\*" "%sd%:\" /H /Y /C /R /S /E /I
if /i '%Linux%'=='D' xcopy "%sd%:\switchbros\system\blu\ubuntu\*" "%sd%:\" /H /Y /C /R /S /E /I
goto weiter

:weiter
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
if exist "%sd%:\emummc.txt" (attrib -A -R %sd%:\emummc.txt)

rem USB3 high speed in die Registry eintragen (hekate - USB3 Verbindung)
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\usbstor\11ECA7E0 /v MaximumTransferLength /t REG_DWORD /d 00100000 /f>nul 2>&1

rem Nach uns die Sintflut! Nein! Hinter uns wird natuerlich aufgeraemt :)
if exist "%sd%:\switchbros" (RD /s /q "%sd%:\switchbros")
if exist "%sd%:\switch\switchbros-updater\startup.te" (del "%sd%:\switch\switchbros-updater\startup.te")
if exist "%sd%:\switch\switchbros-updater\update.te" (del "%sd%:\switch\switchbros-updater\update.te")
if exist "%sd%:\temp" (RD /s /q "%sd%:\temp")
if exist "%sd%:\startup.te" (del "%sd%:\startup.te")
if exist "%sd%:\bootloader\hekate_ipl_.bak" (del "%sd%:\bootloader\hekate_ipl_.bak")
if exist "%sd%:\bootloader\setup" (RD /s /q "%sd%:bootloader\setup")
if exist "%sd%:\System Volume Information" (RD /s /q "%sd%:\System Volume Information")
if exist "%sd%:\bootloader\nyx.ini_" (del "%sd%:\bootloader\nyx.ini_")
if exist "%sd%:\*.bat" (del "%sd%:\*.bat")
if exist "%sd%:\*.te" (del "%sd%:\*.te")
if exist "%sd%:\*.exe" (del "%sd%:\*.exe")
if exist "%sd%:\*.bak" (del "%sd%:\*.bak")
if exist "%sd%:\SwitchBros_BasisPaket.zip" (del "%sd%SwitchBros_BasisPaket.zip")
if exist "%sd%:\switch\switchbrosupdater" (RD /s /q "%sd%:\switch\switchbrosupdater")
if exist "%sd%:\SwitchBros_BasisPaket" (RD /s /q "%sd%:\SwitchBros_BasisPaket")

if %syscon%==0 (
	RD /s /q "%sd%:\atmosphere\contents\690000000000000D"
	)

if %missioncontrol%==0 (
	RD /s /q "%sd%:\atmosphere\contents\010000000000bd00"
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
if exist "%sd%:\bootloader\ini" (RD /s /q "%sd%:\bootloader\ini")
if exist "%sd%:\switch\.overlays\*fastCFWswitch*.ovl" (del "%sd%:\switch\.overlays\*fastCFWswitch*.ovl")
if exist "%sd%:\bootloader\payloads\CommonProblemResolver.bin" (del "%sd%:\bootloader\payloads\CommonProblemResolver.bin")
)

cd %sd%:\

rem Entfernen typischer MacOS Dateien (die sind ueberall die Bruedaz)
if exist .DS_STORE del /s /q /f /a .DS_STORE
if exist ._.* del /s /q /f /a ._.*

goto ENDE

:FALSCHESD
cls
color C
echo ------------------------------------------------------------------------
echo                 Gewaehlter Laufwerksbuchstabe: %sd%:/
echo                    Keine SD-Karte in Laufwerk: %sd%:/
echo.
echo.
echo     1.  Laufwerksbuchstabe ist korrekt
echo     2.  Anderen Laufwerksbuchstaben waehlen
echo.
echo ------------------------------------------------------------------------
echo                                                             Q.  Beenden
echo.

set st=
set /p st=:

for %%A in ("Y" "y" "1" "?" "?") do if "%st%"==%%A (GOTO MAIN)
for %%A in ("N" "n" "2" "?" "?") do if "%st%"==%%A (GOTO NEUEKARTE)
for %%A in ("Q" "q" "?" "?") do if "%st%"==%%A (GOTO ENDE)

:rembkp

echo ------------------------------------------------------------------------
echo.
echo                         Entferne Backup Ordner
echo                             Bitte warten!
echo.
echo ------------------------------------------------------------------------

if exist "%wd%" (RD /s /q "%wd%\*")
goto MAIN

:ENDE
echo. 
cls
COLOR A
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

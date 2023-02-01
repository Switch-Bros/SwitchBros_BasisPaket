@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
chcp 1252 >nul 2>&1
title SwitchBros. NOOB-O-MAT
REM Dieses Skript basiert auf der Batch-Datei von rashevskyv's Kefir Paket der ebenfalls Entwickler von DBI ist!
REM RIESEN DANK!!! an diesen tollen Entwickler!
REM Dieses Skript wurde um einiges erweitert, erg�nzt und verbessert!

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
COLOR 0D
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
set /P sd="     Laufwerksbuchstabe der SD-Karte: "

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
echo      1 = Ja, ich habe einen Modchip verbaut (v2, lite, OLED)
echo      2 = Ja, ich habe einen trinketm0 in meiner v1
echo      3 = Nein, ich habe keinen Modchip verbaut
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

set /p modchip="     Ist ein Modchip verbaut: "
if "%modchip%"=="1" SET bootdat=1
if "%modchip%"=="3" SET bootdat=2
if "%modchip%"=="2" SET bootdat=3

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

if exist "%sd%:\bootloader\hekate_ipl.ini" (xcopy /y "%sd%:\bootloader\hekate_ipl.ini" "%sd%:\switchbros\backup\*") >nul 2>nul
if exist "%sd%:\bootloader\nyx.ini" (xcopy /y "%sd%:\bootloader\nyx.ini" "%sd%:\switchbros\backup\*") >nul 2>nul
if exist "%sd%:\config\fastCFWSwitch\config.ini" (xcopy /y "%sd%:\config\fastCFWSwitch\config.ini" "%sd%:\switchbros\backup\fastCFWSwitch\*") >nul 2>nul
if exist "%sd%:\config\Fizeau\config.ini" (xcopy /y "%sd%:\config\Fizeau\config.ini" "%sd%:\switchbros\backup\Fizeau\*") >nul 2>nul
if exist "%sd%:\config\IconGrabber\config.json" (xcopy /y "%sd%:\config\IconGrabber\config.json" "%sd%:\switchbros\backup\IconGrabber\*") >nul 2>nul
if exist "%sd%:\config\ftpd\ftpd.cfg" (xcopy /y "%sd%:\config\ftpd\ftpd.cfg" "%sd%:\switchbros\backup\ftpd\*") >nul 2>nul
if exist "%sd%:\switch\tinfoil\locations.conf" (xcopy /y "%sd%:\switch\tinfoil\locations.conf" "%sd%:\switchbros\backup\tinfoil\*") >nul 2>nul

REM ============================================================
:hauptmenue
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      1 = SD-Karte bereinigen/einrichten und zum SwitchBros. Paket wechseln^^!
echo.
echo.
echo      F = Unsicher, altes Paket behalten                             B = Dieses Skript Beenden
echo.     
echo -----------------------------------------------------------------------------------------------------
echo.

set /p neuistgut="     Bitte gib deine Auswahl ein: "
if "%neuistgut%"=="1" GOTO sbgibgas
if /i "%neuistgut%"=="F" GOTO endefeige
if /i "%neuistgut%"=="B" GOTO endemutig

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
powershell -Command "Start-Sleep -Seconds 10"
exit

REM ======= ATMOSPHERE ORDNER ==================================
:sbgibgas
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Deine SD-Karte wird jetzt vorbereitet und alle dafuer Notwendigen Daten geloescht^^!
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
echo      Gleich geht es weiter^^!
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------

xcopy "%~dp0*" "%sd%:\" /H /Y /C /R /S /E >nul 2>nul
powershell -Command "Start-Sleep -Seconds 2"
if exist "%sd%:\switchbros\backup\Fizeau\config.ini" (xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\ftpd\ftpd.cfg" (xcopy "%sd%:\switchbros\backup\ftpd\ftpd.cfg" "%sd%:\config\ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\icongrabber\config.json" (xcopy "%sd%:\switchbros\backup\icongrabber\config.json" "%sd%:\config\icongrabber\config.json\*" /H /Y /C /R /S /E /I) >nul 2>nul
powershell -Command "Start-Sleep -Seconds 5"

REM ============================================================
:nurbasissystem
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Die Basisvariante der hekate_ipl.ini wird erstellt^^!
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\system\b\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
if exist "%sd%:\switchbros\backup\Fizeau\config.ini" (xcopy "%sd%:\switchbros\backup\Fizeau\config.ini" "%sd%:\config\Fizeau\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\ftpd\ftpd.cfg" (xcopy "%sd%:\switchbros\backup\ftpd\ftpd.cfg" "%sd%:\config\ftpd\*" /H /Y /C /R /S /E /I) >nul 2>nul
if exist "%sd%:\switchbros\backup\icongrabber\config.json" (xcopy "%sd%:\switchbros\backup\icongrabber\config.json" "%sd%:\config\icongrabber\*" /H /Y /C /R /S /E /I) >nul 2>nul

REM ============================================================
:tinfoila
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Tinfoil wird im hbmenu installiert^^!
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\kids\switch\*" "%sd%:\switch\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\kids\tinfoilhbmenu\*" "%sd%:\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\kids\NSPs\*" "%sd%:\NSPs\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\backup\Tinfoil\locations.conf" "%sd%:\switch\tinfoil\*" /H /Y /C /R /S /E /I >nul 2>nul

REM ============================================================
:themepaketinst
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      ThemeApps werden installiert (NXThemeInstaller, ThmezerNX, Icongrabber)^^!
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\theme\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
if exist "%sd%:\backup\IconGrabber\config.json" (xcopy "%sd%:\backup\IconGrabber\config.json" "%sd%:\config\IconGrabber\*" /H /Y /C /R /S /E /I) >nul 2>nul

REM ============================================================
:teslaminimal
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Das Tesla-Overlay Menue, mit einigen Standard Modulen, wird installiert^^!
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

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
del "%sd%:\switch\.overlays\4_Breeze-Overlay.ovl"
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

REM ============================================================
:zusatzapps
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Zusaetzliche Apps werden im hbmenu installiert^^! 
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

xcopy "%sd%:\switchbros\zusatzapps\AmiiboGenerator\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\Amiigo\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\Goldleaf\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\Homebrew-Details\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\melonDS\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\MiiPort\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\Moonlight\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\Neumann\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\NX-Activity-Log\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\nx-locale-switcher\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\NX-Shell\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\NXGallery\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\nxmp\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\switch-remote-play\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\TencentSwitcherGui\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\zusatzapps\vgedit\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul

REM ============================================================
:fixattrib
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
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Volle USB3 Geschwindigkeit mit hekate USM Modus^^!
echo.
echo      Die Werte werden in deiner Windows registry eingetragen^^!
echo.
echo      BITTE WARTEN...
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\usbstor\11ECA7E0 /v MaximumTransferLength /t REG_DWORD /d 00100000 /f>nul 2>&1

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

if %bootdat%==1 (
	if exist "%sd%:\config\fastCFWSwitch" (RD /s /q "%sd%:\config\fastCFWSwitch")
	if exist "%sd%:\config\Fizeau" (RD /s /q "%sd%:\config\Fizeau")
	if exist "%sd%:\switch\Fizeau" (RD /s /q "%sd%:\switch\Fizeau")
	if exist "%sd%:\switch\.overlays\5_Fizeau.ovl" (del "%sd%:\switch\.overlays\*fizeau*.ovl")
	if exist "%sd%:\atmosphere\contents\0100000000000F12" (RD /s /q "%sd%:\atmosphere\contents\0100000000000F12")
	if exist "%sd%:\switch\.overlays\0_fastCFWswitch.ovl" (del "%sd%:\switch\.overlays\0_fastCFWswitch.ovl")
	if exist "%sd%:\bootloader\payloads\CommonProblemResolver.bin" (del "%sd%:\bootloader\payloads\CommonProblemResolver.bin")
)
if %bootdat%==2 (
	if exist "%sd%:\bootloader\payloads\hwfly_toolbox.bin" (del "%sd%:\bootloader\payloads\hwfly_toolbox.bin")
	if exist "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp" (del "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp")
	if exist "%sd%:\bootloader\ini\hwfly_toolbox.ini" (del "%sd%:\bootloader\ini\hwfly_toolbox.ini")
	)
if %bootdat%==3 (
	if exist "%sd%:\bootloader\payloads\hwfly_toolbox.bin" (del "%sd%:\bootloader\payloads\hwfly_toolbox.bin")
	if exist "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp" (del "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp")
	if exist "%sd%:\bootloader\ini\hwfly_toolbox.ini" (del "%sd%:\bootloader\ini\hwfly_toolbox.ini")
	if exist "%sd%:\boot.dat" (del "%sd%:\boot.dat")
	if exist "%sd%:\boot.ini" (del "%sd%:\boot.ini") 
	if exist "%sd%:\payload.bin" (del "%sd%:\payload.bin")
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

set st=
set /p st=:

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
echo      Alles abgeschlossen^^!^^!^^!
echo.
echo      Viel Spass mit unserem Paket und Willkommen in der Switch Bros. Community
echo.
echo.
echo      Das Programm wird automatisch beendet und geschlossen^^! 
echo.
echo      BITTE WARTEN...
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

powershell -Command "Start-Sleep -Seconds 7"
exit

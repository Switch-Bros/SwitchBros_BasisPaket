@ECHO OFF
mode con: cols=106 lines=32
SETLOCAL ENABLEDELAYEDEXPANSION
chcp 1252 >nul 2>&1
title SwitchBros. NOOB-O-MAT v120
REM Dieses Skript basiert auf der Batch-Datei von rashevskyv's Kefir Paket!
REM RIESEN DANK!!! an diesen tollen Entwickler!
REM Dieses Skript wurde um einiges erweitert, ergänzt und verbessert!

COLOR 0E
set wd=%temp%\sdfiles
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
echo                       _-== WARNUNG - WARNUNG - WARNUNG - WARNUNG - WARNUNG ==-_
echo.
echo      Wenn du dieses Skript (NOOB-O-MAT.bat) von deiner SD-Karte aus gestartet hast, dann
echo          SCHLIESSE es bitte SOFORT^^! NICHT von SD-Karte aus starten^^!
echo.
echo      Bitte starte die NOOB-O-MAT.bat ^>NUR^< aus dem "BasisPaket" Ordner von deinem PC^^!
echo.
echo =====================================================================================================
echo.
echo      Hast du dieses Skript aus dem "SwitchBros_BasisPaket" heraus gestartet, dann gib jetzt
echo      bitte ^>NUR^< den Laufwerksbuchstaben deiner SD-Karte ein^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

for /f "usebackq delims=" %%a in (`powershell -command "$ErrorActionPreference='Stop'; $sd = Get-WmiObject -Class Win32_Volume | Where-Object {$_.DriveType -eq 2}; foreach ($s in $sd) { 'Laufwerksbuchstabe: {0}' -f $s.DriveLetter; if ($s.Label) { 'Laufwerk: {0}' -f $s.Label }; 'Dateisystem: {0}' -f $s.FileSystem; $size = [math]::Round($s.Capacity / 1GB, 2); if ($size -ge 1) { 'Groesse: {0} GB' -f $size } else { 'Groesse: {0} MB' -f ($s.Capacity / 1MB) }; 'Belegt: {0} GB' -f ([math]::Round(($s.Capacity - $s.FreeSpace) / 1GB, 2)); 'Frei: {0} GB' -f ([math]::Round($s.FreeSpace / 1GB, 2)) }"`) do (
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

set "folders=bootloader Fizeau IconGrabber tinfoil bootlogo DBI"

for %%i in (%folders%) do (
    if not exist "%SBBAK%\%%i" (
        mkdir "%SBBAK%\%%i" >nul 2>&1
    )
)

if exist "%sd%:\bootloader\hekate_ipl.ini" (
xcopy /I /Y "%sd%:\bootloader\hekate_ipl.ini" "%SBBAK%\bootloader\" >nul 2>&1
)
if exist "%sd%:\bootloader\nyx.ini" (
xcopy /I /Y "%sd%:\bootloader\nyx.ini" "%SBBAK%\bootloader\" >nul 2>&1
)
if exist "%sd%:\config\Fizeau\config.ini" (
xcopy /I /Y "%sd%:\config\Fizeau\config.ini" "%SBBAK%\Fizeau\" >nul 2>&1
)
if exist "%sd%:\config\IconGrabber\config.json" (
xcopy /I /Y "%sd%:\config\IconGrabber\config.json" "%SBBAK%\IconGrabber\" >nul 2>&1
)
if exist "%sd%:\switch\tinfoil\locations.conf" (
xcopy /I /Y "%sd%:\switch\tinfoil\locations.conf" "%SBBAK%\tinfoil\" >nul 2>&1
)
if exist "%sd%:\switch\tinfoil\options.json" (
xcopy /I /Y "%sd%:\switch\tinfoil\options.json" "%SBBAK%\tinfoil\" >nul 2>&1
)
if exist "%sd%:\atmosphere\exefs_patches\bootlogo\*" (
xcopy /I /Y "%sd%:\atmosphere\exefs_patches\bootlogo\*" "%SBBAK%\bootlogo\" >nul 2>&1
)
if exist "%sd%:\switch\DBI\dbi.config" (
xcopy /I /Y "%sd%:\switch\DBI\dbi.config" "%SBBAK%\DBI\" >nul 2>&1
)

REM ============================================================
:hauptmenue
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      1 = SD-Karte einrichten, und SwitchBros. Paket installieren^^!
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
echo.
echo      BITTE WARTEN...
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

if exist "%sd%:\atmosphere\titles" (rename %sd%:\atmosphere\titles contents)
if exist "%sd%:\atmosphere\title" (rename %sd%:\atmosphere\title contents)
if exist "%sd%:\atmosphere\content" (rename %sd%:\atmosphere\content contents)

if exist "%sd%:/SB.ico" (
	if exist "%sd%:\atmosphere\config" (RD /S /Q "%sd%:\atmosphere\config")
	if exist "%sd%:\atmosphere\config_templates" (RD /S /Q "%sd%:\atmosphere\config_templates")
	if exist "%sd%:\atmosphere\erpt_reports" (RD /S /Q "%sd%:\atmosphere\erpt_reports")
	if exist "%sd%:\atmosphere\crash_reports" (RD /S /Q "%sd%:\atmosphere\crash_reports")
	if exist "%sd%:\atmosphere\exefs_patches" (RD /S /Q "%sd%:\atmosphere\exefs_patches")
	if exist "%sd%:\atmosphere\extras" (RD /S /Q "%sd%:\atmosphere\extras")
	if exist "%sd%:\atmosphere\fatal_errors" (RD /S /Q "%sd%:\atmosphere\fatal_errors")
	if exist "%sd%:\atmosphere\fatal_reports" (RD /S /Q "%sd%:\atmosphere\fatal_reports")
	if exist "%sd%:\atmosphere\flags" (RD /S /Q "%sd%:\atmosphere\flags")
	if exist "%sd%:\atmosphere\hosts" (RD /S /Q  "%sd%:\atmosphere\hosts")
	if exist "%sd%:\atmosphere\kips" (RD /S /Q  "%sd%:\atmosphere\kips")
	if exist "%sd%:\atmosphere\kip_patches" (RD /S /Q "%sd%:\atmosphere\kip_patches")
	if exist "%sd%:\atmosphere\hekate_kips" (RD /S /Q "%sd%:\atmosphere\hekate_kips")
	if exist "%sd%:\atmosphere\logs" (RD /S /Q  "%sd%:\atmosphere\logs")
	if exist "%sd%:\atmosphere\update" (RD /S /Q  "%sd%:\atmosphere\update")

	if exist "%sd%:\atmosphere\package3" (DEL /F "%sd%:\atmosphere\package3")
	if exist "%sd%:\atmosphere\*.bin" (DEL /F "%sd%:\atmosphere\*.bin")
	if exist "%sd%:\atmosphere\*.nsp" (DEL /F "%sd%:\atmosphere\*.nsp")
	if exist "%sd%:\atmosphere\*.romfs" (DEL /F "%sd%:\atmosphere\*.romfs")
	if exist "%sd%:\atmosphere\*.sig" (DEL /F "%sd%:\atmosphere\*.sig")
	if exist "%sd%:\atmosphere\*.json" (DEL /F "%sd%:\atmosphere\*.json")
	if exist "%sd%:\atmosphere\*.ini" (DEL /F "%sd%:\atmosphere\*.ini")
	
	if exist "%sd%:\atmosphere\contents\0100000000001000" (RD /S /Q "%sd%:\atmosphere\contents\0100000000001000")
	if exist "%sd%:\atmosphere\contents\0100000000001007" (RD /S /Q "%sd%:\atmosphere\contents\0100000000001007")
	if exist "%sd%:\atmosphere\contents\0100000000001013" (RD /S /Q "%sd%:\atmosphere\contents\0100000000001013")
	if exist "%sd%:\atmosphere\contents\010000000000000D" (RD /S /Q "%sd%:\atmosphere\contents\010000000000000D")
	if exist "%sd%:\atmosphere\contents\0100000000000352" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000352")
	if exist "%sd%:\atmosphere\contents\0000000000534C56" (RD /S /Q "%sd%:\atmosphere\contents\0000000000534C56")
	if exist "%sd%:\atmosphere\contents\00FF0000000002AA" (RD /S /Q "%sd%:\atmosphere\contents\00FF0000000002AA")
	if exist "%sd%:\atmosphere\contents\00FF0000A53BB665" (RD /S /Q "%sd%:\atmosphere\contents\00FF0000A53BB665")
	if exist "%sd%:\atmosphere\contents\00FF0000636C6BFF" (RD /S /Q "%sd%:\atmosphere\contents\00FF0000636C6BFF")
	if exist "%sd%:\atmosphere\contents\00FF747765616BFF" (RD /S /Q "%sd%:\atmosphere\contents\00FF747765616BFF")
	if exist "%sd%:\atmosphere\contents\0100000000000F12" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000F12")
	if exist "%sd%:\atmosphere\contents\010000000000bd00" (RD /S /Q "%sd%:\atmosphere\contents\010000000000bd00")
	if exist "%sd%:\atmosphere\contents\054e4f4558454000" (RD /S /Q "%sd%:\atmosphere\contents\054e4f4558454000")
	if exist "%sd%:\atmosphere\contents\010000000007E51A" (RD /S /Q "%sd%:\atmosphere\contents\010000000007E51A")
	if exist "%sd%:\atmosphere\contents\420000000007E51A" (RD /S /Q "%sd%:\atmosphere\contents\420000000007E51A")
	if exist "%sd%:\atmosphere\contents\4200000000000000" (RD /S /Q "%sd%:\atmosphere\contents\4200000000000000")
	if exist "%sd%:\atmosphere\contents\4200000000000010" (RD /S /Q "%sd%:\atmosphere\contents\4200000000000010")
	if exist "%sd%:\atmosphere\contents\420000000000000E" (RD /S /Q "%sd%:\atmosphere\contents\420000000000000E")
	if exist "%sd%:\atmosphere\contents\690000000000000D" (RD /S /Q "%sd%:\atmosphere\contents\690000000000000D")

	if exist "%sd%:\bootloader\sys" (RD /S /Q "%sd%:\bootloader\sys")
	if exist "%sd%:\bootloader\payloads" (RD /S /Q "%sd%:\bootloader\payloads")
	if exist "%sd%:\bootloader\*.ini" (DEL /F "%sd%:\bootloader\*.ini")
	if exist "%sd%:\bootloader\*.bin" (DEL /F "%sd%:\bootloader\*.bin")
	if exist "%sd%:\bootloader\*.bmp" (DEL /F "%sd%:\bootloader\*.bmp")

	if exist "%sd%:\config" (RD /S /Q "%sd%:\config")

	if exist "%sd%:\switchbros" (RD /S /Q "%sd%:\switchbros")
	if exist "%sd%:\tegraexplorer" (RD /S /Q "%sd%:\tegraexplorer")
	if exist "%sd%:\firmware" (RD /S /Q "%sd%:\firmware")

	if exist "%sd%:\switch\.overlays" (RD /S /Q "%sd%:\switch\.overlays")

	if exist "%sd%:\*.nro" (DEL /F "%sd%:\*.nro")
	if exist "%sd%:\*.ini" (DEL /F "%sd%:\*.ini")
	if exist "%sd%:\*.txt" (DEL /F "%sd%:\*.txt")
	if exist "%sd%:\*.bat" (DEL /F "%sd%:\*.bat")
	if exist "%sd%:\*.bin" (DEL /F "%sd%:\*.bin")

) else (
	
if exist "%sd%:\backup\SB" (RD /S /Q "%sd%:\backup\SB")
if exist "%sd%:\atmosphere\config" (RD /S /Q "%sd%:\atmosphere\config")
if exist "%sd%:\atmosphere\config_templates" (RD /S /Q "%sd%:\atmosphere\config_templates")
if exist "%sd%:\atmosphere\erpt_reports" (RD /S /Q "%sd%:\atmosphere\erpt_reports")
if exist "%sd%:\atmosphere\crash_reports" (RD /S /Q "%sd%:\atmosphere\crash_reports")
if exist "%sd%:\atmosphere\exefs_patches" (RD /S /Q "%sd%:\atmosphere\exefs_patches")
if exist "%sd%:\atmosphere\extras" (RD /S /Q "%sd%:\atmosphere\extras")
if exist "%sd%:\atmosphere\fatal_errors" (RD /S /Q "%sd%:\atmosphere\fatal_errors")
if exist "%sd%:\atmosphere\fatal_reports" (RD /S /Q "%sd%:\atmosphere\fatal_reports")
if exist "%sd%:\atmosphere\flags" (RD /S /Q "%sd%:\atmosphere\flags")
if exist "%sd%:\atmosphere\hosts" (RD /S /Q  "%sd%:\atmosphere\hosts")
if exist "%sd%:\atmosphere\kips" (RD /S /Q  "%sd%:\atmosphere\kips")
if exist "%sd%:\atmosphere\kip_patches" (RD /S /Q "%sd%:\atmosphere\kip_patches")
if exist "%sd%:\atmosphere\hekate_kips" (RD /S /Q "%sd%:\atmosphere\hekate_kips")
if exist "%sd%:\atmosphere\logs" (RD /S /Q  "%sd%:\atmosphere\logs")
if exist "%sd%:\atmosphere\update" (RD /S /Q  "%sd%:\atmosphere\update")

if exist "%sd%:\atmosphere\package3" (DEL /F "%sd%:\atmosphere\package3")
if exist "%sd%:\atmosphere\*.bin" (DEL /F "%sd%:\atmosphere\*.bin")
if exist "%sd%:\atmosphere\*.nsp" (DEL /F "%sd%:\atmosphere\*.nsp")
if exist "%sd%:\atmosphere\*.romfs" (DEL /F "%sd%:\atmosphere\*.romfs")
if exist "%sd%:\atmosphere\*.sig" (DEL /F "%sd%:\atmosphere\*.sig")
if exist "%sd%:\atmosphere\*.json" (DEL /F "%sd%:\atmosphere\*.json")
if exist "%sd%:\atmosphere\*.ini" (DEL /F "%sd%:\atmosphere\*.ini")

REM ======= ATMOSPHERE CONTENTS ORDNER =========================
if exist "%sd%:\atmosphere\contents\0100000000000008" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000008")
if exist "%sd%:\atmosphere\contents\010000000000100B" (RD /S /Q "%sd%:\atmosphere\contents\010000000000100B")
if exist "%sd%:\atmosphere\contents\010000000000000D" (RD /S /Q "%sd%:\atmosphere\contents\010000000000000D")
if exist "%sd%:\atmosphere\contents\010000000000002b" (RD /S /Q "%sd%:\atmosphere\contents\010000000000002b")
if exist "%sd%:\atmosphere\contents\0100000000000032" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000032")
if exist "%sd%:\atmosphere\contents\0100000000000034" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000034")
if exist "%sd%:\atmosphere\contents\0100000000000036" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000036")
if exist "%sd%:\atmosphere\contents\0100000000000037" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000037")
if exist "%sd%:\atmosphere\contents\010000000000003C" (RD /S /Q "%sd%:\atmosphere\contents\010000000000003C")
if exist "%sd%:\atmosphere\contents\0100000000000042" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000042")
if exist "%sd%:\atmosphere\contents\010000000000100C" (RD /S /Q "%sd%:\atmosphere\contents\010000000000100C")
if exist "%sd%:\atmosphere\contents\010000000000100D" (RD /S /Q "%sd%:\atmosphere\contents\010000000000100D")
if exist "%sd%:\atmosphere\contents\0100000000001000" (RD /S /Q "%sd%:\atmosphere\contents\0100000000001000")
if exist "%sd%:\atmosphere\contents\0100000000001013" (RD /S /Q "%sd%:\atmosphere\contents\0100000000001013")

if exist "%sd%:\atmosphere\contents\0000000000534C56" (RD /S /Q "%sd%:\atmosphere\contents\0000000000534C56")
if exist "%sd%:\atmosphere\contents\00FF0000000002AA" (RD /S /Q "%sd%:\atmosphere\contents\00FF0000000002AA")
if exist "%sd%:\atmosphere\contents\00FF0000636C6BF2" (RD /S /Q "%sd%:\atmosphere\contents\00FF0000636C6BF2")
if exist "%sd%:\atmosphere\contents\00FF0000636C6BFF" (RD /S /Q "%sd%:\atmosphere\contents\00FF0000636C6BFF")
if exist "%sd%:\atmosphere\contents\00FF00006D7470FF" (RD /S /Q "%sd%:\atmosphere\contents\00FF00006D7470FF")
if exist "%sd%:\atmosphere\contents\00FF0000A53BB665" (RD /S /Q "%sd%:\atmosphere\contents\00FF0000A53BB665")
if exist "%sd%:\atmosphere\contents\00FF0012656180FF" (RD /S /Q "%sd%:\atmosphere\contents\00FF0012656180FF")
if exist "%sd%:\atmosphere\contents\01FF415446660000" (RD /S /Q "%sd%:\atmosphere\contents\01FF415446660000")
if exist "%sd%:\atmosphere\contents\00FF747765616BFF" (RD /S /Q "%sd%:\atmosphere\contents\00FF747765616BFF")
if exist "%sd%:\atmosphere\contents\0100000000000052" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000052")
if exist "%sd%:\atmosphere\contents\0100000000000081" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000081")
if exist "%sd%:\atmosphere\contents\0100000000000352" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000352")
if exist "%sd%:\atmosphere\contents\0100000000000464" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000464")
if exist "%sd%:\atmosphere\contents\0100000000000523" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000523")
if exist "%sd%:\atmosphere\contents\0100000000000901" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000901")
if exist "%sd%:\atmosphere\contents\0100000000000BED" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000BED")
if exist "%sd%:\atmosphere\contents\0100000000000BEF" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000BEF")
if exist "%sd%:\atmosphere\contents\0100000000000DAD" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000DAD")
if exist "%sd%:\atmosphere\contents\0100000000000F12" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000F12")
if exist "%sd%:\atmosphere\contents\0100000000000FAF" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000FAF")
if exist "%sd%:\atmosphere\contents\0100000000006480" (RD /S /Q "%sd%:\atmosphere\contents\0100000000006480")
if exist "%sd%:\atmosphere\contents\0100000000007200" (RD /S /Q "%sd%:\atmosphere\contents\0100000000007200")
if exist "%sd%:\atmosphere\contents\010000000000bd00" (RD /S /Q "%sd%:\atmosphere\contents\010000000000bd00")
if exist "%sd%:\atmosphere\contents\010000000000C235" (RD /S /Q "%sd%:\atmosphere\contents\010000000000C235")
if exist "%sd%:\atmosphere\contents\010000000000f00f" (RD /S /Q "%sd%:\atmosphere\contents\010000000000f00f")
if exist "%sd%:\atmosphere\contents\010000000000FFAB" (RD /S /Q "%sd%:\atmosphere\contents\010000000000FFAB")
if exist "%sd%:\atmosphere\contents\01000000001ED1ED" (RD /S /Q "%sd%:\atmosphere\contents\01000000001ED1ED")
if exist "%sd%:\atmosphere\contents\0532232232232000" (RD /S /Q "%sd%:\atmosphere\contents\0532232232232000")
if exist "%sd%:\atmosphere\contents\054e4f4558454000" (RD /S /Q "%sd%:\atmosphere\contents\054e4f4558454000")
if exist "%sd%:\atmosphere\contents\2200000000000100" (RD /S /Q "%sd%:\atmosphere\contents\2200000000000100")
if exist "%sd%:\atmosphere\contents\4100000000000324" (RD /S /Q "%sd%:\atmosphere\contents\4100000000000324")
if exist "%sd%:\atmosphere\contents\4200000000000000" (RD /S /Q "%sd%:\atmosphere\contents\4200000000000000")
if exist "%sd%:\atmosphere\contents\420000000000000E" (RD /S /Q "%sd%:\atmosphere\contents\420000000000000E")
if exist "%sd%:\atmosphere\contents\420000000000000F" (RD /S /Q "%sd%:\atmosphere\contents\420000000000000F")
if exist "%sd%:\atmosphere\contents\4200000000000010" (RD /S /Q "%sd%:\atmosphere\contents\4200000000000010")
if exist "%sd%:\atmosphere\contents\4200000000000811" (RD /S /Q "%sd%:\atmosphere\contents\4200000000000811")
if exist "%sd%:\atmosphere\contents\4200000000000BA6" (RD /S /Q "%sd%:\atmosphere\contents\4200000000000BA6")
if exist "%sd%:\atmosphere\contents\4200000000000FFF" (RD /S /Q "%sd%:\atmosphere\contents\4200000000000FFF")
if exist "%sd%:\atmosphere\contents\010000000007E51A" (RD /S /Q "%sd%:\atmosphere\contents\010000000007E51A")
if exist "%sd%:\atmosphere\contents\420000000007E51A" (RD /S /Q "%sd%:\atmosphere\contents\420000000007E51A")
if exist "%sd%:\atmosphere\contents\4200000000474442" (RD /S /Q "%sd%:\atmosphere\contents\4200000000474442")
if exist "%sd%:\atmosphere\contents\4200000000696969" (RD /S /Q "%sd%:\atmosphere\contents\4200000000696969")
if exist "%sd%:\atmosphere\contents\4200000AF1E8DA89" (RD /S /Q "%sd%:\atmosphere\contents\4200000AF1E8DA89")
if exist "%sd%:\atmosphere\contents\42000062616B6101" (RD /S /Q "%sd%:\atmosphere\contents\42000062616B6101")
if exist "%sd%:\atmosphere\contents\4200736372697074" (RD /S /Q "%sd%:\atmosphere\contents\4200736372697074")
if exist "%sd%:\atmosphere\contents\4206900000000012" (RD /S /Q "%sd%:\atmosphere\contents\4206900000000012")
if exist "%sd%:\atmosphere\contents\430000000000000A" (RD /S /Q "%sd%:\atmosphere\contents\430000000000000A")
if exist "%sd%:\atmosphere\contents\430000000000000B" (RD /S /Q "%sd%:\atmosphere\contents\430000000000000B")
if exist "%sd%:\atmosphere\contents\430000000000000C" (RD /S /Q "%sd%:\atmosphere\contents\430000000000000C")
if exist "%sd%:\atmosphere\contents\43000000000000FF" (RD /S /Q "%sd%:\atmosphere\contents\43000000000000FF")
if exist "%sd%:\atmosphere\contents\4300000000000909" (RD /S /Q "%sd%:\atmosphere\contents\4300000000000909")
if exist "%sd%:\atmosphere\contents\5600000000000000" (RD /S /Q "%sd%:\atmosphere\contents\5600000000000000")
if exist "%sd%:\atmosphere\contents\690000000000000D" (RD /S /Q "%sd%:\atmosphere\contents\690000000000000D")

if exist "%sd%:\bootloader" (RD /S /Q "%sd%:\bootloader")
if exist "%sd%:\config" (RD /S /Q "%sd%:\config")
if exist "%sd%:\switch" (RD /S /Q "%sd%:\switch")
if exist "%sd%:\themes" (RD /S /Q "%sd%:\themes")

FOR /D /R "%sd%:\" %%X IN (amsPACK*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (kefir*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (ShallowSea*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (DeepSea*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (reinx*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (firmware*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (sxos*) DO RD /S /Q "%%X"
FOR /D /R "%sd%:\" %%X IN (custom*) DO RD /S /Q "%%X"

REM ======= SD-KARTEN ROOT =====================================
if exist "%sd%:\tegraexplorer" (RD /S /Q "%sd%:\tegraexplorer")
if exist "%sd%:\modules" (RD /S /Q "%sd%:\modules")
if exist "%sd%:\NSPs" (RD /S /Q "%sd%:\NSPs")
if exist "%sd%:\NSP" (RD /S /Q "%sd%:\NSP")
if exist "%sd%:\SaltySD" (RD /S /Q "%sd%:\SaltySD")
if exist "%sd%:\atmo" (RD /S /Q "%sd%:\atmo")
if exist "%sd%:\ams" (RD /S /Q "%sd%:\ams")
if exist "%sd%:\scripts" (RD /S /Q "%sd%:\scripts")
if exist "%sd%:\music" (RD /S /Q "%sd%:\music")
if exist "%sd%:\tools" (RD /S /Q "%sd%:\tools")
if exist "%sd%:\games" (RD /S /Q "%sd%:\games")
if exist "%sd%:\pegascape" (RD /S /Q "%sd%:\pegascape")
if exist "%sd%:\TinGen" (RD /S /Q "%sd%:\TinGen")
if exist "%sd%:\sept" (RD /S /Q  "%sd%:\sept")
if exist "%sd%:\.git" (RD /S /Q "%sd%:\.git")
if exist "%sd%:\*.nro" (DEL /F "%sd%:\hbmenu.nro")
if exist "%sd%:\*.te" (DEL /F "%sd%:\startup.te")
if exist "%sd%:\*.ini" (DEL /F "%sd%:\*.ini")
if exist "%sd%:\*.bin" (DEL /F "%sd%:\*.bin")
if exist "%sd%:\*.txt" (DEL /F "%sd%:\*.txt")
if exist "%sd%:\*.dat" (DEL /F "%sd%:\*.dat")
if exist "%sd%:\*.log" (DEL /F "%sd%:\*.log")

if exist "%sd%:\roms\*.txt" (DEL /F  "%sd%:\roms\*.txt")
)

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
if exist "%SBBAK%\Fizeau\config.ini" (xcopy "%SBBAK%\Fizeau\config.ini" "%sd%:\config\Fizeau\*" /H /Y /C /R /S /E /I) >nul 2>nul
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
xcopy "%SBBAK%\Tinfoil\locations.conf" "%sd%:\switch\tinfoil\*" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%SBBAK%\Tinfoil\options.json" "%sd%:\switch\tinfoil\*" /H /Y /C /R /S /E /I >nul 2>nul

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
if exist "%SBBAK%\bootlogo\bootlogo" (
RD /S /Q "%sd%:\atmosphere\exefs_patches\bootlogo" >nul 2>nul
xcopy /y "%SBBAK%\bootlogo\bootlogo" "%sd%:\atmosphere\exefs_patches\bootlogo") >nul 2>nul
if exist "%SBBAK%\IconGrabber\config.json" (xcopy "%SBBAK%\IconGrabber\config.json" "%sd%:\config\IconGrabber\*" /H /Y /C /R /S /E /I) >nul 2>nul

REM ============================================================
:teslaminimal
COLOR 0E
cls
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
echo      Das UltraHand-Overlay Menue (Tesla-Overlay), mit einigen Standard Modulen, wird installiert^^!
echo.
echo      Wir empfehlen dir unseren SwitchBros-Updater im hbmenu zu starten sobald die
echo      SD-Karte in deiner Switch ist, und du die CFW gestartet hast um das Paket deinen Wuenschen
echo      entsprechend anzupassen^^!
echo.
echo      BITTE WARTEN...^^!
echo.
echo -----------------------------------------------------------------------------------------------------
echo.
powershell -Command "Start-Sleep -Seconds 7"

xcopy "%sd%:\switchbros\sys-modul\UltraHand\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\sys-modul\pancake\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\sys-modul\ovlSysmodule\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul
xcopy "%sd%:\switchbros\sys-modul\QuickNTP\*" "%sd%:\" /H /Y /C /R /S /E /I >nul 2>nul

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
echo      Die Werte werden in deiner Windows registry eingetragen^^!
echo.
echo      BITTE WARTEN...
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\usbstor\11ECA7E0 /v MaximumTransferLength /t REG_DWORD /d 00100000 /f >nul 2>&1

REM ============================================================
:aufraeumen
if exist "%sd%:\SwitchBros_BasisPaket" (RD /S /Q "%sd%:\SwitchBros_BasisPaket")
if exist "%sd%:\switchbros" (RD /S /Q "%sd%:\switchbros")
if exist "%sd%:\updatebak" (RD /S /Q "%sd%:\updatebak")
if exist "%sd%:\switch\switchbros-updater\update.te" (DEL /F "%sd%:\switch\switchbros-updater\update.te")
if exist "%sd%:\System Volume Information" (RD /S /Q "%sd%:\System Volume Information")
if exist "%sd%:\*.bat" (DEL /F "%sd%:\*.bat")
if exist "%sd%:\*.te" (DEL /F "%sd%:\*.te")
if exist "%sd%:\*.exe" (DEL /F "%sd%:\*.exe")
if exist "%sd%:\*.bak" (DEL /F "%sd%:\*.bak")
if exist "%sd%:\licence" (DEL /F "%sd%:\licence")
if exist "%sd%:\*.md" (DEL /F "%sd%:\*.md")
if exist "%sd%:\SwitchBros_BasisPaket.zip" (DEL /F "%sd%:\SwitchBros_BasisPaket.zip")
if exist "%sd%:\SwitchBros.txt" (DEL /F "%sd%:\SwitchBros.txt")
if exist "%sd%:\bootloader\ini" (RD /S /Q "%sd%:\bootloader\ini")
if exist "%sd%:\switch\switchbrosupdater" (RD /S /Q "%sd%:\switch\switchbrosupdater")

if %bootdat%==0 (
	if exist "%sd%:\bootloader\memloader" (RD /S /Q "%sd%:\bootloader\memloader")
	if exist "%sd%:\bootloader\warmboot" (RD /S /Q "%sd%:\bootloader\warmboot")
	if exist "%sd%:\bootloader\payloads\hwfly_toolbox.bin" (DEL /F "%sd%:\bootloader\payloads\hwfly_toolbox.bin")
	if exist "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp" (DEL /F "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp")
	if exist "%sd%:\bootloader\ini\hwfly_toolbox.ini" (DEL /F "%sd%:\bootloader\ini\hwfly_toolbox.ini")
	if exist "%sd%:\bootloader\payloads\picofly_toolbox.bin" (DEL /F "%sd%:\bootloader\payloads\picofly_toolbox.bin")
	)
if %bootdat%==1 (
	if exist "%sd%:\bootloader\memloader" (RD /S /Q "%sd%:\bootloader\memloader")
	if exist "%sd%:\config\Fizeau" (RD /S /Q "%sd%:\config\Fizeau")
	if exist "%sd%:\switch\Fizeau" (RD /S /Q "%sd%:\switch\Fizeau")
	if exist "%sd%:\switch\.overlays\Fizeau.ovl" (DEL /F "%sd%:\switch\.overlays\*fizeau*.ovl")
	if exist "%sd%:\atmosphere\contents\0100000000000F12" (RD /S /Q "%sd%:\atmosphere\contents\0100000000000F12")
)
if %bootdat%==2 (
	if exist "%sd%:\bootloader\warmboot" (RD /S /Q "%sd%:\bootloader\warmboot")
	if exist "%sd%:\bootloader\payloads\hwfly_toolbox.bin" (DEL /F "%sd%:\bootloader\payloads\hwfly_toolbox.bin")
	if exist "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp" (DEL /F "%sd%:\bootloader\res\icon_hwfly_toolbox_nobox.bmp")
	if exist "%sd%:\bootloader\ini\hwfly_toolbox.ini" (DEL /F "%sd%:\bootloader\ini\hwfly_toolbox.ini")
	if exist "%sd%:\bootloader\payloads\picofly_toolbox.bin" (DEL /F "%sd%:\bootloader\payloads\picofly_toolbox.bin")
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
echo      Alles abgeschlossen^^!^^!^^!
echo.
echo      Viel Spass mit unserem Paket und Willkommen in der Switch Bros. Community
echo.
echo                     Besuche uns: https://discord.gg/switchbros
echo.
echo.
echo.
echo.
echo.
echo      Das Programm wird automatisch beendet und geschlossen^^! 
echo.
echo      BITTE WARTEN...
echo.
echo -----------------------------------------------------------------------------------------------------
echo.

if exist "%wd%" (RD /s /q "%wd%\*") >nul 2>nul
powershell -Command "Start-Sleep -Seconds 7"
exit

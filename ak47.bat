@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
chcp 1252 >nul 2>&1
set "eingabe=W"
set "kindgerecht=1"
set "themepaket=1"
set "steamapi="
set "sysmod=2"
set "zusatzapps=W"
set "fixattrib=1"
set "ende=J"

GOTO :sbgibgas

:sbgibgas
GOTO :sblegtlos

:sblegtlos
GOTO nurbasissystem

:nurbasissystem
GOTO systempartitionen

:systempartitionen
if /i "%eingabe"=="W" GOTO kindgerecht

:kindgerecht
if "%kindgerecht"=="1" GOTO tinfoila

:tinfoila
GOTO themepaket

:themepaket
if "%themepaket"=="1" GOTO themepaketinst

:themepaketinst
GOTO steamapiangeben

:steamapiangeben
if "%steamapi"=="" GOTO systemmodule

:systemmodule
if "%sysmod"=="2" GOTO teslaminimal

:teslaminimal
GOTO zusatzapps

:zusatzapps
if /i "%datenapps%"=="W" GOTO attributeundmac

:attributeundmac
if /i "%fixattrib%"=="1" GOTO fixattribweiter

:fixattribweiter
GOTO usb3weiter

:usb3weiter
GOTO aufraeumen

:aufraeumen
GOTO endemutig

:endemutig

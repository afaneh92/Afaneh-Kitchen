:: This script used in the compiled Afaneh-Kitchen.exe
@echo off
set root=%~dp0

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "%~s0", "%params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit
)   else ( 
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    cd /D %root%
)

call scripts\00_main.bat
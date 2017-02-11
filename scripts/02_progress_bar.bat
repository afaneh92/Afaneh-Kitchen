@echo off

color 0a
setlocal enabledelayedexpansion
set Counter=0
set Schalter=2
set Width=0

:1
set /a Counter=%Counter% + 1
set /a Display=%Counter% / 2
for /L %%A in (1,1,%Display%) do (
    set Display=!Display!²
)
cls
echo            %~1 %~2 ...                  %Counter%%%
echo     ²!Display:~2,47!
ping localhost -n 1 >nul
if "%Counter%" == "100" goto end
goto 1

:end
exit /b
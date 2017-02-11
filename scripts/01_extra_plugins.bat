@echo off
setlocal enabledelayedexpansion
set count=0

:
:: Read in files
for /d %%x in (plugins/*) do (
  set /a count=count+1
  set choice[!count!]=%%x
)
echo.
echo Select one:
echo.
:: Print list of files
for /l %%x in (1,1,!count!) do (
   echo %%x] !choice[%%x]!
)
echo.
:: Retrieve User input
set /p select=? 
echo.
:: Print out selected filename
echo You chose !choice[%select%]!
pause
if exist  "plugins\!choice[%select%]!\*.bat" call plugins\!choice[%select%]!\*.bat
else if exist  "plugins\!choice[%select%]!\*.exe" call plugins\!choice[%select%]!\*.exe
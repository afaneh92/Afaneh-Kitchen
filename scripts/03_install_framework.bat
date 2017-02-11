@echo off

:framework
color 0F
cls
set fra={0C}No{#}
set twf={0C}No{#}
set sui={0C}No{#}
set chr={0C}No{#}
set sgu={0C}No{#}
cd /D "%temp%"
if exist "../apktool/framework/1.apk" set fra=Yes
if exist "../apktool/framework/2.apk" set twf=Yes 
if exist "../apktool/framework/127.apk" set sui=Yes
cd /D %root%

"tools/cecho"  {0E}***{#}{0A}                  ,                                                {0E}***{#}{#}
echo.
"tools/cecho"  {0E}***{#}{0A}                /'/                                          /'    {0E}***{#}{#}
echo.
"tools/cecho"  {0E}***{#}{0A}              /' /      /')                                /'      {0E}***{#}{#}
echo.
"tools/cecho"  {0E}***{#}{0A}           ,/'  /     /' /' ____     ,____     ____      /'__      {0E}***{#}{#}
echo.
"tools/cecho"  {0E}***{#}{0A}          /`--,/   -/'--' /'    )   /'    )  /'    )   /'    )     {0E}***{#}{#}
echo.
"tools/cecho"  {0E}***{#}{0A}        /'    /   /'    /'    /'  /'    /' /(___,/'  /'    /'      {0E}***{#}{#}
echo.
"tools/cecho"  {0E}***{#}{0A}    (,/'     (_,/(_____(___,/(__/'    /(__(________/'    /(__      {0E}***{#}{#}
echo.
"tools/cecho"  {0E}***{#}{0A}               /'                                                  {0E}***{#}{#}
echo.
"tools/cecho"  {0E}***{#}{0A}             /' _                                                  {0E}***{#}{#}
echo.
"tools/cecho"  {0E}***{#}{0A}           /'  ' )   _/      /'          /'  {0E}%TIME:~0,2%:%TIME:~3,2% %Date:~-7,2%/%Date:~-10,2%/%Date:~-4,4%{#}      {0E}***{#}{#}
echo.
"tools/cecho"  {0E}***{#}{0A}               /' _/~    --/'--        /'                          {0E}***{#}{#}
echo.
"tools/cecho"  {0E}***{#}{0A}             /'_/~    O  /' ____     /'__     ____     ,____       {0E}***{#}{#}
echo.
"tools/cecho"  {0E}***{#}{0A}           /\/~     /' /' /'    )--/'    )  /'    )   /'    )      {0E}***{#}{#}
echo.
"tools/cecho"  {0E}***{#}{0A}         /'  \    /' /' /'       /'    /' /(___,/'  /'    /'       {0E}***{#}{#}
echo.
"tools/cecho"  {0E}***{#}{0A}     (,/'     \_,(__(__(___,/  /'    /(__(________/'    /(__       {0E}***{#}{#}
echo.
echo  -------------------------------------------------------------------------
"tools/cecho"   {0E}Framework Installation{#}                            {0E}Installation Status{#}
echo.
echo  -------------------------------------------       -----------------------
if not exist "add_framework_here/framework-res.apk" ( "tools/cecho"    {0C}framework-res.apk        Not detected {#}              {0E}Installed:{#} {0A}%fra%{#} )
if exist "add_framework_here/framework-res.apk" ( "tools/cecho"    {0A}Framework-res.apk        detected {#}                  {0E}Installed:{#} {0A}%fra%{#} )
echo.
if not exist "add_framework_here/twframework-res.apk" ( "tools/cecho"    {0C}twframework-res.apk      Not detected {#}              {0E}Installed:{#} {0A}%twf%{#} )
if exist "add_framework_here/twframework-res.apk" ( "tools/cecho"    {0A}twframework-res.apk      detected {#}                  {0E}Installed:{#} {0A}%twf%{#} )
echo.
if not exist "add_framework_here/SystemUI.apk" ( "tools/cecho"    {0C}SystemUI.apk             Not detected {#}              {0E}Installed:{#} {0A}%sui%{#} )
if exist "add_framework_here/SystemUI.apk" ( "tools/cecho"    {0A}SystemUI.apk             detected {#}                  {0E}Installed:{#} {0A}%sui%{#} )
echo.
if not exist "add_framework_here/com.htc.resources.apk" ( "tools/cecho"    {0C}com.htc.resources.apk    Not detected {#}              {0E}Installed:{#} {0A}%chr%{#} )
if exist "add_framework_here/com.htc.resources.apk" ( "tools/cecho"    {0A}com.htc.resources.apk    detected {#}                  {0E}Installed:{#} {0A}%chr%{#} )
echo.
if not exist "add_framework_here/SemcGenericUxpRes.apk" ( "tools/cecho"    {0C}SemcGenericUxpRes.apk    Not detected {#}              {0E}Installed:{#} {0A}%sgu%{#} )
if exist "add_framework_here/SemcGenericUxpRes.apk" ( "tools/cecho"    {0A}SemcGenericUxpRes.apk    detected {#}                  {0E}Installed:{#} {0A}%sgu%{#} )
echo.
echo  -------------------------------------------------------------------------
"tools/cecho"  {0E} Options {#}
echo.
echo  -------------------------------------------------------------------------
echo   I: Install Framework                              B: Back to Main menu
echo  -------------------------------------------------------------------------
set choice=wrong
set /P choice=What would you like to do:
if %choice%==b goto main
if %choice%==B goto main
if %choice%==i goto installframework
if %choice%==I goto installframework
echo.
set choice=wrong
"tools/cecho" {0C}YOU ENTERD WRONG CHOICE{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto framework

:installframework
color 0F
cls
copy "add_framework_here\framework-res.apk" "tools" >nul
copy "add_framework_here\twframework-res.apk" "tools" >nul
copy "add_framework_here\com.htc.resources.apk" "tools" >nul
copy "add_framework_here\SemcGenericUxpRes.apk" "tools" >nul
copy "add_framework_here\SystemUI.apk" "tools" >nul
cd tools

if exist framework-res.apk (
java -jar %apktool% if framework-res.apk
call %root%\scripts\02_progress_bar.bat installing framework-res.apk
)

if exist twframework-res.apk (
java -jar %apktool% if twframework-res.apk
call %root%\scripts\02_progress_bar.bat installing twframework-res.apk
)

if exist com.htc.resources.apk (
java -jar %apktool% if com.htc.resources.apk
call %root%\scripts\02_progress_bar.bat installing com.htc.resources.apk
)

if exist SemcGenericUxpRes.apk (
java -jar %apktool% if SemcGenericUxpRes.apk
call %root%\scripts\02_progress_bar.bat installing SemcGenericUxpRes.apk
)

if exist SystemUI.apk (
java -jar %apktool% if SystemUI.apk
call %root%\scripts\02_progress_bar.bat installing SystemUI.apk
)

if not exist *.apk (
cd ..
"tools/cecho" {0C}Framework Not Successfully Installed{#}
echo.
"tools/cecho" {0C}Press Enter To Continue{#}
echo.
pause>nul
ping -n 3 -w 200 127.0.0.1 > nul
goto framework
)
del *.apk /q >nul
cd ..
cls
"tools/cecho" {0A}Framework Successfully Installed{#}
echo.
"tools/cecho" {0A}Press Enter To Continue{#}
echo.
pause>nul
ping -n 3 -w 200 127.0.0.1 > nul
goto framework

:main
exit /b
TITLE Afaneh Kitchen v1.0 by eng mohammad.afaneh@xda
@ECHO off

mode con:cols=75 lines=50

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "%~s0", "%params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit
)   else ( 
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    CD /D "%~dp0"
    goto continue 
)

:continue
cd "%~dp0"
mkdir add_apk_here
mkdir add_jar_here
mkdir add_classes_here
mkdir add_framework_here
mkdir compiled_apk
mkdir compiled_jar
mkdir compiled_classes
CLS

java -version 
IF errorlevel 1 (
"tools/cecho" {0C}JAVA NOT FOUND, PLZ INSTALL IT TO CONTINUE!{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
PAUSE                                               
)

set compression=1
set heapsize=512
set ver=v1.0

:main
COLOR 0F
set apk={0C}No{#}
set jar={0C}No{#}
set classes={0C}No{#}

FOR %%F IN (add_apk_here/*.apk) DO ( 
set apk=%%~nF%%~xF 
set ap=%%~nF
)
FOR %%F IN (add_jar_here/*.jar) DO ( 
set jar=%%~nF%%~xF 
set ja=%%~nF
)
IF EXIST "add_classes_here/classes.dex" set classes={0A}Yes{#}

cd "%~dp0"
CLS
"tools/cecho"  {0E}* --------------------------------------------------------------------- *{#}
ECHO.
"tools/cecho"  {0E}** ----------------------- {0A}Afaneh Kitchen %ver%{#}{0E} ----------------------- **{#}
ECHO.
"tools/cecho"  {0E}**** --------------------------------------------------------------- ****{#}
ECHO.
"tools/cecho"  {0E}****** ------------------- {0A}%TIME:~0,2%:%TIME:~3,2%{#} {0E}--{#} {0A}%Date:~-7,2%/%Date:~-10,2%/%Date:~-4,4%{#} {0E}------------------- ******{#}
ECHO.
ECHO  --------------------------------        ---------------------------------
"tools/cecho"   {0E}Apk Code Editing{#}                        {0E}Apk:{#} {0A}%apk%{#}
ECHO.
ECHO  --------------------------------        ---------------------------------
ECHO   1: Decompile Apk
ECHO   2: Compile Apk
ECHO   3: Sign Apk
ECHO   4: Zipalign Apk
ECHO.
ECHO  --------------------------------        ---------------------------------
"tools/cecho"   {0E}Classes.dex Code Editing{#}                {0E}Classes.dex:{#} %classes%
ECHO.
ECHO  --------------------------------        ---------------------------------
ECHO   5: Decompile Classes.dex
ECHO   6: Compile Classes.dex
ECHO.
ECHO  --------------------------------        ---------------------------------
"tools/cecho"   {0E}Jar Code Editing {#}                       {0E}Jar:{#} {0A}%jar%{#}
ECHO.
ECHO  --------------------------------        ---------------------------------
ECHO   7: Decompile Classes From Jar
ECHO   8: Compile Classes For Jar
ECHO.
ECHO  -------------------------------------------------------------------------
"tools/cecho"   {0E}Advanced Options{#}
ECHO.
ECHO  -------------------------------------------------------------------------
ECHO   F: Framework Installation               C: Clear All Data 
ECHO   X: Select Compression Level             H: Set Max Memory Heap Size
ECHO.
ECHO  -------------------------------------------------------------------------
"tools/cecho"  {0E} Other Options {#}
ECHO.
ECHO  -------------------------------------------------------------------------
ECHO   R: Refresh                              Q: Quit
ECHO.
ECHO  -------------------------------------------------------------------------
set choice=wrong
SET /P choice=What would you like to do:
IF %choice%==1 goto apkdecompile
IF %choice%==2 goto apkcompile
IF %choice%==3 goto apksign
IF %choice%==4 goto apkzipalign
IF %choice%==5 goto decompileclasses
IF %choice%==6 goto compileclasses
IF %choice%==7 goto decompilejar
IF %choice%==8 goto compilejar
IF %choice%==x goto compression
IF %choice%==X goto compression
IF %choice%==h goto heapsize
IF %choice%==H goto heapsize
IF %choice%==f goto framework
IF %choice%==F goto framework
IF %choice%==c goto confirmclear
IF %choice%==C goto confirmclear
IF %choice%==r goto main
IF %choice%==R goto main
IF %choice%==q goto quit
IF %choice%==Q goto quit
echo.
set choice=wrong
"tools/cecho" {0C}YOU ENTERD WRONG CHOICE{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main

:apkdecompile
IF NOT EXIST "add_apk_here/*.apk" (
"tools/cecho" {0C}No Apk To Decompile{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
IF EXIST "working/%ap%" (rmdir /S /Q "working/%ap%")
cd tools
java -Xmx%heapsize%m -jar apktool.jar d ../add_apk_here/%apk% -o ../working/%ap%
IF errorlevel 1 (
"cecho" {0C}An Error Occured While Decompiling %apk%{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
PAUSE
cd ..
goto main
)
cd ..
"tools/cecho" {0A}Finished decompiling %apk%{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main

:apkcompile
IF NOT EXIST "add_apk_here/%apk%" (
"tools/cecho" {0C}No Apk To Compile{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
IF NOT EXIST "%~dp0working\%ap%" (
"tools/cecho" {0C}Nothing To Compile{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
IF EXIST "compiled_apk/%ap%" (rmdir /S /Q "compiled_apk/%ap%")
mkdir "compiled_apk/%ap%"
copy "add_apk_here\%apk%" "compiled_apk/%ap%"
cd tools
IF EXIST "%~dp0compiled_apk\%ap%\unsigned%apk%" (del /Q "%~dp0compiled_apk\%ap%\unsigned%apk%")
java -Xmx%heapsize%m -jar apktool.jar b ../working/%ap% -o ../compiled_apk\%ap%\unsigned%apk%
IF errorlevel 1 (
"cecho" {0C}An Error Occured While Compiling %apk%{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
PAUSE
cd ..
goto main
)
7za a -tzip "../compiled_apk/%ap%/unsigned%apk%" "../working/%ap%/original/*" -mx%compression% -r
cd ..
rmdir "working\%ap%\build" /s /q
"tools/cecho" {0A}Finished compiling %apk%{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main

:apksign
IF NOT EXIST "add_apk_here/%apk%" (
"tools/cecho" {0C}No Apk To sign{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
IF NOT EXIST "%~dp0compiled_apk\%ap%\unsigned%apk%" (
"tools/cecho" {0C}No unsigned%apk%To sign{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
cd tools
java -Xmx%heapsize%m -jar signapk.jar -w testkey.x509.pem testkey.pk8 ../compiled_apk/%ap%/unsigned%apk% ../compiled_apk/%ap%/signed%apk%
IF errorlevel 1 (
"cecho" {0C}An Error Occured While Signing %apk%{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
PAUSE
cd..
goto main
)
cd ..
"tools/cecho" {0A}Finished signing %apk%{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main

:apkzipalign
IF NOT EXIST "add_apk_here/%apk%" (
"tools/cecho" {0C}No Apk To Zipalign{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
IF NOT EXIST "%~dp0compiled_apk\%ap%\signed%apk%" (
"tools/cecho" {0C}%apk%Must Be signed To Zipalign{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
cd tools
zipalign -fv 4 "../compiled_apk/%ap%/signed%apk%" "../compiled_apk/%ap%/signedzipaligned%apk%" >nul
IF errorlevel 1 (
"cecho" {0C}An Error Occured While Zipaligning signed%apk%{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
PAUSE
cd..
goto main
)
cd ..
"tools/cecho" {0A}Finished zipaligning %apk%{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main

:decompileclasses
IF NOT EXIST "add_classes_here/classes.dex" (
"tools/cecho" {0C}Error while decompiling classes.dex, file not detected{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
goto main 
)
IF EXIST "working/classout" ( rmdir "working/classout" /s /q )
java -jar tools/baksmali.jar -o "working/classout/" "add_classes_here/classes.dex" >nul
IF errorlevel 1 (
"tools/cecho" {0C}An Error Occured While Decompiling classes.dex{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
PAUSE
goto main
)
"tools/cecho" {0A}Finished Decompiling Process For classes.dex{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
goto main

:compileclasses
IF NOT EXIST "%~dp0working\classout" (
"tools/cecho" {0C}Error While Compiling classes.dex, No classout Folder To Compile{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
rmdir "compiled_classes" /s /q
mkdir "compiled_classes"
copy "add_classes_here\classes.dex" "compiled_classes/old-classes.dex" 
java -Xmx%heapsize%M -jar tools/smali.jar "working/classout/" -o "compiled_classes/classes.dex" >nul
IF errorlevel 1 (
"tools/cecho" {0C}An Error Occured While Compiling classes.dex{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
"tools/cecho" {0A}Finished Compiling Process For classes.dex{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
goto main

:decompilejar
IF NOT EXIST "add_jar_here/%jar%" (
"tools/cecho" {0C}No Jar File To Decompile{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
IF EXIST "working/%ja%" (rmdir /S /Q "working/%ja%")

"tools/7za.exe" x -o"working/%ja%" "add_jar_here/%jar%" >nul
java -jar tools/baksmali.jar -o "working/%ja%/classout/" "working/%ja%/classes.dex" >nul
IF errorlevel 1 (
"tools/cecho" {0C}An Error Occured While Decompiling %jar%{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
PAUSE
goto main
)
"tools/cecho" {0A}Finished Decompiling Process For %jar%{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
goto main

:compilejar
IF NOT EXIST "%~dp0working\%ja%\classout" (
"tools/cecho" {0C}Error While Compiling Jar, No classout Folder To Compile{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
rmdir "compiled_jar/%ja%" /s /q
mkdir "compiled_jar/%ja%"
copy "add_jar_here\%jar%" "compiled_jar/%ja%/old-%jar%"
copy "add_jar_here\%jar%" "compiled_jar/%ja%/%jar%"
java -Xmx%heapsize%M -jar tools/smali.jar "working/%ja%/classout/" -o"compiled_jar/%ja%/classes.dex" >nul
IF errorlevel 1 (
"tools/cecho" {0C}An Error Occured While Compiling classes.dex For %jar%{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
PAUSE
goto main
)
copy "working\%ja%\classes.dex" "compiled_jar/%ja%/old-classes.dex"
cd tools
7za a -tzip "../compiled_jar/%ja%/%jar%" "../compiled_jar/%ja%/classes.dex" -mx%compression% -r
cd ..
"tools/cecho" {0A}Finished Compiling classes.dex For %jar%{#}
ECHO.
ping -n 3 -w 200 127.0.0.1 > nul
goto main

:heapsize
set /P INPUT=Enter max size for java heap space in megabytes (eg 512) : %=%
set heapsize=%INPUT%
goto main

:compression
set /P INPUT=Enter Compression Level (0-9) : %=%
set compression=%INPUT%
goto main

:framework
COLOR 0F
CLS
set fra={0C}No{#}
set twf={0C}No{#}
set sui={0C}No{#}
set chr={0C}No{#}
set sgu={0C}No{#}
cd /D "%temp%"
IF EXIST "../../../apktool/framework/1.apk" set fra=Yes
IF EXIST "../../../apktool/framework/2.apk" set twf=Yes 
IF EXIST "../../../apktool/framework/127.apk" set sui=Yes
cd /D "%~dp0"

"tools/cecho"  {0E}* --------------------------------------------------------------------- *{#}
ECHO.
"tools/cecho"  {0E}** ----------------------- {0A}Afaneh Kitchen %ver%{#}{0E} ----------------------- **{#}
ECHO.
"tools/cecho"  {0E}**** --------------------------------------------------------------- ****{#}
ECHO.
"tools/cecho"  {0E}****** ------------------- {0A}%TIME:~0,2%:%TIME:~3,2%{#} {0E}--{#} {0A}%Date:~-7,2%/%Date:~-10,2%/%Date:~-4,4%{#} {0E}------------------- ******{#}
ECHO.
ECHO.
ECHO  -------------------------------------------       -----------------------
"tools/cecho"   {0E}Framework Installation{#}                            {0E}Installation Status{#}
ECHO.
ECHO  -------------------------------------------       -----------------------
IF NOT EXIST "add_framework_here/framework-res.apk" ( "tools/cecho"    {0C}framework-res.apk        Not detected {#}              {0E}Installed:{#} {0A}%fra%{#} )
IF EXIST "add_framework_here/framework-res.apk" ( "tools/cecho"    {0A}Framework-res.apk        detected {#}                  {0E}Installed:{#} {0A}%fra%{#} )
ECHO.
IF NOT EXIST "add_framework_here/twframework-res.apk" ( "tools/cecho"    {0C}twframework-res.apk      Not detected {#}              {0E}Installed:{#} {0A}%twf%{#} )
IF EXIST "add_framework_here/twframework-res.apk" ( "tools/cecho"    {0A}twframework-res.apk      detected {#}                  {0E}Installed:{#} {0A}%twf%{#} )
ECHO.
IF NOT EXIST "add_framework_here/SystemUI.apk" ( "tools/cecho"    {0C}SystemUI.apk             Not detected {#}              {0E}Installed:{#} {0A}%sui%{#} )
IF EXIST "add_framework_here/SystemUI.apk" ( "tools/cecho"    {0A}SystemUI.apk             detected {#}                  {0E}Installed:{#} {0A}%sui%{#} )
ECHO.
IF NOT EXIST "add_framework_here/com.htc.resources.apk" ( "tools/cecho"    {0C}com.htc.resources.apk    Not detected {#}              {0E}Installed:{#} {0A}%chr%{#} )
IF EXIST "add_framework_here/com.htc.resources.apk" ( "tools/cecho"    {0A}com.htc.resources.apk    detected {#}                  {0E}Installed:{#} {0A}%chr%{#} )
ECHO.
IF NOT EXIST "add_framework_here/SemcGenericUxpRes.apk" ( "tools/cecho"    {0C}SemcGenericUxpRes.apk    Not detected {#}              {0E}Installed:{#} {0A}%sgu%{#} )
IF EXIST "add_framework_here/SemcGenericUxpRes.apk" ( "tools/cecho"    {0A}SemcGenericUxpRes.apk    detected {#}                  {0E}Installed:{#} {0A}%sgu%{#} )
ECHO.
ECHO  -------------------------------------------------------------------------
ECHO.
"tools/cecho" {0A}Press Enter To Continue{#}
echo.
pause>nul
ping -n 3 -w 200 127.0.0.1 > nul

CLS
copy "add_framework_here\framework-res.apk" "tools" >nul
copy "add_framework_here\twframework-res.apk" "tools" >nul
copy "add_framework_here\com.htc.resources.apk" "tools" >nul
copy "add_framework_here\SemcGenericUxpRes.apk" "tools" >nul
copy "add_framework_here\SystemUI.apk" "tools" >nul
cd tools

IF EXIST framework-res.apk (
java -jar apktool.jar if framework-res.apk
"tools/cecho" {0A}Installed framework-res.apk{#}
echo.
)

IF EXIST twframework-res.apk (
java -jar apktool.jar if twframework-res.apk
"tools/cecho" {0A}Installed twframework-res.apk{#}
echo.
)

IF EXIST com.htc.resources.apk (
java -jar apktool.jar if com.htc.resources.apk
"tools/cecho" {0A}Installed com.htc.resources.apk{#}
echo.
)

IF EXIST SemcGenericUxpRes.apk (
java -jar apktool.jar if SemcGenericUxpRes.apk
"tools/cecho" {0A}Installed SemcGenericUxpRes.apk{#}
echo.
)

IF EXIST SystemUI.apk (
java -jar apktool.jar if SystemUI.apk
"tools/cecho" {0A}Installed SystemUI.apk{#}
echo.
)

IF NOT EXIST *.apk (
cd ..
"tools/cecho" {0C}Framework Not Successfully Installed{#}
echo.
"tools/cecho" {0C}Press Enter To Continue{#}
echo.
pause>nul
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
del *.apk /q >nul
cd ..
"tools/cecho" {0A}Framework Successfully Installed{#}
echo.
"tools/cecho" {0A}Press Enter To Continue{#}
echo.
pause>nul
ping -n 3 -w 200 127.0.0.1 > nul
goto main

:confirmclear
echo.
"tools/cecho" {0C}BE CAREFULL THIS WILL WIPE ALL APP, JAR , CLASSES.DEX AND WORKING FOLDER{#}
echo.
echo.
set choice=wrong
SET /P choice=Do you wish to continue?(Y/N):
IF %choice%==Y goto clear
IF %choice%==y goto clear
IF %choice%==N goto main
IF %choice%==n goto main
set choice=wrong
"tools/cecho" {0C}YOU ENTERD WRONG CHOICE{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main


:clear
rmdir working /s /q
mkdir working
rmdir add_framework_here /s /q
mkdir add_framework_here
rmdir add_apk_here /s /q
mkdir add_apk_here
rmdir add_jar_here /s /q
mkdir add_jar_here
rmdir add_classes_here /s /q
mkdir add_classes_here
rmdir compiled_classes /s /q
mkdir compiled_classes
rmdir compiled_apk /s /q
mkdir compiled_apk
rmdir compiled_jar /s /q
mkdir compiled_jar
goto main

:quit
exit
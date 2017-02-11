title Afaneh Kitchen v4.0 by eng mohammad.afaneh@xda
@echo off
::setlocal enableDelayedExpansion
mode con:cols=75 lines=50

java -version 
if errorlevel 1 (
"tools/cecho" {0C}JAVA NOT FOUND, PLZ INSTALL IT TO CONTINUE!{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
pause                                               
)

set ver=0
for %%x in (tools/apktool_*.jar) do (
  set "FN=%%~nx"
  set "FN=!FN:apktool_=!"
  if !FN! GTR !ver! set ver=!FN!
)
set apktool=apktool_%ver:~0,5%.jar
set compression=1
set heapsize=512
set apk={0C}No{#}
set jar={0C}No{#}
set classes={0C}No{#}

:main
color 0F

if not exist add_apk_here mkdir add_apk_here
if not exist compiled_apk mkdir compiled_apk
if not exist add_jar_here mkdir add_jar_here
if not exist compiled_jar mkdir compiled_jar
if not exist add_classes_here mkdir add_classes_here
if not exist add_framework_here mkdir add_framework_here
if not exist compiled_classes mkdir compiled_classes
if not exist working mkdir working

for %%F in (add_apk_here/*.apk) do ( 
set apk=%%~nF%%~xF 
set ap=%%~nF
)

for %%F in (add_jar_here/*.jar) do ( 
set jar=%%~nF%%~xF 
set ja=%%~nF
)
if exist "add_classes_here/classes.dex" set classes={0A}Yes{#}

CLS
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
"tools/cecho"   {0E}Apktool Version:{#} {0A}%apktool%{#}
echo.
echo  -------------------------------------------------------------------------
"tools/cecho"   {0E}Apk Code Editing{#}                        {0E}Apk:{#} {0A}%apk%{#}
echo.
echo  --------------------------------        ---------------------------------
echo   1: Decompile Apk                        3: Sign Apk
echo   2: Compile Apk                          4: Zipalign Apk
echo  --------------------------------        ---------------------------------
"tools/cecho"   {0E}Classes.dex Code Editing{#}                {0E}Classes.dex:{#} %classes%
echo.
echo  --------------------------------        ---------------------------------
echo   5: Decompile Classes.dex                6: Compile Classes.dex
echo  --------------------------------        ---------------------------------
"tools/cecho"   {0E}Jar Code Editing {#}                       {0E}Jar:{#} {0A}%jar%{#}
echo.
echo  --------------------------------        ---------------------------------
echo   7: Decompile Classes From Jar           8: Compile Classes for Jar
echo  -------------------------------------------------------------------------
"tools/cecho"   {0E}Advanced Options{#}
echo.
echo  -------------------------------------------------------------------------
echo   F: Framework Installation               C: Clear All Data 
echo   X: Select Compression Level             H: Set Max Memory Heap Size
if not exist plugins (echo   J: Select apktool jar) else echo   P: Extra Plugins                        J: Select apktool jar
echo  -------------------------------------------------------------------------
"tools/cecho"  {0E} Other Options {#}
echo.
echo  -------------------------------------------------------------------------
echo   R: Refresh                              Q: Quit
echo  -------------------------------------------------------------------------
set choice=wrong
set /P choice=What would you like to do:
if %choice%==1 goto apkdecompile
if %choice%==2 goto apkcompile
if %choice%==3 goto apksign
if %choice%==4 goto apkzipalign
if %choice%==5 goto decompileclasses
if %choice%==6 goto compileclasses
if %choice%==7 goto decompilejar
if %choice%==8 goto compilejar
if %choice%==x goto compression
if %choice%==X goto compression
if %choice%==h goto heapsize
if %choice%==H goto heapsize
if %choice%==f goto framework
if %choice%==F goto framework
if %choice%==p goto extraplugins
if %choice%==P goto extraplugins
if %choice%==j goto apktool
if %choice%==J goto apktool
if %choice%==c goto confirmclear
if %choice%==C goto confirmclear
if %choice%==r goto main
if %choice%==R goto main
if %choice%==q goto quit
if %choice%==Q goto quit
echo.
set choice=wrong
"tools/cecho" {0C}YOU ENTERD WRONG CHOICE{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main

:apkdecompile
if not exist "add_apk_here/*.apk" (
"tools/cecho" {0C}No Apk To Decompile{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
if exist "working/%ap%" (rmdir /S /Q "working/%ap%")
cd tools
java -Xmx%heapsize%m -jar "%apktool%" d ../add_apk_here/%apk% -o ../working/%ap%
if errorlevel 1 (
"cecho" {0C}An Error Occured While Decompiling %apk%{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
pause
cd ..
goto main
)
cd ..
"tools/cecho" {0A}Finished decompiling %apk%{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main

:apkcompile
if not exist "add_apk_here/%apk%" (
"tools/cecho" {0C}No Apk To Compile{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
if not exist "%root%\working\%ap%" (
"tools/cecho" {0C}Nothing To Compile{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
if exist "compiled_apk/%ap%" (rmdir "compiled_apk/%ap%" /s /q )
mkdir "compiled_apk/%ap%"
cd tools
if exist "%root%\compiled_apk\%ap%\unsigned-%apk%" (del /Q "%roott%\compiled_apk\%ap%\unsigned-%apk%")
java -Xmx%heapsize%m -jar "%apktool%" b ../working/%ap% -o ../compiled_apk\%ap%\unsigned-%apk%
if errorlevel 1 (
"cecho" {0C}An Error Occured While Compiling %apk%{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
pause
cd ..
goto main
)
7za a -tzip "../compiled_apk/%ap%/unsigned%apk%" "../working/%ap%/original/*" -mx%compression% -r
cd ..
if exist "working\%ap%\build" (rmdir "working\%ap%\build" /s /q)
"tools/cecho" {0A}Finished compiling %apk%{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
pause
goto main

:apksign
if not exist "add_apk_here/%apk%" (
"tools/cecho" {0C}No Apk To sign{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
if exist "%root%\compiled_apk\%ap%\signed-*" (
"tools/cecho" {0C}%apk% Already signed{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
if not exist "%root%\compiled_apk\%ap%\unsigned-*" (
   "tools/cecho" {0C}No unsigned-%apk%To sign{#}
   echo.
   ping -n 3 -w 200 127.0.0.1 > nul
   goto main
)
for %%F in ("%root%\compiled_apk\%ap%\*.apk") Do (
    set "string1=unsigned"
    set "string2=signed"
    set "unsigned-apk=%%~nF"
	set "signed-apk=!unsigned-apk:%string1%=%string2%!"
)
cd tools
java -Xmx%heapsize%m -jar signapk.jar -w testkey.x509.pem testkey.pk8 "../compiled_apk/%ap%/%unsigned-apk%.apk" "../compiled_apk/%ap%/%signed-apk%.apk"
if errorlevel 1 (
"cecho" {0C}An Error Occured While Signing %apk%{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
pause
cd..
goto main
)
cd ..
del "%root%\compiled_apk\%ap%\%unsigned-apk%.apk"
"tools/cecho" {0A}Finished signing %apk%{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
pause
goto main

:apkzipalign
if not exist "add_apk_here/%apk%" (
"tools/cecho" {0C}No Apk To Zipalign{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
if exist "compiled_apk\%ap%\*signed-zipaligned-*" (
"tools/cecho" {0C}%apk% Already Zipaligned{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
if not exist "compiled_apk\%ap%\*%apk%" (
"tools/cecho" {0C}No %apk% To Zipalign{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
for %%F in ("compiled_apk\%ap%\*.apk") Do (
    set "string3=signed"
    set "string4=signed-zipaligned"
    set "unzipaligned-apk=%%~nF"
	set "zipaligned-apk=!unzipaligned-apk:%string3%=%string4%!"
)
cd tools
zipalign -fv 4 "../compiled_apk/%ap%/%unzipaligned-apk%.apk" "../compiled_apk/%ap%/%zipaligned-apk%.apk" > nul
if errorlevel 1 (
"cecho" {0C}An Error Occured While Zipaligning %apk%{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
pause
cd..
goto main
)
cd ..
del "%root%\compiled_apk\%ap%\%unzipaligned-apk%.apk"
"tools/cecho" {0A}Finished zipaligning %apk%{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
pause
goto main

:decompileclasses
if not exist "add_classes_here/classes*.dex" (
"tools/cecho" {0C}Error while decompiling classes.dex, file not detected{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main 
)
if exist "working/classes*" ( rmdir "working/classes*" /s /q)
for %%F in ("add_classes_here/*.dex") Do (
	java -jar tools/baksmali.jar -o "working/%%~nF/" "add_classes_here/%%F" >nul
    if errorlevel 1 (
    "tools/cecho" {0C}An Error Occured While Decompiling classes.dex{#}
    echo.
    ping -n 3 -w 200 127.0.0.1 > nul
    pause
    goto main
    )
)
"tools/cecho" {0A}Finished Decompiling Process for classes.dex{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main

:compileclasses
if not exist "%root%\working\classes*" (
"tools/cecho" {0C}Error While Compiling classes.dex, No classout Folder To Compile{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
if exist "compiled_classes" ( rmdir "compiled_classes" /s /q)
mkdir "compiled_classes"
for /d %%D in (working/classes*) Do (
    java -Xmx%heapsize%M -jar tools/smali.jar "working/%%D" -o "compiled_classes/%%D.dex" >nul
    if errorlevel 1 (
    "tools/cecho" {0C}An Error Occured While Compiling classes.dex{#}
    echo.
    ping -n 3 -w 200 127.0.0.1 > nul
    pause
    goto main
    )
)
"tools/cecho" {0A}Finished Compiling Process for classes.dex{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
pause
goto main

:decompilejar
if not exist "add_jar_here/%jar%" (
"tools/cecho" {0C}No Jar File To Decompile{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
if exist "working/%ja%" (rmdir "working/%ja%" /s /q)
"tools/7za" x -o"working/%ja%" "add_jar_here/%jar%" >nul
for %%F in ("working/%ja%/*.dex") Do (
    java -jar tools/baksmali.jar -o "working/%ja%/%%~nF/" "working/%ja%/%%F" >nul
    if errorlevel 1 (
    "tools/cecho" {0C}An Error Occured While Decompiling %jar%{#}
    echo.
    ping -n 3 -w 200 127.0.0.1 > nul
    pause
    goto main
    )
)
"tools/cecho" {0A}Finished Decompiling Process for %jar%{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main

:compilejar
if not exist "%root%\working\%ja%\classes*" (
"tools/cecho" {0C}Error While Compiling Jar, No classout Folder To Compile{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main
)
if exist "compiled_jar/%ja%" (rmdir "compiled_jar/%ja%" /s /q)
mkdir "compiled_jar/%ja%"
copy "add_jar_here\%jar%" "compiled_jar/%ja%/%jar%"
for /d %%D in (working/%ja%/classes*) Do (
    java -Xmx%heapsize%M -jar tools/smali.jar "working/%ja%/%%D" -o"compiled_jar/%ja%/%%D.dex" >nul
    if errorlevel 1 (
    "tools/cecho" {0C}An Error Occured While Compiling classes.dex for %jar%{#}
    echo.
    ping -n 3 -w 200 127.0.0.1 > nul
    pause
    goto main
    )
)
cd tools
7za a -tzip "../compiled_jar/%ja%/%jar%" "../compiled_jar/%ja%/classes*.dex" -mx%compression% -r
cd ..
"tools/cecho" {0A}Finished Compiling classes.dex for %jar%{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
pause
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
call scripts\03_install_framework.bat
goto main

:extraplugins
call scripts\01_extra_plugins.bat
goto main

:apktool
set count=0
for %%x in (tools/apktool*) do (
  set /a count=count+1
  set choice[!count!]=%%x
)
echo.
echo Select one:
echo.
for /l %%x in (1,1,!count!) do (
   echo %%x] !choice[%%x]!
)
echo.
set /p select=? 
echo.
echo You chose !choice[%select%]!
set apktool=!choice[%select%]!
goto main

:confirmclear
echo.
"tools/cecho" {0C}BE CAREFULL THIS WILL WIPE ALL APP, JAR , CLASSES.DEX AND WORKING FOLDER{#}
echo.
echo.
set choice=wrong
set /P choice=Do you wish to continue?(Y/N):
if %choice%==Y goto clear
if %choice%==y goto clear
if %choice%==N goto main
if %choice%==n goto main
set choice=wrong
"tools/cecho" {0C}YOU ENTERD WRONG CHOICE{#}
echo.
ping -n 3 -w 200 127.0.0.1 > nul
goto main


:clear
cd %root%
if exist working (rmdir working /s /q)
if exist add_framework_here (rmdir add_framework_here /s /q)
if exist add_apk_here (rmdir add_apk_here /s /q)
if exist add_jar_here (rmdir add_jar_here /s /q)
if exist add_classes_here (rmdir add_classes_here /s /q)
if exist compiled_classes (rmdir compiled_classes /s /q)
if exist compiled_apk (rmdir compiled_apk /s /q)
if exist compiled_jar (rmdir compiled_jar /s /q)
goto main

:quit
exit
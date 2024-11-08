@echo off

rem ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
rem
rem Using:
rem 
rem set BuildAll=BuildAll:Rebuild /p:RunCodeAnalysis=true
rem 
rem call BuildSolution.cmd "Debug:x64,Release:x64" "Clean:Rebuild,%BuildAll%"
rem
rem ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set Configurations=%~1
set Actions=%~2

set MsBuildResult=".\Solution\Solution\(Documentation)\MSBuild.result.txt"
set LogInfo=/fileLogger /flp:Append;Verbosity=quiet;LogFile=%MsBuildResult%

del %MsBuildResult%

rem ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
rem The build attribute is made from the script
rem ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

call %~dp0\MsBuild.auto.cmd

set USING_SCRIPT_BILDING=TRUE

for %%S in (*.sln) do (

for %%C in (%Configurations%) do (

for /F "delims=: tokens=1,2" %%a in ("%%C") do (

for /F "delims=, tokens=1-5" %%c in ("%Actions%") do (

call :CallMsBuild "%%S" "%%c" "/p:Configuration=%%a;Platform=%%b"
call :CallMsBuild "%%S" "%%d" "/p:Configuration=%%a;Platform=%%b"
call :CallMsBuild "%%S" "%%e" "/p:Configuration=%%a;Platform=%%b"
call :CallMsBuild "%%S" "%%f" "/p:Configuration=%%a;Platform=%%b"
call :CallMsBuild "%%S" "%%g" "/p:Configuration=%%a;Platform=%%b"

)

)

)

)

exit /b

:CallMsBuild

if NOT "%~2" == "" (

%MsBuild% %~1 /t:Solution\Build\%~2 %~3 %LogInfo%

)

exit /b

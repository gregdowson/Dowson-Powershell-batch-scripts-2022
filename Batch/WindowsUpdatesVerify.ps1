@echo off

rem del /q SASS*.csv
SET /P firstname=[Your First Name]
SET /P lastname=[Your Last Name]
FOR /F "tokens=1-4 delims=/ " %%I in ('date /t') do set mydate=%%J-%%K-%%L
FOR /F "tokens=1-3 delims=:" %%M in ('time /t') do set mytime=%%M:%%N
sass -i "c:\sass\wsusscn2.cab" -o "c:\sass\SASS-%computername%-%mydate%.csv"
ren c:\sass\SASS-%computername%-%mydate%.csv out-%computername%-%mydate%.csv
echo SASS Scan run by %firstname% %lastname% on %mydate% at %mytime% >> c:\sass\out-%computername%-%mydate%.csv
for /f "tokens=1,* delims=]" %%A in ('"type out-%computername%-%mydate%.csv|find /n /v """') do (
    set "line=%%B"
    if defined line (
        call set "line=echo.%%line:!=,%%"
        for /f "delims=" %%X in ('"echo."%%line%%""') do %%~X >> c:\sass\SASS-%computername%-%mydate%.csv
    ) ELSE echo. >> c:\sass\SASS-%computername%-%mydate%.csv
)

del /q out*.*Enter file contents here

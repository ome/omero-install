
rem setx only affects new command prompts, so only call once

rem The non-interactive Python install behaves slightly differently from the
interactive install with defaults (IIS fails to work) so for now you must
rem interactively accept the default installation settings :-(
rem start /w msiexec /passive /i python-2.7.9\python-2.7.9.amd64.msi
start /w msiexec /i python-2.7.9\python-2.7.9.amd64.msi

rem The Java 1.8 installer fails to setup the system PATHs, so it needs to be
rem set manually later
start /w jre-8u45-windows-x64.exe /s

start /w postgresql-9.4.1-3-windows-x64.exe --mode unattended


rmdir /s /q Ice-3.5.1-b3-win-x64-Release
start /w cscript j_unzip.vbs Ice-3.5.1-b3-win-x64-Release.zip
rem move Ice-3.5.1-b3-win-x64-Release c:\
xcopy /e /i Ice-3.5.1-b3-win-x64-Release c:\Ice-3.5.1-b3-win-x64-Release


IF DEFINED PYTHONPATH (setx /m PYTHONPATH "c:\Ice-3.5.1-b3-win-x64-Release\python;%PYTHONPATH%") ELSE (setx /m PYTHONPATH "c:\Ice-3.5.1-b3-win-x64-Release\python")

setx /m PATH "c:\Ice-3.5.1-b3-win-x64-Release\bin;c:\Ice-3.5.1-b3-win-x64-Release\lib;c:\Program Files\Java\jre1.8.0_45\bin;c:\Python27;c:\Program Files\PostgreSQL\9.4\bin;%PATH%"

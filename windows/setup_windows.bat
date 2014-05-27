
rem setx only affects new command prompts, so only call once

start /w msiexec /passive /i python-2.7.6\python-2.7.6.amd64.msi

start /w jre-7u55-windows-x64.exe /s

start /w postgresql-9.3.2-3-windows-x64.exe --mode unattended


rmdir /s /q Ice-3.5.1-win-x64-Release
start /w cscript j_unzip.vbs Ice-3.5.1-win-x64-Release.zip
rem move Ice-3.5.1-win-x64-Release c:\
xcopy /e /i Ice-3.5.1-win-x64-Release c:\Ice-3.5.1-win-x64-Release


IF DEFINED PYTHONPATH (setx /m PYTHONPATH "c:\Ice-3.5.1-win-x64-Release\python;%PYTHONPATH%") ELSE (setx /m PYTHONPATH "c:\Ice-3.5.1-win-x64-Release\python")

setx /m PATH "c:\Ice-3.5.1-win-x64-Release\bin;c:\Ice-3.5.1-win-x64-Release\lib;c:\Python27;c:\Program Files\PostgreSQL\9.3\bin;%PATH%"



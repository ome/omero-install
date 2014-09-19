
rem setx only affects new command prompts, so only call once

rem The non-interactive Python install behaves slightly differently from the interactive
rem install with defaults (IIS fails to work) so for now you must interactively accept the
rem default installation settings :-(
rem start /w msiexec /passive /i python-2.6.6\python-2.6.6.amd64.msi
start /w msiexec /i python-2.6.6\python-2.6.6.amd64.msi

start /w jre-7u55-windows-x64.exe /s

start /w postgresql-9.3.4-3-windows-x64.exe --mode unattended

start /w msiexec /passive /i Ice-3.4.2.msi


IF DEFINED PYTHONPATH (setx /m PYTHONPATH "c:\Program Files (x86)\ZeroC\Ice-3.4.2\python\x64;%PYTHONPATH%") ELSE (setx /m PYTHONPATH "c:\Program Files (x86)\ZeroC\Ice-3.4.2\python\x64")

setx /m PATH "c:\Program Files (x86)\ZeroC\Ice-3.4.2\bin\x64;c:\Python26;c:\Program Files\PostgreSQL\9.3\bin;%PATH%"



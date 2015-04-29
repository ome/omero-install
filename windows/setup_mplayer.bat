start /w msiexec /passive /i extras\7z938-x64.msi

"c:\Program Files\7-Zip\7z.exe" x extras\mplayer-svn-37353-x86_64.7z
move mplayer-svn-37353-x86_64 c:\

setx /m PATH "c:\mplayer-svn-37353-x86_64;%PATH%"
rem Note a reboot will be needed due to a change of PATH

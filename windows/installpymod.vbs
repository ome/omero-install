Set ws = CreateObject("WScript.Shell")

If WScript.Arguments.Count < 2 Then
    WScript.Echo "Arguments: python-module.exe delay-ms"
    WScript.Quit
End If

ws.Run WScript.Arguments(0), 1, False
Wscript.Sleep 1000
ws.SendKeys "{ENTER}"
Wscript.Sleep 500
ws.SendKeys "{ENTER}"
Wscript.Sleep 500
ws.SendKeys "{ENTER}"
Wscript.Sleep WScript.Arguments(1)
ws.SendKeys "{ENTER}"

' An extra enter just in case?
' Wscript.Sleep 500
' ws.SendKeys "{ENTER}"

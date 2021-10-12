#$language = "VBScript"
#$interface = "1.0"
 
Dim UsrID  'username
Dim UsrPass    'password
Dim Ip    'Ip
Dim Port    'Port
 
Public Sub login
  UsrID=crt.Arguments.Getarg(0)
  UsrPass=crt.Arguments.Getarg(1)
  Ip=crt.Arguments.Getarg(2)
  Port=crt.Arguments.Getarg(3)
End Sub
 
Sub main
  login
  WXB
End Sub
 
Sub WXB
crt.Screen.Synchronous = True
crt.session.connectintab("/SSH2 /L " & UsrID & " /PASSWORD " & UsrPass & " " & Ip & ":" & Port)
Rem crt.session.connectintab("/SSH2 /L " & UsrID & " /PASSWORD " & UsrPass & " & Ip & ":" & Port)
End Sub
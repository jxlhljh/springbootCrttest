<hr style=" border:solid; width:100px; height:1px;" color=#000000 size=1">

# 通过url协议实现web html调用本地securecrt程序并自动登录服务器
>需求：通过html调用securecrt程序并自动登陆。

## 一、先准备securecrt自动登陆的脚本bat和vbs
`先新建一个目录如d:/temp/autologintest`
### 1.在D:\temp\autologintest目录下新建sshlogin.vbs,内容如下
```c
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
```
### 2.在D:\temp\autologintest目录下sshlogin.bat，内容如下，用于实现能自动登陆crt并连接
```c
:: @set /p name=username：
:: @set /p pwd=password：
 
set name="testuser"
set pwd="123456"
set ip="172.168.201.148"
set port="22"
 
start "" "C:\software\SecureCRT\SecureCRT.exe" /SCRIPT "D:\temp\autologintest\sshlogin.vbs" /arg %name% /arg %pwd% /arg %ip% /arg %port%
:end
exit
```
`注：你需要修改上面的内容中的SecureCRT.exe及sshlogin.vbs的路径为你自己使用的，以及对应的ssh账号相关信息`

### 3.双击sshlogin.bat进行sucurecrt自动登陆测试
在D:\temp\autologintest目录下双击sshlogin.bat进行自动登陆脚本测试，确实能通过sshlogin.bat实现ssh的自动连接，如下如示：
![在这里插入图片描述](https://img-blog.csdnimg.cn/1679665fc55f407b8cc36a68b2d598a4.gif)
## 二、Url协议注册
### 1.编写ProtocalReg.reg注册表内容
>如果你要让程序处理某个自定义URL协议的话，只要在HKEY_CLASSES_ROOT注册一下这个协议就可以，如下为注册myCrtshell的自定议协议内容，然后把内容保存在ProtocalReg.reg文件中.
```c
Windows Registry Editor Version 5.00
[HKEY_CLASSES_ROOT\myCrtshell]
@="URL:myCrtshell Protocol Handler"
"URL Protocol"=""
[HKEY_CLASSES_ROOT\myCrtshell\DefaultIcon]
@="D:\\temp\\autologintest\\sshlogin.bat"
[HKEY_CLASSES_ROOT\myCrtshell\shell]
[HKEY_CLASSES_ROOT\myCrtshell\shell\open]
[HKEY_CLASSES_ROOT\myCrtshell\shell\open\command]
@="D:\\temp\\autologintest\\sshlogin.bat \"%1\""
```
### 2.Url协议注册到Windows注册表
`双击ProtocalReg.reg生效`
![在这里插入图片描述](https://img-blog.csdnimg.cn/da4f33aa7bca4010ac43ca4f143753c5.gif)
## 三、在html中编写js调用本地程序
注册表注册完后，可以通过html进行本地程序的调用了，新建一个index.html，然后在html中通过a标签进行Url协议调用，如下：
```c
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  </head>
    <body>
        <div>
            <a href="myCrtshell:hello/">autologintest</a>
        </div>
    </body>
</html>
```
`注：以上部分其中href="myCrtshell:hello/"为引入url协议进行调中，并带上"hello"的参数，你可以根据你的需要进行更改，此参数可以在应用程序中接收到.`
## 四、完整的springboot工程demo代码提供如下
github:  [https://github.com/jxlhljh/springbootCrttest.git](https://github.com/jxlhljh/springbootCrttest.git)
gitee:  [https://gitee.com/jxlhljh/springbootCrttest.git](https://gitee.com/jxlhljh/springbootCrttest.git)

>访问地址：http://localhost:8080/crttest/index.html
效果：![在这里插入图片描述](https://img-blog.csdnimg.cn/f2da27db046e47fd875ef7cc481bf448.gif)

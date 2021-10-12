:: @set /p name=username£º
:: @set /p pwd=password£º
 
set name="sendi"
set pwd="sendi@1234"
set ip="172.168.201.148"
set port="55314"
 
start "" "C:\software\SecureCRT\SecureCRT.exe" /SCRIPT "D:\D\liujinghua\LJHUA\myperl\src\sshlogin.vbs" /arg %name% /arg %pwd% /arg %ip% /arg %port%
:end
exit
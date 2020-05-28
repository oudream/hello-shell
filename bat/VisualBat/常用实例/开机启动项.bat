:自动把批处理文件加进开机启动项 
:1.
@echo off 
@copy %0 "%userprofile%\「开始」菜单\程序\启动" 
@del %0

:2.
@echo off
@copy %0 d:\autoexec.bat
@REG ADD HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /v autoexec.bat /t REG_SZ /d d:\autoexec.bat /f
@del %0
拷贝自身到其他路径
@echo off 
@copy %0 "%systemdrive%\" 将自身复制到系统磁盘
@copy %0 "%windir%\" 将自身复制到系统windows目录
@copy %0 "%windir%\system32\" 将自身复制到系统windows\system32目录


%ProgramFiles%=C:\Program Files
%SystemDrive%=C:
%SystemRoot%=C:\WINDOWS
%windir%=C:\WINDOWS
%TEMP%=C:\DOCUME~1\ADMINI~1\LOCALS~1\Temp
%TMP%=C:\DOCUME~1\ADMINI~1\LOCALS~1\Temp

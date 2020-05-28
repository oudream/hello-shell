@echo off
set CopyTo=D:\01Delphi\Delphi7
if /i "%CopyTo%" equ "" goto end
if not exist "%CopyTo%" goto end
echo %time% 请确认Delph 7路径：%CopyTo%
Pause
set CopyTo=%CopyTo%\
set CopyTo=%CopyTo:\\=\%
call :copyfile
call :install
call :deletefile
goto end

:copyfile
copy start.cmd            %CopyTo%start.cmd
copy default.reg          %CopyTo%default.reg
copy install.cmd          %CopyTo%install.cmd
copy mine\mine.cmd        %CopyTo%mine\mine.cmd
copy mine\BDE.reg         %CopyTo%mine\BDE.reg
copy mine\Editor.reg      %CopyTo%mine\Editor.reg
copy contron\contron.reg  %CopyTo%contron\contron.reg
copy contron\contron.cmd  %CopyTo%contron\contron.cmd
goto end

:install
cls
call %CopyTo%install.cmd
goto end

:deletefile
del %CopyTo%default.reg
del %CopyTo%install.cmd
del %CopyTo%mine\mine.cmd
del %CopyTo%mine\BDE.reg
del %CopyTo%mine\Editor.reg
del %CopyTo%contron\contron.reg
del %CopyTo%contron\contron.cmd
del /s %CopyTo%\*.rar >nul
goto end

:end

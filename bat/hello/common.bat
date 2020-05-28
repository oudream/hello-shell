

set sExecDisk=%~d0%
set sExecPath=%~dp0%\
set sExecPath=%sExecPath:\\=\%

echo "begin"

echo  "sExecPath="%sExecPath%

cd /d %sExecPath%

%~d0

@echo chdir sExecPath

set CYGWIN=tty notitle glob

set PATH=%PATH%;%sExecpath%bin;%~d0%sbin;d:\cygwin\usr\bin;d:\cygwin\usr\sbin;d:\cygwin\usr\local\bin

set LD_LIBRARY_PATH=d:\cygwin\lib;d:\cygwin\usr\lib;d:\cygwin\usr\local\lib

echo %PATH%

pause

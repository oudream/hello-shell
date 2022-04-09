
@echo off
title restart TcpClient

set BASE_DIR=%~dp0
%BASE_DIR:~0,2%

:again

tasklist|findstr /i "TcpClient.exe" > nul
if ERRORLEVEL 1 (
	echo TcpClient is off in %Date:~0,4%-%Date:~5,2%-%Date:~8,2% %Time:~0,2%:%Time:~3,2%
	start "" "TcpClient.exe"
)

cd /d %BASE_DIR%

choice /t 3 /d y /n > nul

goto again
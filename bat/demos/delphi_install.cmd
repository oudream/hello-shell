@echo off
set DelphiRoot=%~dp0%\
set DelphiRoot=%DelphiRoot:\\=\%

call :prefix
call :default
call :extend

echo %time% 安装完成，现在退出
pause

goto end

:prefix

if NOT EXIST "%DelphiRoot%default.reg" (
echo 默认注册表文件不存在，更新无法进行，现在退出
pause
exit
)

rem 删除注册文件
del "%USERPROFILE%"\.borland\*.* /q >nul
rd "%USERPROFILE%"\.borland >nul

echo %time% 删除注册表项...

echo REGEDIT4 >delreg.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Borland\DBD\7.0] >>delreg.reg
echo [-HKEY_CURRENT_USER\SOFTWARE\Borland\DBD\7.0] >>delreg.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Borland\Delphi\7.0] >>delreg.reg
echo [-HKEY_CURRENT_USER\SOFTWARE\Borland\Delphi\7.0] >>delreg.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Borland\BLW32] >>delreg.reg
echo [-HKEY_CURRENT_USER\SOFTWARE\Borland\BLW32] >>delreg.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Borland\Borland Shared] >>delreg.reg
echo [-HKEY_CURRENT_USER\SOFTWARE\Borland\Borland Shared] >>delreg.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Borland\Database Engine] >>delreg.reg
echo [-HKEY_CURRENT_USER\SOFTWARE\Borland\Database Engine] >>delreg.reg

reg import delreg.reg >nul
del delreg.reg

goto end

:default

echo *******************典型安装*************************

echo %time% 更新注册表...
reg import default.reg >nul

reg add HKLM\SOFTWARE\Borland\Delphi\7.0 /v "App" /d "%DelphiRoot%bin\Delphi32.exe" /f >nul
reg add HKLM\SOFTWARE\Borland\Delphi\7.0 /v "LocalSharedRoot" /d "%DelphiRoot%Borland Shared" /f >nul
reg add HKLM\SOFTWARE\Borland\Delphi\7.0 /v "RootDir" /d "%DelphiRoot%\" /f >nul
reg add "HKLM\SOFTWARE\Borland\Delphi\7.0\ActiveX Controls" /v "UnitDirName" /d "%DelphiRoot%Imports" /f >nul
reg add HKLM\SOFTWARE\Borland\Delphi\7.0\Help /v "WinHelpPath" /d "%DelphiRoot%Help" /f >nul
reg add HKLM\SOFTWARE\Borland\Delphi\7.0\OpenHelp /v "ProjectFile" /d "%DelphiRoot%Help\d7.ohp" /f >nul
reg add HKLM\SOFTWARE\Borland\Delphi\7.0\Transfer /v "Path0" /d "%DelphiRoot%Borland Shared\Database Desktop\dbd32.exe" /f >nul
reg add HKLM\SOFTWARE\Borland\Delphi\7.0\Transfer /v "Path1" /d "%DelphiRoot%Bin\imagedit.exe" /f >nul
reg add HKLM\SOFTWARE\Borland\Delphi\7.0\Transfer /v "Path2" /d "%DelphiRoot%Bin\pce.exe" /f >nul
reg add HKLM\SOFTWARE\Borland\Delphi\7.0\Transfer /v "Path3" /d "%DelphiRoot%Bin\xmlmapper.exe" /f >nul
reg add HKLM\SOFTWARE\Borland\Delphi\7.0\Transfer /v "WorkingDir0" /d "%DelphiRoot%Borland Shared\Database Desktop\\" /f >nul
reg add HKLM\SOFTWARE\Borland\Delphi\7.0\Transfer /v "WorkingDir1" /d "%DelphiRoot%Bin" /f >nul
reg add HKLM\SOFTWARE\Borland\Delphi\7.0\Transfer /v "WorkingDir2" /d "%DelphiRoot%Bin" /f >nul
reg add HKLM\SOFTWARE\Borland\Delphi\7.0\Transfer /v "WorkingDir3" /d "%DelphiRoot%Bin" /f >nul
rem Borland Shared
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Borland\Borland Shared" /v "SharedFilesDir" /d "%DelphiRoot%Borland Shared\\" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Borland\Borland Shared\Data" /v "UseCount" /d "1" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Borland\Borland Shared\Data" /v "RootDir" /d "%DelphiRoot%Borland Shared\Data" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Borland\Borland Shared\DBExpress" /v "DLLPATH" /d "%DelphiRoot%Borland Shared\DBExpress" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Borland\Borland Shared\Image Files" /v "UseCount" /d "1" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Borland\Borland Shared\Image Files" /v "RootDir" /d "%DelphiRoot%Borland Shared\Images" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Borland\Borland Shared\MSHelp" /v "UseCount" /d "1" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Borland\Borland Shared\MSHelp" /v "RootDir" /d "%DelphiRoot%Borland Shared\MSHelp" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Borland\Borland Shared\SampleDictionary" /v "UseCount" /d "1" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Borland\Borland Shared\SampleDictionary" /v "RootDir" /d "%DelphiRoot%Borland Shared\SampleDictionary" /f >nul

rem Rave报表不安装
rem reg add "HKLM\SOFTWARE\Borland\Delphi\7.0\Known Packages" /v "$(DELPHI)\bin\dclRave70.bpl" /d "(Untitled)" /f >nul
rem 多语言支持，出错，不安装
rem reg add "HKLM\SOFTWARE\Borland\Delphi\7.0\Known Packages" /v "$(DELPHI)\Bin\dclite70.bpl" /d "(Untitled)" /f >nul

echo %time% DCC命令行支持
  echo -aWinTypes=Windows;WinProcs=Windows;DbiProcs=BDE;DbiTypes=BDE;DbiErrs=BDE >%DelphiRoot%bin\dcc32.cfg
  echo -u"%DelphiRoot%lib";"%DelphiRoot%lib\Obj"  >>%DelphiRoot%bin\dcc32.cfg

echo %time% 调试支持...
if not exist "%DelphiRoot%bin\BORdbk70.dll" (
  echo 调试支持文件%DelphiRoot%bin\BORdbk70.dll不存在
) else (
  regsvr32 "%DelphiRoot%bin\BORdbk70.dll" /s
)

echo %time% 安装专家支持...
reg delete "HKLM\Software\Borland\Delphi\7.0\Experts" /f >nul

rem GExperts专家
if exist "%DelphiRoot%Extras\GExperts\GExpertsD7.dll" (
  echo %time% GExperts专家
  reg add "HKLM\Software\Borland\Delphi\7.0\Experts" /v "GExperts" /d "%DelphiRoot%Extras\GExperts\GExpertsD7.dll" /f >nul
)

rem DelphiSpeedUp专家
if exist "%DelphiRoot%Extras\DelphiSpeedUp\DelphiSpeedUp7.dll" (
  if exist "%DelphiRoot%Extras\DelphiSpeedUp\DelphiSpeedUpLoader7.bpl" (
    echo %time% DelphiSpeedUp专家
    reg add "HKLM\Software\Borland\Delphi\7.0\Experts" /v "DelphiSpeedUp" /d "%DelphiRoot%Extras\DelphiSpeedUp\DelphiSpeedUp7.dll" /f >nul
    reg add "HKLM\Software\Borland\Delphi\7.0\Known Packages" /v "$(DELPHI)\Extras\DelphiSpeedUp\DelphiSpeedUpLoader7.bpl" /d "DelphiSpeedUp Loader" /f >nul
  )
)

rem DDevExtensions专家
if exist "%DelphiRoot%Extras\DDevExtensions\DDevExtensions7.dll" (
  echo %time% DDevExtensions专家
  reg add "HKLM\Software\Borland\Delphi\7.0\Experts" /v "DDevExtensions" /d "%DelphiRoot%Extras\DDevExtensions\DDevExtensions7.dll" /f >nul
)

rem echo 桌面快捷方式...
rem SET link=%UserProfile%\桌面\我的Delphi7.url
rem ECHO [InternetShortcut]>"%link%"
rem ECHO URL=%DelphiRoot%Start.cmd>>"%link%"
rem ECHO WorkingDirectory=%DelphiRoot%Bin>>"%link%"
rem ECHO IconFile=%DelphiRoot%Bin\Delphi32.exe>>"%link%"
rem ECHO IconIndex=^0>>"%link%"

echo %time% 典型安装结束

goto end

:extend

  echo *******************扩展安装*************************

  set /P task="%time% 是否进行扩展安装，继续安装请按提示进行操作，请选择[Y/N]: "
  if /I "%task%"=="Y" (
    echo %time% 请等待Delphi 7启动，在启动后请手动结束Delphi 7...
    start %DelphiRoot%Bin\Delphi32.exe
    pause

    rem 检测是否已运行过delphi 7

setlocal ENABLEDELAYEDEXPANSION
    set foundflag=0
    for /f "usebackq" %%i in (`reg query hkcu\software`) do (
      if /i "%%i" equ "HKEY_CURRENT_USER\software\Borland" set foundflag=1
    )
    if !foundflag!==1 (
      set foundflag=0
      for /f "usebackq" %%i in (`reg query hkcu\software\borland`) do (
        if /i "%%i" equ "HKEY_CURRENT_USER\software\Borland\delphi" set foundflag=1
      )
      if !foundflag!==1 (
        set foundflag=0
        for /f "usebackq" %%i in (`reg query hkcu\software\borland\delphi`) do (
          if /i "%%i" equ "HKEY_CURRENT_USER\software\Borland\delphi\7.0" set foundflag=1
        )
      )
    )
    if !foundflag!==0 (
      echo Delphi 7未能正常启动，扩展安装结束
      pause
      goto end
    )
setlocal DISABLEDELAYEDEXPANSION

    call :contron
    call :mine
  )

goto end

:contron
  if exist "%DelphiRoot%contron\contron.cmd" call "%DelphiRoot%contron\contron.cmd" "%DelphiRoot%"
goto end

:mine
  if exist "%DelphiRoot%mine\mine.cmd" call "%DelphiRoot%mine\mine.cmd" "%DelphiRoot%"
goto end

:end
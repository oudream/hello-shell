@echo off
set MyPathRoot=%~dp0%\
set MyPathRoot=%MyPathRoot:\\=\%

echo %MyPathRoot%

call :processbefore
call :processing
call :processafter

echo %time% 起动完成，现在退出

#pause

goto end

:processbefore

rem 删除注册文件

echo %MyPathRoot%Data\Profile\parent.lock

del %MyPathRoot%Data\Profile\parent.lock

start %MyPathRoot%FirefoxPortable.exe

goto end


:processing

goto end


:processafter

goto end

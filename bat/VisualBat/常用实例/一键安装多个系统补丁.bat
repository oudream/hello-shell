@echo off
title 系统补丁批量自动安装
color 1f
cls
echo 补丁安装中......
echo.
for %%i in (*.exe) do %%i /passive /norestart /nobackup
echo 补丁已经全部安装完毕！
echo 请按任意键重启电脑！
echo ......
PAUSE >nul
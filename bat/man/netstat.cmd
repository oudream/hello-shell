
rem 查找所有运行的端口
netstat -ano

rem 查看被占用端口对应的 PID
netstat -aon | findstr "8081"

rem 结束进程
taskkill /T /F /PID 9088

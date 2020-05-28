@echo off 
set work_path=f:\Contron
REM f: 
REM cd %work_path% 
for /R %work_path% %%s in (.,*) do ( 
echo %%s 
) 
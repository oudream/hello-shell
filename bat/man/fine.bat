@echo off
echo 111 >test.txt 
echo 222 >>test.txt 
find "111" test.txt 
#del test.txt 
pause
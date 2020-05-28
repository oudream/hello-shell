ÐÞ¸ÄIEÊ×Ò³

@echo off
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /t reg_sz /d http://www.haokucn.com /f 
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Default_Page_URL" /t reg_sz /d http://www.haokucn.com /f
pause
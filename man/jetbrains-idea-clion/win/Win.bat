@echo off
SET GenFolder=jetbra
if not exist %GenFolder% (
		echo "必须需要解压后运行"
		pause
    ) else (
		start ./jetbra/scripts/install.vbs	
    )
@echo off
SET GenFolder=jetbra
if not exist %GenFolder% (
		echo "������Ҫ��ѹ������"
		pause
    ) else (
		start ./jetbra/scripts/install.vbs	
    )
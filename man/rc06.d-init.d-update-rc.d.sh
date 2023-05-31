sudo mv /path/to/script.sh /etc/init.d/
sudo chmod +x /etc/init.d/script.sh
sudo update-rc.d script.sh defaults
sudo update-rc.d script.sh start 99 2 3 4 5 .


update-rc.d -f S99_start_detached remove
update-rc.d S99_start_detached defaults
sudo update-rc.d S99_start_detached 99 2 3 4 5 .



#!bin/bash

path_updater=/usr/src/pi-updater/
path_workspace=/home/pi/workspace/

# generate update_log.txt file at workspace folder
sudo touch ${path_workspace}.update_log
sudo chmod 666 ${path_workspace}.update_log

# check wifi connection and return boolean
check_wifi()
{
	tmp=`iwconfig wlan0|grep ESSID:off`
	num="${#tmp}" 
	if [ $num = "0" ]; then
		wlan=true
	else
		wlan=false
	fi
	echo $wlan
}

# check local updater version compare with latest github version 
check_version()
{
	ver_latest=`curl https://raw.githubusercontent.com/wsy8029/pi-updater/master/version`
	ver_local=$(<version)	
	if [ $ver_latest == $ver_local ]; then
		latest=true
	else
		latest=false
	fi
	echo $latest
}


# save log with time
logger()
{
	msg=$1
	sudo echo -e `date`: $msg >> ${path_workspace}.update_log 
}

# update config and code when wlan is true
while [ true ]; do

	wlan=$(check_wifi)
	if [ $wlan = true ]; then
		sudo python3 ${path_updater}led/on_blue.py
		$(logger "[WIFI] wifi enable")
		sudo /bin/bash ${path_updater}update_config.sh
		$(logger "[UPDATE] config updated")
		sudo /bin/bash ${path_updater}update_code.sh 
		$(logger "[UPDATE] code updated")
		$(logger "[UPDATE] Updated latest version" )
		sudo python3 ${path_updater}led/blink_rgb1.py
		break
	else
		$(logger "[WIFI] wifi disable, trying to connect wifi...")
		sudo /bin/cp -f ${path_updater}wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
		sudo wpa_cli -i wlan0 reconfigure
		sudo ifconfig wlan0 down
		sudo ifconfig wlan0 up
		sudo python3 ${path_updater}led/on_yellow.py
		sleep 5	
		sudo python3 ${path_updater}led/off.py
		sleep 1
	fi
done
echo "Updadte Complete"

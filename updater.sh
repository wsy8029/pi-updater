#!bin/bash

path=/home/pi/
# generate update_log.txt file at workspace folder
sudo touch /home/pi/workspace/update_log.txt
sudo chmod 666 /home/pi/workspace/update_log.txt

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
		echo dd > ${path}same
	else
		echo dd > diff
	fi
}


# save log with time
logger()
{
	msg=$1
	sudo echo -e `date`: $msg >> /home/pi/workspace/update_log.txt 
}
$(check_version)
# update config and code when wlan is true
while [ true ]; do

	wlan=$(check_wifi)
	if [ $wlan = true ]; then
		sudo python3 /home/pi/pi-updater/led/on_blue.py
		$(logger "wifi enable")
		sudo /bin/bash /home/pi/pi-updater/update_config.sh
		$(logger "config updated")
		sudo /bin/bash /home/pi/pi-updater/update_code.sh 
		$(logger "code updated")
		$(logger "Updated latest version" )
		sudo python3 /home/pi/pi-updater/led/blink_rgb1.py
		break
	else
		#$(logger "wifi disable, enter wifi connection loop")
		echo "try to connect wifi..."
		sudo python3 /home/pi/pi-updater/led/blink_yellow1.py
		sleep 2 
	fi
done
echo "Updadte Complete"

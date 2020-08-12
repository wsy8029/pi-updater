#!bin/bash

#generate update_log.txt file at workspace folder
sudo touch /home/pi/workspace/update_log.txt
sudo chmod 666 /home/pi/workspace/update_log.txt

#check wifi connection and return boolean
check_wifi()
{
	tmp=`iwconfig wlan0|grep ESSID:off`
	num="${#tmp}" 
	if [ $num = "0" ]
	then
	wlan=true
	else
	wlan=false
	fi
	echo $wlan
}

#save log with time
logger()
{
	msg=$1
	sudo echo -e `date`: $msg >> /home/pi/workspace/update_log.txt 
}

#update config and code when wlan is true
while [ true ]; do

	wlan=$(check_wifi)
	if [ $wlan = true ]; then
		$(logger "wifi enable")
		sudo /bin/bash ./update_config.sh
		$(logger "config updated")
		sudo /bin/bash ./update_code.sh 
		$(logger "code updated")
		$(logger "Updated latest version" )
		break
	else
		#$(logger "wifi disable, enter wifi connection loop")
		echo "try to connect wifi..."
		sleep 3
	fi
done
echo "Updadte Complete"

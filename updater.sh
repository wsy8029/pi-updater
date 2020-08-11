#!bin/bash

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
wlan=$(check_wifi)
echo $wlan

#update config and code when wlan is true
if [ $wlan = true ]
then
echo TRUE
sudo /bin/bash ./update_config.sh
sudo /bin/bash ./update_code.sh 
else
echo FALSE
echo NETWORK NOT AVAILABLE
fi



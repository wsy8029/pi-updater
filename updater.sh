#!bin/bash
tmp=`iwconfig wlan0|grep ESSID:off`
num="${#tmp}" 
if [ $num = "0" ]
then
wlan=true
else
wlan=false
fi
echo $wlan

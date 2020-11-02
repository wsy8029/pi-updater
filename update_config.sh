#!/bin/bash
echo update configuration

path_updater=/usr/src/pi-updater/
path_workspace=/home/pi/workspace/

# save log with time
logger()
{
	msg=$1
	sudo echo -e `date`: $msg >> ${path_workspace}.update_log
}
$(logger "[CONFIG] Checking config update...")
#$(logger "[VERSION] cannot get latest version, retry...")

# ========== update code below ==========
mkdir ${path_workspace}updater_test_dir
$(logger "[CONFIG] mkdir complete")
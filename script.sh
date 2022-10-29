#!/bin/bash

function wait () {
	echo "should we continue? (y|n)"
	read -r user_input
	if [ $user_input == 'y' ]
	then
		echo "continuing..."
	else
		echo "exiting..."
		exit 0
	fi
}
function should () {
	echo "should I "$1" (y|n)"
	read -r user_input
	if [ $user_input == 'y' ]
	then
		$1
	else
		echo "skipping..."
	fi
}

function update_and_upgrade () {
	apt-get update
	apt-get upgrade
}
function edit_lightdm () {
	status = which lightdm	
	echo "allow-guest=false" >> /etc/lightdm/lightdm.conf
}
function enable_ufw_firewall () {
	apt-get install ufw
	ufw enable
	ufw status
}
function enable_clamtk () {
	apt-get install clamtk
	freshclam
}


should update_and_upgrade
should edit_lightdm
should enable_ufw_firewall
should enable_clamtk

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
should update_and_upgrade
#clamtk seems borked, or im just an idiot
#apt-get install clamtk
#freshclam
apt-get install ufw
#ufw enable
ufw status
wait

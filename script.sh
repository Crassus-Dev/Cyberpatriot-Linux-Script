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
	echo "should I \"$1\" (y|n)"
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
function check_dir {
  if [ -d "$1" ]
  then
    echo "$2"
    wait
  else
    echo "dir $2 not found"
  fi
}
function edit_lightdm () {
	# Did you mean to use it?
	status = which lightdm
	
	# 1) Supposedly configs can also be here too:
	# /usr/share/lightdm/lightdm.conf.d/*.conf
	# /etc/lightdm/lightdm.conf.d/*.conf
	# At least warn about these and handle manaully
	dir=/tmp/etc/lightdm/lightdm.conf.d
	check_dir "$dir" "Check lightdm configs in $dir"

	dir=/tmp/usr/share/lightdm/lightdm.conf.d
	check_dir "$dir" "Check lightdm configs in $dir"
	
	# 2) What if there is already an entry of 'allow-guest=true' or 'allow-guest=false' ?
	file=./etc/lightdm/lightdm.conf
	allow_guest_exists=`grep "allow-guest" "$file"`
	if [ ! -z "$allow_guest_exists" ]
	then
		# Update file replacing the matched allow-guest config parameter
  		sed -i '' 's/allow-guest.*$/allow-guest=false/' "$file"
  		echo "Updated $file"
	else
		echo "allow-guest=false" >> /etc/lightdm/lightdm.conf
	fi
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

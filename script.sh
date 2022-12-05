#!/bin/bash

function wait () {
	echo "should we continue? (y|n)"
	read -r user_input
	if [ "$user_input" == 'y' ]
	then
		echo "continuing..."
	else
		echo -e "\e[1;42m Exiting... \e[0m"
		exit 0
	fi
}
function should () {
	echo "should I \"$1\" (y|n|e)"
	read -r user_input
	if [ "$user_input" == 'y' ]
	then
		$1
		status
	elif [ $user_input == 'n' ]
	then
		echo -e "\e[1;43m Skipping... \e[0m"
	else
		echo -e "\e[1;42m Exiting... \e[0m"
		exit 0
	fi
}
function status () {
	if [ "$?" = '0' ]
	then
		echo -e "\e[1;42m Success \e[0m"
	else
		echo -e "\e[1;41m Failure \e[0m"
	fi
}
function update_and_upgrade () {
	sudo apt-get update && sudo apt-get -y upgrade
}
function check_dir () {
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
	dir=/etc/lightdm/lightdm.conf.d
	check_dir "$dir" "Check lightdm configs in $dir"

	dir=/usr/share/lightdm/lightdm.conf.d
	check_dir "$dir" "Check lightdm configs in $dir"
	
	# 2) What if there is already an entry of 'allow-guest=true' or 'allow-guest=false' ?
	file=/etc/lightdm/lightdm.conf
	allow_guest_exists=`grep "allow-guest" "$file"`
	if [ ! -z "$allow_guest_exists" ]
	then
		# Update file replacing the matched allow-guest config parameter
  		sed -i 's/allow-guest.*$/allow-guest=false/' "$file"
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
function search_for_prohibited_files () {
	
	rm possible_prohibited_files.txt

	printf "\nPossible prohibited images:\n\n" >> possible_prohibited_files.txt

	find / -type f -name "*.jpg" >> possible_prohibited_files.txt
	find / -type f -name "*.jpeg" >> possible_prohibited_files.txt
	find / -type f -name "*.gif" >> possible_prohibited_files.txt
	find / -type f -name "*.png" >> possible_prohibited_files.txt
	find / -type f -name "*.bmp" >> possible_prohibited_files.txt

	printf "\nPossible prohibited videos:\n\n" >> possible_prohibited_files.txt

	find / -type f -name "*.mp4" >> possible_prohibited_files.txt
	find / -type f -name "*.mov" >> possible_prohibited_files.txt
	find / -type f -name "*.wmv" >> possible_prohibited_files.txt
	find / -type f -name "*.avi" >> possible_prohibited_files.txt
	find / -type f -name "*.mkv" >> possible_prohibited_files.txt

	printf "\nPossible prohibited music files:\n\n" >> possible_prohibited_files.txt

	find / -type f -name "*.mp3" >> possible_prohibited_files.txt
	find / -type f -name "*.aac" >> possible_prohibited_files.txt
	find / -type f -name "*.flac" >> possible_prohibited_files.txt
	find / -type f -name "*.alac" >> possible_prohibited_files.txt
	find / -type f -name "*.wav" >> possible_prohibited_files.txt
}
should update_and_upgrade
should edit_lightdm
should enable_ufw_firewall
should enable_clamtk
should search_for_prohibited_files

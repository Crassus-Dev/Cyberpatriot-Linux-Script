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
	elif [ "$user_input" == 'n' ]
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
function check_dir () {
	if [ -d "$1" ]
	then
		echo "$2"
		wait
	else
		echo "dir $2 not found"
	fi
}
# Function to source and run all files from a folder
source_files() {
  # Get the directory path of the script
  script_dir=$(dirname "$0")
  folder_path="$script_dir/functions"

  # Iterate over files in the folder
  for file in "$folder_path"/*.sh; do
    if [[ -f "$file" ]]; then
      source "$file"
    fi
  done
}

if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

source_files
should install_dependencies
should update_and_upgrade
should edit_lightdm
should enable_ufw_firewall
should enable_clamtk
should search_for_prohibited_files
should change_passwords
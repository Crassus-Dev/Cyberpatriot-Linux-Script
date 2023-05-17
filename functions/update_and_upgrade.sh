function update_and_upgrade () {
	apt-get update
	apt-get -y upgrade
	apt-get -y dist-upgrade
}
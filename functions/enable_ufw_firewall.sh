function enable_ufw_firewall () {
	apt-get install ufw
	ufw enable
	ufw status
}
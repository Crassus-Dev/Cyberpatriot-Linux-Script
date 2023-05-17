function enable_ufw_firewall () {
	apt-get install ufw
	ufw default deny incoming
	ufw default allow outgoing
	ufw allow ssh
	ufw allow http
	ufw allow https
	ufw logging on
	ufw logging high
	ufw enable
	ufw status
}
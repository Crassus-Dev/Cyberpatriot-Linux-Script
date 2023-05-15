function change_passwords () {
	new_password="Cyb3rPatr!0t$"
	users=$(cat /etc/passwd | cut -d ":" -f1)
	for user in $users
	do
	usermod --password $(echo $new_password | openssl passwd -1 -stdin) $user
	echo "Changed password for user $user"
	done
}
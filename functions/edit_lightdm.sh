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
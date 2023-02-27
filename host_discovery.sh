# Host discovery script 
# Depends on: ipcalc ip nmap


# Prints default gateway as a string 
# by getting the route to Cloudflare's DNS server
get_gateway() {
	echo $(ip route get 1.1.1.1 | awk '{print $3}') 
}


gateway=$(get_gateway) 

# Filters IPCalc output to locate the subnet mask
get_subnet_mask() {

	ipcalc $gateway | grep Netmask | awk '{print$4}'
}


subnet=$(get_subnet_mask)

# Performs a nmap network scan to discover hosts
nmap $gateway/$subnet

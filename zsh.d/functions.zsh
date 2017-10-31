# l(ist)ips Get local and WAN IP adddresses
# Updated based on comments from Keith Rollin and Daniel Whicker
# $ lips
#    Local IP: 10.0.1.4
# External IP: 41.32.11.102
lips() {
	  local interface ip
	  for interface in $(networksetup -listallhardwareports | awk '/^Device: /{print $2}'); do
		    ip=$(ipconfig getifaddr $interface)
		    [ "$ip" != "" ] && break
	  done

	  local locip extip

	  [ "$ip" != "" ] && locip=$ip || locip="inactive"

	  ip=`dig +short myip.opendns.com @resolver1.opendns.com`
	  [ "$ip" != "" ] && extip=$ip || extip="inactive"

	  printf '%11s: %s\n%11s: %s\n' "Local IP" $locip "External IP" $extip
}

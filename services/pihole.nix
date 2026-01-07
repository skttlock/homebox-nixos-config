# pihole.nix
# imported by ./services.nix
_: {
	virtualisation.oci-containers.containers.pihole = {
		image = "pihole/pihole:latest";
		ports = [
			"53:53/tcp"
			"53:53/udp"
			"8080:80/tcp"			# web interface on port 8080
		];
		environment = {
			TZ = "America/Los_Angeles";	# change as needed
			WEBPASSWORD = "pihole2432";	# set admin password
		};
		volumes = [
			"/var/lib/pihole/etc-pihole:/etc/pihole"
			"/var/lib/pihole/etc-dnsmasq.d:/etc/dnsmasq.d"
		];
		extraOptions = [
			"--cap-add=NET_ADMIN"		# required for DHCP
		];
	};	

	systemd.tmpfiles.rules = [
		"d /var/lib/pihole 0755 root root -"
		"d /var/lib/pihole/etc-pihole 0755 root root -"
		"d /var/lib/pihole/etc-dnsmasq.d 0755 root root -"
	];
}

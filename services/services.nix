# services.nix
# imported by ../configuration.nix
_: {
	imports = [
		./ssh.nix
		./pihole/pihole.nix
		./traefik.nix
		./dashy/dashy.nix
		./filebrowser.nix
		# ./cryptpad.nix
		# ./nextcloud.nix
		# ./immich.nix
	];

}

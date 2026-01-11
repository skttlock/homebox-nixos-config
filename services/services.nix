# services.nix
# imported by ../configuration.nix
_: {
	imports = [
		./ssh.nix
		./pihole.nix
		./traefik.nix
		./dashy/dashy.nix
		# ./cryptpad.nix
		# ./nextcloud.nix
		# ./immich.nix
	];

}

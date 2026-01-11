# dashy.nix
# imported by ../services.nix
_: {
	systemd.tmpfiles.rules = [
		"d /var/lib/dashy 0755 root root -"
		"L+ /var/lib/dashy/config.yml - - - - ${./config.yml}"
	];

	virtualisation.oci-containers.containers.dashy = {
		image = "lissy93/dashy:latest";
		ports = [
			"8082:8080"
		];
		volumes = [
			"/var/lib/dashy/config.yml:/app/user-data/conf.yml"
		];
		environment = {
			TZ = "America/Los_Angeles";	# change as needed
			NODE_ENV = "production";
			UID = "1000";
			GID = "100";
		};
		labels = {
			"traefik.enable" = "true";
			"traefik.http.routers.dashy.rule" = "Host(`dashy.home.arpa`)";
			"traefik.http.routers.dashy.entrypoints" = "web";
			"traefik.http.services.dashy.loadbalancer.server.port" = "8082";
		};
		extraOptions = [
			"--network=web"
		];
	};
}

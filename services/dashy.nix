# dashy.nix
# imported by ./services.nix
_: {
	virtualisation.oci-containers.containers.dashy = {
		image = "lissy93/dashy:latest";
		# ports = [
			# empty, route via Traefik
		# ];
		# volumes = [
		# 	"/var/lib/dashy/config.yml:/app/user-data/conf.yml"
		# ];
		environment = {
			TZ = "America/Los_Angeles";	# change as needed
			NODE_ENV = "production";
			UID = "1000";
			GID = "100";
		};
		labels = {
			"traefik.enable" = "true";

			"traefik.http.routers.dashy.rule" = "Host(`dashy.home`)";
			"traefik.http.routers.dashy.entrypoints" = "web";

			"traefik.http.services.dashy.loadbalancer.server.port" = "80";
		};
		extraOptions = [
			"--network=web"
		];
	};
}

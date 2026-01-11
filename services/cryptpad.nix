# cryptpad.nix
# imported by ./services.nix
_: 
{
	virtualisation.oci-containers.containers.cryptpad = {
		image = "cryptpad/cryptpad:latest";
		environment = {
			CPAD_CONF = "/cryptpad/config/config.js";
			CPAD_MAIN_DOMAIN = "http://cryptpad.home.arpa";
			CPAD_SANDBOX_DOMAIN = "http://sandbox-cryptpad.home.arpa";
			CPAD_HTTP_UNSAFE_ORIGIN = "http://cryptpad.home.arpa";
			CPAD_HTTP_UNSAFE_SANDBOX = "http://sandbox-cryptpad.home.arpa";
			CPAD_INSTALL_ONLYOFFICE = "no";
		};
		volumes = [
			"/mnt/storage/srv/cryptpad/blob:/cryptpad/blob"
			"/mnt/storage/srv/cryptpad/block:/cryptpad/block"
			"/mnt/storage/srv/cryptpad/data:/cryptpad/data"
			"/mnt/storage/srv/cryptpad/datastore:/cryptpad/datastore"
		];
		extraOptions = [
			"--network=web"
			"--label=traefik.enable=true"

			# Main domain routing
			"--label=traefik.http.routers.cryptpad.rule=Host(`cryptpad.home.arpa`)"
			"--label=traefik.http.routers.cryptpad.entrypoints=web"
			"--label=traefik.http.routers.cryptpad.service=cryptpad"
			"--label=traefik.http.services.cryptpad.loadbalancer.server.port=3000"

			# Sandbox domain routing
			"--label=traefik.http.routers.cryptpad-sandbox.rule=Host(`sandbox-cryptpad.home.arpa`)"
			"--label=traefik.http.routers.cryptpad-sandbox.entrypoints=web"
			"--label=traefik.http.routers.cryptpad-sandbox.service=cryptpad"

			# Headers middleware
			"--label=traefik.http.middlewares.cryptpad-headers.headers.customrequestheaders.X-Forwarded-Proto=http"
			"--label=traefik.http.routers.cryptpad.middlewares=cryptpad-headers"
			"--label=traefik.http.routers.cryptpad-sandbox.middlewares=cryptpad-headers"
		];
		dependsOn = [ "traefik" ];
	};

	# Create persistent directories with correct permissions
	systemd.tmpfiles.rules = [
		"d /mnt/storage/srv/cryptpad 0755 root root -"
		"d /mnt/storage/srv/cryptpad/blob 0755 4001 4001 -"
		"d /mnt/storage/srv/cryptpad/block 0755 4001 4001 -"
		"d /mnt/storage/srv/cryptpad/data 0755 4001 4001 -"
		"d /mnt/storage/srv/cryptpad/datastore 0755 4001 4001 -"
	];
}

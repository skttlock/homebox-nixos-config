# traefik.nix
# imported by ./services.nix
{ pkgs, ...}:

{
	virtualisation.oci-containers.containers.traefik = {
		image = "traefik:v2.10";
		ports = [
			"80:80"
			"8081:8080"
		];
		volumes = [
			"/var/run/docker.sock:/var/run/docker.sock:ro"
		];
		cmd = [
			"--api.insecure=true"
			"--providers.docker=true"
			"--providers.docker.exposedbydefault=false"
			"--entrypoints.web.address=:80"
			"--log.level=INFO"
		];
		extraOptions = [
			"--network=web"
		];
	};

	systemd.services.docker-network-web = {
		description = "Create Docker Network for Traefik";
		after = [ "docker.service" ];
		wantedBy = [ "multi-user.target" ];
		serviceConfig = {
			Type = "oneshot";
			RemainAfterExit = true;
			ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.docker}/bin/docker network create web || exit 0'";
			ExecStop = "${pkgs.bash}/bin/bash -c '${pkgs.docker}/bin/docker network rm web || exit 0'";
		};
	};
}

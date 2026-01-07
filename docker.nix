# docker.nix
# imported by ./configuration.nix
_: {
	# enable Docker
	virtualisation = {
		docker.enable = true;
		oci-containers.backend = "docker";
	};
}

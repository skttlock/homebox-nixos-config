# filesystem.nix
# configures and mounts the servers storage SSD.
# imported by ./configuration.nix
_s: {
	fileSystems."/mnt/storage" = {
		device = "/dev/disk/by-uuid/c5779ff6-ecbd-40df-a276-83ab12665f71";
		fsType = "ext4";
		#options = [];
	};
}

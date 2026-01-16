# services/filebrowser.nix
# imported by ./services.nix
_: {
  systemd.tmpfiles.rules = [
    "d /mnt/storage/user-files 0755 1000 1000 -"
    "d /var/lib/filebrowser 0755 1000 1000 -"
  ];

  virtualisation.oci-containers.containers.filebrowser = {
    image = "filebrowser/filebrowser:latest";
    volumes = [
      "/mnt/storage/user-files:/srv"
      "/var/lib/filebrowser/database.db:/database.db"
    ];
    environment = {
      PUID = "1000";
      PGID = "1000";
    };
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.filebrowser.rule" = "Host(`files.home.arpa`)";
      "traefik.http.routers.filebrowser.entrypoints" = "web";
      "traefik.http.services.filebrowser.loadbalancer.server.port" = "80";
    };
    extraOptions = [
      "--network=web"
    ];
  };
}

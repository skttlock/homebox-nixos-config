# nextcloud.nix
# imported by ./services.nix
{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    hostName = "nextcloud.local";
    https = false;
    
    config = {
      adminuser = "admin";
      adminpassFile = "/var/lib/nextcloud/admin-pass";

      dbtype = "pgsql";
      dbname = "nextcloud";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql";
    };
    
    home = "/mnt/storage/nextcloud";
  };
  
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [{
      name = "nextcloud";
      ensureDBOwnership = true;
    }];
  };
  
  systemd.tmpfiles.rules = [
    "d /mnt/storage/nextcloud 0750 nextcloud nextcloud -"
    "f /var/lib/nextcloud/admin-pass 0600 nextcloud nextcloud - testpassword"
  ];
  
  networking.firewall.allowedTCPPorts = [ 80 ];
}

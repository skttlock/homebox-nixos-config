# ssh.nix
{ ... }:

{
	  # Enable the OpenSSH daemon.
	services.openssh.enable = true;
}

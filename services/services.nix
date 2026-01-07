# services.nix
# imported by ../configuration.nix
{ ... }:

{
	imports = [
		./ssh.nix
		./pihole.nix
		#./cryptpad.nix
	];

}

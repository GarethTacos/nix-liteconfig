{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }@attrs: {
	nixosConfigurations.stupidfortress = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		specialArgs = attrs;
		modules = [ ./configuration.nix ];
	};

  };
}

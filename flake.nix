{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@attrs: {
	nixosConfigurations.holopockylab = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		specialArgs = attrs;
		modules = [ ./configuration.nix ];
	};

  };
}



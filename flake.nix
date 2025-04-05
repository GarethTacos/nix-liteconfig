{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-conf-editor = { url = "github:snowfallorg/nixos-conf-editor"; };

  };

  outputs = { self, nixpkgs, nixos-conf-editor, ... }@attrs: {
	nixosConfigurations.stupidfortress = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		specialArgs = attrs;
		modules = [ ./configuration.nix ];
	};

  };
}

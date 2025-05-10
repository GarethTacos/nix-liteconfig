{
  description = "NixOS configuration with custom Zen kernel override";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }: {
    # Build the NixOS system using the stable channel
    nixosConfigurations.holopockylab = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix  # Your base configuration module

        # Inline module to override the Zen kernel
        ({ lib, pkgs, ... }: {
          boot.kernelPackages = let
            version = "6.14.5";  # desired Zen kernel version
            suffix = "lqx1";     # suffix for Zen kernel branch
          in pkgs.linuxPackagesFor (pkgs.linux_zen.override {
            inherit version suffix;
            modDirVersion = lib.versions.pad 3 "${version}-${suffix}";
            src = pkgs.fetchFromGitHub {
              owner = "zen-kernel";
              repo = "zen-kernel";
              rev = "v${version}-${suffix}";
              sha256 = "13m820wggf6pkp351w06mdn2lfcwbn08ydwksyxilqb88vmr0lpq";
            };
          });
        })
      ];
    };
  };
}


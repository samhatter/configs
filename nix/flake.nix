{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-fork.url = "github:samhatter/nixpkgs?ref=adding-StartupWMClass-to-plex-desktop";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    nixpkgs-fork,
    sops-nix,
    ...
  }: {
    nixosConfigurations = {
      snapcaster = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit nixpkgs-fork;
        };
        modules = [
          sops-nix.nixosModules.sops
          ./hosts/snapcaster/configuration.nix
        ];
      };
    };
    nixosConfigurations = {
      tarmogoyf = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit nixpkgs-fork;
        };
        modules = [
          sops-nix.nixosModules.sops
          ./hosts/tarmogoyf/configuration.nix
        ];
      };
    };
  };
}


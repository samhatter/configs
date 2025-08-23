{
    description = "NixOS Config";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.11";
        sops-nix.url = "github:Mic92/sops-nix";
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, sops-nix, ... }:
    {
        nixosConfigurations = {
            snapcaster = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./nix/hosts/snapcaster/configuration.nix
                    sops-nix.nixosModules.sops
                    home-manager.nixosModules.home-manager
                    { home-manager.sharedModules = [ sops-nix.homeManagerModules.sops ]; }
                ];
            };
        };
    };
}
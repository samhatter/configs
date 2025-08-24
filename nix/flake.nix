{
    description = "NixOS Config";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        sops-nix.url = "github:Mic92/sops-nix";
        sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, sops-nix, ... }:
    {
        nixosConfigurations = {
            snapcaster = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";

                modules = [
                    sops-nix.nixosModules.sops
                    ./hosts/snapcaster/configuration.nix
                ];
            };
        };
    };
}
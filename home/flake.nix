{
    description = "Home Manager flake";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
        home-manager.url = "github:nix-community/home-manager/release-24.11";
        sops-nix.url = "github:Mic92/sops-nix";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, sops-nix, ... }:
    {
        homeConfigurations = {
            samantha = home-manager.lib.homeManagerConfiguration {
                pkgs = import nixpkgs { system = "x86_64-linux"; };
                modules = [
                    sops-nix.homeManagerModules.sops
                    ./samantha/home.nix
                ];
            };
        };
    };
}
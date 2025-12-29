{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-fork.url = "github:samhatter/nixpkgs?ref=sammy-dev";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-fork, sops-nix, nixos-wsl, ... }: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

    nixosConfigurations = {
      snapcaster = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixpkgs-fork; };
        modules =
          [ sops-nix.nixosModules.sops ./hosts/snapcaster/configuration.nix ];
      };
    };

    nixosConfigurations = {
      tarmogoyf = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixpkgs-fork; };
        modules =
          [ sops-nix.nixosModules.sops ./hosts/tarmogoyf/configuration.nix ];
      };
    };

    nixosConfigurations = {
      twin = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixpkgs-fork; };
        modules = [ sops-nix.nixosModules.sops ./hosts/twin/configuration.nix ];
      };
    };

    nixosConfigurations = {
      scapeshift = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixpkgs-fork; };
        modules = [
          nixos-wsl.nixosModules.default
          sops-nix.nixosModules.sops
          ./hosts/scapeshift/configuration.nix
        ];
      };
    };

    nixosConfigurations = {
      arcanis = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nixpkgs-fork; };
        modules = [
          nixos-wsl.nixosModules.default
          sops-nix.nixosModules.sops
          ./hosts/arcanis/configuration.nix
        ];
      };
    };
  };
}


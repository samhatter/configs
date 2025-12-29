{
  description = "Home Manager flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-fork.url = "github:samhatter/nixpkgs?ref=sammy-dev";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    sops-nix.url = "github:Mic92/sops-nix";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    nixpkgs-fork,
    home-manager,
    sops-nix,
    ...
  }: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    homeConfigurations."samantha@snapcaster" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {system = "x86_64-linux";};
      extraSpecialArgs = {
        hostName = "snapcaster";
        inherit nixpkgs-fork;
      };
      modules = [
        sops-nix.homeManagerModules.sops
        ./samantha/hosts/snapcaster.nix
      ];
    };

    homeConfigurations."samantha@tarmogoyf" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {system = "x86_64-linux";};
      extraSpecialArgs = {
        hostName = "tarmogoyf";
        inherit nixpkgs-fork;
      };
      modules = [
        sops-nix.homeManagerModules.sops
        ./samantha/hosts/tarmogoyf.nix
      ];
    };

    homeConfigurations."samantha@twin" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {system = "x86_64-linux";};
      extraSpecialArgs = {
        hostName = "twin";
        inherit nixpkgs-fork;
      };
      modules = [
        sops-nix.homeManagerModules.sops
        ./samantha/hosts/twin.nix
      ];
    };

    homeConfigurations."samantha@scapeshift" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {system = "x86_64-linux";};
      extraSpecialArgs = {
        hostName = "scapeshift";
        inherit nixpkgs-fork;
      };
      modules = [
        sops-nix.homeManagerModules.sops
        ./samantha/hosts/scapeshift.nix
      ];
    };

    homeConfigurations."samantha@arcanis" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {system = "x86_64-linux";};
      extraSpecialArgs = {
        hostName = "arcanis";
        inherit nixpkgs-fork;
      };
      modules = [
        sops-nix.homeManagerModules.sops
        ./samantha/hosts/arcanis.nix
      ];
    };
  };
}

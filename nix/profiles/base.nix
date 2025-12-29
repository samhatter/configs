{ config, pkgs, lib, ... }:

{
  networking.useDHCP = lib.mkDefault true;

  time.timeZone = "America/Los_Angeles";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      sandbox = true;
      auto-optimise-store = true;
      trusted-users = [ "root" "@wheel" ];
      warn-dirty = false;
    };
  };

  environment.systemPackages = with pkgs; [
    gitFull
    vim
    less
    wget
    curl
    htop
    jq
    home-manager
    sops
    fish
  ];

  users.mutableUsers = false;
  security.sudo.enable = true;

  services.journald.extraConfig = ''
    systemMaxIse=500M
  '';

  programs.bash.completion.enable = true;
  programs.zsh.enable = true;
}

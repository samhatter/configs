{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../profiles/base.nix
    ../../users/samantha.nix
    ./modules/caddy.nix
  ];

  networking.hostName = "arcanis";
  networking.networkmanager.enable = true;

  services.getty.autologinUser = "samantha";

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva
      libva-utils
      mesa
    ];
  };

  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        experimental = true;
        metrics-addr = "0.0.0.0:9323";
      };
    };
  };

  networking.firewall.enable = false;

  fileSystems."/storage" = {
    device = "/dev/pool/storage";
    fsType = "ext4";
  };

  programs.nix-ld.enable = true;

  system.stateVersion = "23.11";
}

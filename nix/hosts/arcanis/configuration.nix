{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../profiles/base.nix
    ../../users/samantha.nix
    ./modules/k3s.nix
    ./modules/firewall.nix
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

  fileSystems."/storage" = {
    device = "/dev/pool/storage";
    fsType = "ext4";
  };

  programs.nix-ld.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  users.users.samantha.extraGroups = ["docker"];

  system.stateVersion = "23.11";
}

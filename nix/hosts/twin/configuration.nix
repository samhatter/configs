{ pkgs, ... }: {
  networking.hostName = "twin";
  networking.firewall.enable = false;

  imports = [
    ../../profiles/base.nix
    ../../profiles/workstation.nix
    ../../users/samantha.nix
    ./hardware-configuration.nix
  ];


  security.pam.services = { sudo.fprintAuth = false; };

  services.power-profiles-daemon.enable = false;

  services.hardware.bolt.enable = true;

  system.stateVersion = "24.05";
}

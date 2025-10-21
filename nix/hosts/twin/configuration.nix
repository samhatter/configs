{pkgs, ...}: {
  networking.hostName = "snapcaster";
  networking.firewall.enable = false;

  imports = [
    ../../profiles/base.nix
    ../../profiles/workstation.nix
    ../../users/samantha.nix
    ./hardware-configuration.nix
  ];

  sops.age.keyFile = "/var/lib/sops-nix/keys.txt";

  security.pam.services = {
    sudo.fprintAuth = false;
  };

  services.power-profiles-daemon.enable = false;

  services.hardware.bolt.enable = true;

  system.stateVersion = "24.05";
}

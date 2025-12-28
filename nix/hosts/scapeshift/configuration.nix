{pkgs, config, ...}: {
  networking.hostName = "scapeshift";
  networking.firewall.enable = false;

  imports = [
    ../../profiles/base.nix
    ../../profiles/wsl.nix
    ../../users/samantha.nix
  ];

  sops.age.keyFile = "/var/lib/sops-nix/keys.txt";
  system.stateVersion = "25.05";
}

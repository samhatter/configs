{pkgs, ...}: {
  imports = [../profiles/base.nix];

  home.username = "samantha";
  home.homeDirectory = "/home/samantha";
  home.stateVersion = "24.11";

  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
}

{pkgs, ...}: {
  imports = [
    ./modules/fish.nix
    ./modules/git.nix
    ./modules/gnome.nix
    ./modules/kitty.nix
    ./modules/neovim.nix
    ./modules/ssh.nix
  ];

  home.username = "samantha";
  home.homeDirectory = "/home/samantha";
  home.stateVersion = "24.11";

  sops.age.keyFile = "/var/lib/sops-nix/key.txt";

  home.packages = with pkgs; [
    xclip
  ];
}

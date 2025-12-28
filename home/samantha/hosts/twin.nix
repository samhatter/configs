{pkgs, ...}: {
  imports = [
    ./modules/fish.nix
    ./modules/gh.nix
    ./modules/git.nix
    ./modules/neovim.nix
    ./modules/ssh.nix
    ./modules/vscode.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "samantha";
  home.homeDirectory = "/home/samantha";
  home.stateVersion = "24.11";

  sops.age.keyFile = "/var/lib/sops-nix/key.txt";

  home.packages = with pkgs; [
    xclip
    pciutils
  ];
}

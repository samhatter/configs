{pkgs, ...}: {
  imports = [
    ../modules/fish.nix
    ../modules/gh.nix
    ../modules/git.nix
    ../modules/neovim.nix
    ../modules/ssh.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    xclip
    pciutils
  ];
}

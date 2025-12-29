{
  pkgs,
  ...
}: {
    wsl.enable = true;
    wsl.defaultUser = "samantha";

    programs.nix-ld.enable = true;
}
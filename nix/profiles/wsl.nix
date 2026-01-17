{pkgs, ...}: {
  wsl.enable = true;
  wsl.defaultUser = "samantha";

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  programs.nix-ld.enable = true;

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    pyenv
  ];
}

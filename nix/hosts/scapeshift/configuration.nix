{pkgs, config, ...}: {
  networking.hostName = "scapeshift";
  networking.firewall.enable = false;

  imports = [
    ../../profiles/base.nix
    ../../profiles/wsl.nix
    ../../users/samantha.nix
  ];

  sops.age.keyFile = "/var/lib/sops-nix/keys.txt";

  hardware.opengl.enable = true;

  # Point to Windows NVIDIA libraries for WSL
  environment.sessionVariables = {
    LD_LIBRARY_PATH = "/usr/lib/wsl/lib";
  };

  environment.systemPackages = with pkgs; [
    cudatoolkit
    linuxPackages.nvidia_x11
  ];
  
  system.stateVersion = "25.05";
}

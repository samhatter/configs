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

  # Point to Windows NVIDIA libraries for WSL (system-wide)
  environment.variables = {
    LD_LIBRARY_PATH = "/usr/lib/wsl/lib";
  };

  # Configure nix-ld to find WSL libraries
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
  ];

  environment.systemPackages = with pkgs; [
    cudatoolkit
    linuxPackages.nvidia_x11
  ];
  
  system.stateVersion = "25.05";
}

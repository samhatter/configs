{ config, pkgs, ... }:

{
  sops.secrets."samantha-password" = {
    sopsFile = ../../secrets/shared/passwords.yaml;
    format = "yaml";
    key = "samantha_password";
    mode = "0400";
    neededForUsers = true;
  };

  users.users.samantha = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "render" ];
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets."samantha-password".path;
    openssh.authorizedKeys.keyFiles = [ /home/samantha/.ssh/authorized_keys ];
    createHome = true;
  };

  sops.age.keyFile = "/var/lib/sops-nix/keys.txt";
}

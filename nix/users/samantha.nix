{ config, pkgs, lib, ... }:

{
    sops.age.keyFile = "/var/lib/sops-nix/key.txt";

    sops.secrets."samantha-password" = {
        sopsFile = ../../secrets/shared/passwords.yaml;
        format = "yaml";
        key = "samantha_password";
        mode = "0400";
        neededForUsers = true;
    };

    users.users.samantha = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "docker" ];
        shell = pkgs.fish;
        hashedPasswordFile = config.sops.secrets."samantha-password".path;
        createHome = true;
    };

    programs.fish.enable = true;
}

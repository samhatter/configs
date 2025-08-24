{ config, pkgs, lib, ... }:

{
    sops.age.keyFile = "home/samantha/.config/sops/age/keys.txt";

    sops.secrets."samantha-password" = {
        sopsFile = ../secrets/shared/passwords.yaml;
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
   
    home-manager.backupFileExtension = "backup";
 
    home-manager.users.samantha = { pkgs, ... }: {
        home.stateVersion = "24.05";

        programs.fish = {
            enable = true;
            plugins = [
                { name = "grc"; src = pkgs.fishPlugins.grc; }
            ];
        };

        programs.git = {
            enable = true;
            userName = "Samantha Vincent";
            userEmail = "sammyvincent2001@gmail.com";
        };

        programs.ssh.enable = true;
    };
}

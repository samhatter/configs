{ config, pkgs, lib, ... }:

{
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.wayland = true;
    services.xserver.desktopManager.gnome.enable = true;
    

    fonts.packages = with pkgs; [
        dejavu_fonts
        noto-fonts
        noto-fonts-emoji
        fira-code
    ];

    services.libinput.enable = true;

    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    services.printing.enable = true;
    services.avahi.enable = true;

    environment.systemPackages = with pkgs; [
        chromium
        gnome-tweaks
        gnomeExtensions.dash-to-dock
        vscode
        less
    ];

    programs.gnome-terminal.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.gnome.gnome-settings-daemon.enable = true;
    xdg.portal = {
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        xdgOpenUsePortal = true;
    };
    security.pam.services.gdm.enableGnomeKeyring = true;
    
    virtualisation.docker = {
        enable = true;
        rootless = {
        enable = true;
        setSocketVariable = true;
        };
    };


}
{ pkgs, utils, ... }:

{
  imports = [
    (utils.importWayland {
      compositor = "niri";
      portal = "niri-kde-base";
    })

    ../../../common/home/mako
    ../../../common/home/waybar
  ];

  services.network-manager-applet.enable = true;
  services.hyprpolkitagent.enable = true;

  home.packages = with pkgs; [
    pwvucontrol
    playerctl
    brightnessctl
    kdePackages.systemsettings

    fuzzel
    kdePackages.dolphin
    kdePackages.filelight
    kdePackages.konsole
    alacritty

    kdePackages.ark
  ];
}

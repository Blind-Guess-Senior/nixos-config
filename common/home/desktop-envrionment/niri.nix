{ pkgs, utils, ... }:

{
  imports = [
    (utils.importWayland {
      compositor = "niri";
      portal = "niri-kde-mix";
    })

    ../../../common/home/ghostty
    ../../../common/home/mako
    ../../../common/home/waybar
  ];

  services.network-manager-applet.enable = true;
  services.hyprpolkitagent.enable = true;

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.alacritty}/bin/alacritty --class '{cmd}' -T '{cmd}' -e {cmd}";
      };
    };
  };

  home.packages = with pkgs; [
    pwvucontrol
    playerctl
    brightnessctl
    kdePackages.systemsettings
    networkmanagerapplet
    clipse

    kdePackages.dolphin
    kdePackages.filelight
    kdePackages.konsole # for dolphin
    alacritty

    kdePackages.ark
  ];
}

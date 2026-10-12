{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Graphic
    ## KDE
    kdePackages.yakuake

    # Office
    bitwarden-desktop
    ## Document Processing
    pandoc
    obsidian

    # Browser
    chromium

    # Network
    ## Utilitis
    remmina
    moonlight-qt

    # Multimedia
    mpv
    obs-studio
    gimp3
    flameshot
  ];
}

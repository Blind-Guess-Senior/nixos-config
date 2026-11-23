{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Utils
    wl-clipboard
    cliphist

    # Office
    bitwarden-desktop
    ## Document Processing
    pandoc
    obsidian

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

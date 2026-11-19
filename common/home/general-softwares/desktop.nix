{ pkgs, ... }:

{
  home.packages = with pkgs; [
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

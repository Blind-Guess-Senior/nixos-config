{
  pkgs,
  ...
}:

{
  home.username = "a746";
  home.homeDirectory = "/home/a746";

  imports = [
    ./home-modules.nix
  ];

  home.packages = with pkgs; [
    # Utilities
    tmux
    yazi
    rar
    p7zip
    sops

    # Develop
    ## Runtime & Build Tools
    ### C & C++
    gnumake
    cmake
    ninja

    ### Javascript
    nodejs

    ## LaTeX
    texliveFull

    ### Emulator
    # waydroid
    # waydroid-helper

    ## JetBrains
    # jetbrains.clion
    # jetbrains.pycharm

    ## Unity
    unityhub

    ## AI Agents
    cc-switch
    # claude-code
    codex

    # Graphic
    ## KDE
    kdePackages.yakuake

    # Office
    thunderbird
    bitwarden-desktop
    libreoffice
    #aseprite

    ## Chat & Connection
    feishu
    #discord
    qq
    #wechat-uos

    ## Document Processing
    pandoc
    obsidian

    # Browser
    chromium
    # microsoft-edge

    # Network
    ## Utilitis
    remmina
    moonlight-qt

    ## Cloudflare
    cloudflared

    # Deemos
    stripe-cli

    # Multimedia
    mpv
    obs-studio
    gimp3
    flameshot

    ## Calibre
    calibre

    # Games
    #steamcmd
    osu-lazer-bin
  ];

  home.stateVersion = "26.05";
}

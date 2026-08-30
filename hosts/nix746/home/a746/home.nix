{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}:

{
  home.username = "a746";
  home.homeDirectory = "/home/a746";

  imports = [
    ./home-modules.nix
  ];

  home.packages = with pkgs; [
    pandoc
    thunderbird
    bitwarden-desktop

    obsidian
    chromium
    microsoft-edge
    firefox
    # moonlight-qt
    libreoffice

    # Build Tools
    gnumake
    cmake
    ninja

    nodejs

    # KDE
    kdePackages.yakuake

    remmina

    # Deemos
    stripe-cli

    # JetBrains
    jetbrains.clion
    jetbrains.pycharm

    # AI Agents
    cc-switch
    # claude-code
    codex

    #aseprite

    waydroid
    waydroid-helper

    # Chat & Connection
    feishu
    #discord
    qq
    #wechat-uos

    #steamcmd

    # Calibre
    calibre
    calibre-web

    # Multimedia
    mpv
    obs-studio
    gimp3
    flameshot

    # Network Proxy
    clash-verge-rev

    # Unity
    unityhub
  ];

  home.stateVersion = "26.05";
}

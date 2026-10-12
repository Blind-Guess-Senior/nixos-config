{
  inputs,
  pkgs,
  ...
}:

{
  home.username = "a746";
  home.homeDirectory = "/home/a746";

  imports = [
    ./home-modules.nix

    ./home-dev.nix
  ];

  home.packages = with pkgs; [
    # Develop
    ## LaTeX
    texliveFull

    ## Emulator
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

    # Office
    thunderbird
    libreoffice
    #aseprite

    ## Chat & Connection
    feishu
    #discord
    qq
    #wechat-uos
    wemeet

    # Browser
    chromium
    # microsoft-edge

    # Network
    ## Cloudflare
    cloudflared

    # Deemos
    stripe-cli

    ## Calibre
    calibre

    ## BT
    transmission_4-qt

    # Games
    #steamcmd
    osu-lazer-bin
  ];

  home.stateVersion = "26.05";
}

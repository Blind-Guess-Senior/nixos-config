{ config, pkgs, inputs, outputs, settings, ... }:

{
  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";

  imports = [ 
    ./modules/home/vscode
    ./modules/home/git
    ./modules/home/direnv
    ./modules/home/fish
  ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    pandoc
    thunderbird
    
    obsidian
    microsoft-edge
    moonlight-qt
    libreoffice

    gnumake
    cmake
    ninja

    kdePackages.yakuake

    jetbrains.clion
    jetbrains.rider
    jetbrains.pycharm-professional

    #aseprite

    waydroid
    waydroid-helper

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji

    feishu
    #discord
    #qq
    #wechat-uos

    #steamcmd

    calibre
    calibre-web

    mpv
    obs-studio
    gimp3
    flameshot

    clash-verge-rev

    unityhub
  ];

  home.stateVersion = "25.05";
}

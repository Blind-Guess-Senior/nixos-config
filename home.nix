{ config, pkgs, inputs, outputs, settings, ... }:

{
  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";

  imports = [ 
    ./modules/home/vscode
    ./modules/home/git
    ./modules/home/direnv
  ];

  home.packages = with pkgs; [
    pandoc
    thunderbird
    
    obsidian
    microsoft-edge
    moonlight-qt
    libreoffice

    kdePackages.yakuake

    jetbrains.clion
    jetbrains.rider
    jetbrains.pycharm-professional

    #aseprite

    waydroid
    waydroid-helper

    feishu
    telegram-desktop
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

{ pkgs, ... }:

let
  developPackages = with pkgs; [
    # LaTeX
    texliveFull

    # Emulator
    # waydroid
    # waydroid-helper

    # JetBrains
    # jetbrains.clion
    # jetbrains.pycharm

    # Unity
    unityhub

    # AI Agents
    cc-switch
    # claude-code
    codex
  ];

  officePackages = with pkgs; [
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
  ];

  servicePackages = with pkgs; [
  ];

  dailyPackages = with pkgs; [
    # Browser
    chromium
    # microsoft-edge

    cloudflared

    calibre

    transmission_4-qt

    tuxguitar
  ];

  workingPackages = with pkgs; [
    # Deemos
    stripe-cli
  ];

  gamePackages = with pkgs; [
    #steamcmd
    osu-lazer-bin
  ];

in
{
  home.packages =
    developPackages
    ++ officePackages
    ++ servicePackages
    ++ dailyPackages
    ++ workingPackages
    ++ gamePackages;
}

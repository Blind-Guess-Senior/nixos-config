{ config, pkgs, ... }:

{
  imports = [
    ../../../../common/home/direnv
    ../../../../common/home/firefox
    ../../../../common/home/fish
    ../../../../common/home/go-musicfox
    ../../../../common/home/nvim

    ./git
    ./jetbrains-rider
    ./jetbrains-webstorm
    ./vscode
  ];
}

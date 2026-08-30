{ config, pkgs, ... }:

{
  imports = [
    ../../../../common/home/direnv
    ../../../../common/home/fish
    ../../../../common/home/nvim

    ./git
    ./jetbrains-rider
    ./jetbrains-webstorm
    ./vscode
  ];
}

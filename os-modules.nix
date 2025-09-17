{ config, pkgs, ... }:

{
  imports = [
    ./modules/os/fonts
    ./modules/os/fcitx5
  ];
}

{ config, pkgs, ... }:

{
  imports = [
    ../../../common/os/clash-verge
    ../../../common/os/envfs
    ../../../common/os/fcitx5
    ../../../common/os/fonts
    ../../../common/os/git
    ../../../common/os/gnupg
    ../../../common/os/nix-ld
    ../../../common/os/sops-nix

    ./bluetooth
    ./kde-plasma
    ./postgresql
  ];

  # Enable nix-ld
  programs.nix-ld.enable = true;
}

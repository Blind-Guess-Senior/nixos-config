{ config, pkgs, ... }:

{
  imports = [
    ./os-softwares.nix
    ../../../common/os/general-softwares/utils.nix
    ../../../common/os/general-softwares/develop.nix

    ../../../common/os/calibre-web
    ../../../common/os/fonts
    ../../../common/os/git
    ../../../common/os/kde-plasma
    ../../../common/os/nix-ld
    ../../../common/os/pipewire
    ../../../common/os/sops-nix

    ./cloudflare-ddns
    ./cloudflared
    ./firewall
    ./kde-plasma
    ./network
    ./nginx
    ./openssh
    ./qbee
    ./transmission
  ];

  # Enable nix-ld
  programs.nix-ld.enable = true;
}

{ config, pkgs, ... }:

{
  imports = [
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

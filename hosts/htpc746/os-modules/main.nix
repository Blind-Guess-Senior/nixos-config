{ config, pkgs, ... }:

{
  imports = [
    ./os-softwares.nix
    ../../../common/os/general-softwares/utils.nix
    ../../../common/os/general-softwares/develop.nix

    ../../../common/os/clamav
    ../../../common/os/calibre-web
    ../../../common/os/fonts
    ../../../common/os/forgejo
    ../../../common/os/git
    ../../../common/os/kde-plasma
    ../../../common/os/nix-ld
    ../../../common/os/openssh
    ../../../common/os/pipewire
    ../../../common/os/postgresql
    ../../../common/os/sops-nix

    ./cloudflare-ddns
    ./cloudflared
    ./firewall
    ./forgejo
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

{ config, pkgs, ... }:

{
  imports = [
    ../../../common/os/fonts
    ../../../common/os/git
    ../../../common/os/nix-ld
    ../../../common/os/pipewire
    ../../../common/os/sops-nix

    ./cloudflare-ddns
    ./cloudflared
    ./firewall
    ./kde-plasma
    ./network
    ./nginx
    ./qbee
    ./transmission
  ];

  # Enable nix-ld
  programs.nix-ld.enable = true;
}

{ config, pkgs, ... }:

{
  imports = [
    ./os-softwares.nix
    ../../../common/os/general-softwares/utils.nix
    ../../../common/os/general-softwares/develop.nix

    ../../../common/os/graphics
    ../../../common/os/display-manager/sddm
    ../../../common/os/desktop-environment/plasma6

    ../../../common/os/clamav
    ../../../common/os/calibre-web
    ../../../common/os/fonts
    ../../../common/os/forgejo
    ../../../common/os/git
    ../../../common/os/hedgedoc
    ../../../common/os/nix-ld
    ../../../common/os/openssh
    ../../../common/os/pipewire
    ../../../common/os/postgresql
    ../../../common/os/sops-nix

    ./cloudflare-ddns
    ./cloudflared
    ./firewall
    ./forgejo
    ./hedgedoc
    ./sddm
    ./network
    ./nginx
    ./openssh
    ./postgresql
    ./qbee
    ./transmission
    ./webhook
  ];

  # Enable nix-ld
  programs.nix-ld.enable = true;
}

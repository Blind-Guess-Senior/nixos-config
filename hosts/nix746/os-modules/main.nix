{ ... }:

{
  imports = [
    ./os-softwares.nix
    ../../../common/os/general-softwares/utils.nix
    ../../../common/os/general-softwares/develop.nix
    ../../../common/os/general-softwares/desktop.nix

    ../../../common/os/clash-verge
    ../../../common/os/envfs
    ../../../common/os/fcitx5
    ../../../common/os/fonts
    ../../../common/os/git
    ../../../common/os/gnupg
    ../../../common/os/kde-plasma
    ../../../common/os/nix-ld
    ../../../common/os/printing
    ../../../common/os/sops-nix

    ./bluetooth
    ./cloudflare-ddns
    ./fonts
    ./network
    ./postgresql

    ./os-dev.nix
  ];

  # Enable nix-ld
  programs.nix-ld.enable = true;

  programs.gamemode.enable = true;
}

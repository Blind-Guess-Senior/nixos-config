{ ... }:

{
  imports = [
    ../../../common/os/clash-verge
    ../../../common/os/envfs
    ../../../common/os/fcitx5
    ../../../common/os/fonts
    ../../../common/os/git
    ../../../common/os/gnupg
    ../../../common/os/kde-plasma
    ../../../common/os/nix-ld
    ../../../common/os/sops-nix

    ./bluetooth
    ./fonts
    ./postgresql
  ];

  # Enable nix-ld
  programs.nix-ld.enable = true;

  programs.gamemode.enable = true;
}

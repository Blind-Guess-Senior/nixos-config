{ ... }:

{
  imports = [
    ../../../../common/home/general-softwares/utils.nix
    ../../../../common/home/general-softwares/develop.nix
    ../../../../common/home/general-softwares/desktop.nix
    ../../../../common/home/general-softwares/fun.nix

    ../../../../common/home/deepseek-harness
    ../../../../common/home/direnv
    ../../../../common/home/firefox
    ../../../../common/home/fish
    ../../../../common/home/git
    ../../../../common/home/go-musicfox
    ../../../../common/home/lutris
    ../../../../common/home/nvim

    ./git
    ./jetbrains-rider
    ./jetbrains-webstorm
    ./lutris-coverup
    ./sops-nix
    ./vscode
  ];
}

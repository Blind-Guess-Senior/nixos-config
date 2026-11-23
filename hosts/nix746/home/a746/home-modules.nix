{ ... }:

{
  imports = [
    ../../../../common/home/desktop-envrionment/niri.nix

    ./softwares.nix

    ../../../../common/home/general-softwares/utils.nix
    ../../../../common/home/general-softwares/develop.nix
    ../../../../common/home/general-softwares/desktop.nix
    ../../../../common/home/general-softwares/fun.nix

    ../../../../common/home/claude-code
    ../../../../common/home/chromium
    ../../../../common/home/deepseek-harness
    ../../../../common/home/direnv
    ../../../../common/home/firefox
    ../../../../common/home/fish
    ../../../../common/home/git
    ../../../../common/home/go-musicfox
    ../../../../common/home/lutris
    ../../../../common/home/nvim

    ./cc-switch
    ./git
    ./jetbrains-rider
    ./jetbrains-webstorm
    ./lutris
    ./lutris-coverup
    ./sops-nix
    ./vscode
  ];
}

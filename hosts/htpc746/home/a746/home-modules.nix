{ ... }:

{
  imports = [
    ../../../../common/home/general-softwares/utils.nix
    ../../../../common/home/general-softwares/develop.nix
    ../../../../common/home/general-softwares/fun.nix

    ../../../../common/home/fish
    ../../../../common/home/git
    ../../../../common/home/nvim

    ./sops-nix
  ];
}

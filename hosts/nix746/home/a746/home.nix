{ ... }:

{
  home.username = "a746";
  home.homeDirectory = "/home/a746";

  imports = [
    ./home-modules.nix

    ./home-dev.nix
  ];

  home.stateVersion = "26.05";
}

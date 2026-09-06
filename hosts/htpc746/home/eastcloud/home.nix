{
  pkgs,
  ...
}:

{
  home.username = "eastcloud";
  home.homeDirectory = "/home/eastcloud";

  imports = [
    ./home-modules.nix
  ];

  home.packages = with pkgs; [
  ];

  home.stateVersion = "26.05";
}

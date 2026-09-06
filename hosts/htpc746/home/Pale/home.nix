{
  pkgs,
  ...
}:

{
  home.username = "Pale";
  home.homeDirectory = "/home/Pale";

  imports = [
    ./home-modules.nix
  ];

  home.packages = with pkgs; [
  ];

  home.stateVersion = "26.05";
}

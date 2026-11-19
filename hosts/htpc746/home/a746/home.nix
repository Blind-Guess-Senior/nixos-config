{
  pkgs,
  ...
}:

{
  home.username = "a746";
  home.homeDirectory = "/home/a746";

  imports = [
    ./home-modules.nix
  ];

  home.packages = with pkgs; [
    # Network
    cloudflared

    # AI
    codex
  ];

  home.stateVersion = "26.11";
}

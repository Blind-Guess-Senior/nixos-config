{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}:

{
  home.username = "a746";
  home.homeDirectory = "/home/a746";

  imports = [
    ./home-modules.nix
  ];

  home.packages = with pkgs; [
    # Utils
    tmux
    yazi

    # Programming
    gdb
    cgdb

    # Network
    cloudflared

    # AI
    codex
    cc-switch
  ];

  home.stateVersion = "26.05";
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Utilities
    tmux
    yazi
    rar
    p7zip
    sops
  ];
}

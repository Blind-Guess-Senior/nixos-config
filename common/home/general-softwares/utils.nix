{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tmux
    yazi
    rar
    p7zip
    sops
    jq # JSON processer
  ];
}

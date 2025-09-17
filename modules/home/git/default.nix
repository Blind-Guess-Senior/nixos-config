{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Blind Guess Senior";
    userEmail = "Blind-Guess-Senior@outlook.com";
    
    delta.enable = true;

    lfs.enable = true;
  };
}

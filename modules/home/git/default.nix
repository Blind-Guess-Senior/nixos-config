{ config, pkgs, inputs, outputs, settings, ... }:

{
  programs.git = {
    enable = true;
    userName = "Blind Guess Senior";
    userEmail = "Blind-Guess-Senior@outlook.com";

    delta.enable = true;

    lfs.enable = true;

    extraConfig = {
      core = {
        editor = "nvim";
      };
      gpg = {
        format = "ssh";
      };
      user = {
        signingkey = "~/.ssh/id_rsa.pub";
      };
    };
  };
}

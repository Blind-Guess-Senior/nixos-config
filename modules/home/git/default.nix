{ config, pkgs, inputs, outputs, settings, ... }:

{
  programs.git = {
    enable = true;
    userName = "Blind Guess Senior";
    userEmail = "94767867+Blind-Guess-Senior@users.noreply.github.com";
    # userEmail = "Blind-Guess-Senior@outlook.com";

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

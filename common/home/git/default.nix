{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Blind Guess Senior";
        email = "Blind-Guess-Senior@outlook.com";
      };
      init = {
        defaultBranch = "main";
      };
      safe = {
        directory = [ "/etc/nixos" ];
      };
    };
  };
}

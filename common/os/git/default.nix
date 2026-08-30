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
    lfs.enable = true;

    config = {
      user = {
        name = "Blind Guess Senior";
        email = "Blind-Guess-Senior@outlook.com";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}

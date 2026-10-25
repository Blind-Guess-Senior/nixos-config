{ lib, ... }:

{
  programs.git = lib.mapAttrsRecursive (_path: value: lib.mkDefault value) {
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

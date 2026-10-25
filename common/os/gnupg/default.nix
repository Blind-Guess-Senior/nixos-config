{ lib, pkgs, ... }:

{
  programs.gnupg = {
    agent = {
      enable = true;
      pinentryPackage = lib.mkOverride 1500 pkgs.pinentry-curses;
    };
  };
}

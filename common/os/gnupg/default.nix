{
  config,
  pkgs,
  inputs,
  outputs,
  settings,
  ...
}:

{
  programs.gnupg = {
    agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
  };
}

{ lib, ... }:

{
  programs.chromium = {
    enable = true;

    commandLineArgs = lib.mkDefault [ "--proxy-pac-url=http://127.0.0.1:33331/commands/pac" ];
  };
}

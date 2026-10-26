{ lib, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.clamav ];

  services.clamav = {
    daemon = {
      enable = true;
    };

    updater = {
      enable = true;
      interval = "hourly";
    };

    scanner = lib.mkDefault {
      enable = true;
      interval = "*-*-* 04:00:00";
    };
  };
}

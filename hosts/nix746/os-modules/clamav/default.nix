{ ... }:

{
  services.clamav = {
    updater = {
      enable = true;
      interval = "*-*-* 04:00:00";
    };
    scanner = {
      enable = false;
    };
  };
}

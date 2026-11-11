{ lib, ... }:

{
  services.desktopManager = {
    plasma6 = {
      enable = true;
    };
  };

  programs.kde-pim = lib.mkOverride 500 {
    enable = false;
  };
}

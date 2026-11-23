{ portal }:

{ config, ... }:

let
  niriPath = "/etc/nixos/common/home/wayland-compositor/niri/configs";
in
{
  imports = [
    (portal { desktop = "niri"; })
  ];

  wayland.windowManager.niri = {
    enable = true;
    portalPackage = null;
  };

  xdg.configFile."niri".source = config.lib.file.mkOutOfStoreSymlink niriPath;
}

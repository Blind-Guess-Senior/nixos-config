{ config, ... }:

let
  waybarPath = "/etc/nixos/common/home/waybar/configs";
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink waybarPath;
}

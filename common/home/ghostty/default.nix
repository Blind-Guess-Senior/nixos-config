{ config, ... }:

let
  ghosttyPath = "/etc/nixos/common/home/ghostty/configs";
in
{
  programs.ghostty = {
    enable = true;
  };

  xdg.configFile."ghostty".source = config.lib.file.mkOutOfStoreSymlink ghosttyPath;
}

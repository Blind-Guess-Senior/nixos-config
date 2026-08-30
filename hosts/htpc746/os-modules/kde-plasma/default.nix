{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  systemd.defaultUnit = lib.mkForce "multi-user.target";

  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };
}

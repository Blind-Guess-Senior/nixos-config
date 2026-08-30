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
    extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-media-driver
    ];
  };

  # Enable KDE Plasma
  services = {
    desktopManager.plasma6.enable = true;

    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };
}

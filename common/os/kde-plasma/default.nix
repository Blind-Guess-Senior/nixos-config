{
  lib,
  pkgs,
  hostinfo,
  ...
}:

let
  gpuPackages = {
    intel = with pkgs; [
      vpl-gpu-rt
      intel-media-driver
    ];
    amd = [ ];
    nvidia = [ ];
  };
  gpu = hostinfo.hardware.gpu or null;
in
{
  hardware.graphics = {
    enable = true;
    enable32Bit = lib.mkDefault true;
    extraPackages = lib.mkIf (gpu != null) (
      gpuPackages.${gpu} or (throw "Unsupported GPU type: ${gpu}")
    );
  };

  # Enable KDE Plasma
  services = {
    desktopManager.plasma6.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # KDE
    kdePackages.kcalc
    kdePackages.sddm-kcm
    kdePackages.kate

    # Wayland
    wayland-utils
    wl-clipboard

    # Utils
    wl-mirror # mirror screen outputs
  ];
}

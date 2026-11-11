{ lib, pkgs, ... }:

{
  programs.niri = {
    enable = true;

  };

  services.displayManager.defaultSession = lib.mkOverride 500 "niri";

  environment.systemPackages = with pkgs; [
    # Notification
    mako
    # Protals
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    oo7-portal
    gnome-control-center
    # Authentication Agent
    polkit
    kdePackages.polkit-kde-agent-1
    # X11 compatibility
    xwayland-satellite
    # Start App
    fuzzel
  ];

  services.gnome.gnome-keyring.enable = false;
  xdg.portal.config = {
    niri = {
      "org.freedesktop.impl.portal.Secret" = lib.mkForce "kwallet";
    };
  };

  programs.nm-applet.enable = true;
}

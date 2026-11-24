{ desktop }:

{ pkgs, ... }:

/*
  Portal definitions for niri compositor with hybrid kde envrionment
  Use oo7 as secret backend; kde as file chooser
*/
let
  backends = with pkgs; [
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    kdePackages.xdg-desktop-portal-kde
    oo7-portal
  ];

  portalPackages = [ pkgs.xdg-desktop-portal ] ++ backends;
in
{
  xdg.portal = {
    enable = true;
    extraPortals = backends;

    config.${desktop} = {
      default = [
        "gnome"
        "gtk"
      ];

      "org.freedesktop.impl.portal.Access" = "gtk";
      "org.freedesktop.impl.portal.Notification" = "gtk";
      "org.freedesktop.impl.portal.FileChooser" = "kde";
      "org.freedesktop.impl.portal.Secret" = "oo7-portal";
    };
  };

  systemd.user.packages = portalPackages;
  dbus.packages = portalPackages;
}

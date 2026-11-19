{ portal }:

{ ... }:

{
  imports = [
    (portal { desktop = "niri"; })
  ];

  wayland.windowManager.niri = {
    enable = true;
    portalPackage = null;

    extraConfig = ''
      include "${./configs}/config.kdl"
    '';
  };
}

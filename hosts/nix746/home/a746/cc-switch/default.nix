{ pkgs, ... }:

{
  home.packages = [
    pkgs.cc-switch
  ];

  xdg.desktopEntries."cc-switch-url-handler" = {
    name = "CC Switch Patched";
    exec = "${pkgs.cc-switch}/bin/cc-switch %u";
    noDisplay = true;
    terminal = false;
    mimeType = [ "x-scheme-handler/ccswitch" ];
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications."x-scheme-handler/ccswitch" = [
      "cc-switch-url-handler"
    ];
  };
}

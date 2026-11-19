{ ... }:

{
  imports = [
    ../../_deps/xdg-portal
    ../../_deps/xdg-applications-menu
  ];

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}

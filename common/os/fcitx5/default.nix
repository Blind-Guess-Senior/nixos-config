{ pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      # Keep normal priority: NixOS also defines addons = [], which overrides mkDefault.
      addons = with pkgs; [
        fcitx5-gtk
        qt6Packages.fcitx5-chinese-addons
        fcitx5-nord
        fcitx5-mozc
      ];
    };
  };
}

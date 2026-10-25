{
  lib,
  pkgs,
  ...
}:

{
  fonts.packages = lib.mkDefault (
    with pkgs;
    [
      noto-fonts

      fira

      source-han-sans

      monaspace
    ]
  );

  fonts.enableDefaultPackages = lib.mkDefault true;

  fonts.fontconfig.enable = true;
  fonts.fontconfig = {
    defaultFonts = builtins.mapAttrs (_option: value: lib.mkDefault value) {
      sansSerif = [
        "Noto Sans"
        "Noto Sans CJK SC"
        "Noto Color Emoji"
      ];

      serif = [
        "Noto Serif"
        "Noto Serif CJK SC"
        "Noto Color Emoji"
      ];

      monospace = [
        "Hack"
        "Noto Sans Mono CJK SC"
        "Noto Color Emoji"
      ];

      emoji = [
        "Noto Color Emoji"
      ];
    };
  };

  i18n = builtins.mapAttrs (_option: value: lib.mkDefault value) {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "zh_CN.UTF-8/UTF-8" ];
  };
}

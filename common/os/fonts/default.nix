{
  pkgs,
  ...
}:

{
  fonts.packages = with pkgs; [
    # Default Fonts
    dejavu_fonts
    freefont_ttf
    gyre-fonts # TrueType substitutes for standard PostScript fonts
    liberation_ttf
    unifont

    noto-fonts
    noto-fonts-cjk-sans-static
    noto-fonts-cjk-serif
    noto-fonts-color-emoji

    fira

    source-han-sans

    monaspace
  ];
  fonts.enableDefaultPackages = false;

  fonts.fontconfig.enable = true;
  fonts.fontconfig = {
    defaultFonts = {
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

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "zh_CN.UTF-8/UTF-8" ];
  };
}

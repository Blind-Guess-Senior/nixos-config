{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # Default Fonts
    dejavu_fonts
    freefont_ttf
    gyre-fonts # TrueType substitutes for standard PostScript fonts
    liberation_ttf
    # unifont

    noto-fonts
    noto-fonts-cjk-sans-static
    noto-fonts-cjk-serif
    noto-fonts-color-emoji

    fira

    source-han-sans

    font-awesome
    nerd-fonts.symbols-only

    monaspace
  ];

  fonts.enableDefaultPackages = false;

  fonts.fontconfig.defaultFonts = {
    emoji = [
      "Font Awesome 7 Free"
    ];
  };
}

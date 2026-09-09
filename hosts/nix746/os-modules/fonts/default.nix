{
  lib,
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
}

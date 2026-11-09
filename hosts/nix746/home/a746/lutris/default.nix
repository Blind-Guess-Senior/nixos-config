{ inputs, pkgs, ... }:

{
  programs.lutris = {
    protonPackages = with pkgs; [
      inputs.dwproton.packages.${pkgs.stdenv.hostPlatform.system}.dw-proton # dwproton for China online game
    ];
  };
}

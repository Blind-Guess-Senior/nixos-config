{ pkgs, inputs, ... }:

let
  claudePkgs = pkgs.extend inputs.claude-code-packed.overlays.default;
in
{
  home.packages = [ claudePkgs.claude-code ];
}

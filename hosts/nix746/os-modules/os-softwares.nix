{ lib, pkgs, ... }:

{
  # cc-switch 3.16.5 links against system SQLite, which its package omits.
  nixpkgs.overlays = lib.mkAfter [
    (final: prev: {
      cc-switch = prev.cc-switch.overrideAttrs (old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ final.sqlite ];
      });
    })
  ];

  environment.systemPackages = with pkgs; [
    # Development
    ## C & C++
    libcxx
    libcxx.dev
    ## OCaml
    ocamlPackages.ocaml-lsp
  ];
}

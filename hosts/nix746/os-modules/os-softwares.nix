{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Development
    ## C & C++
    libcxx
    libcxx.dev
    ## OCaml
    ocamlPackages.ocaml-lsp
  ];
}

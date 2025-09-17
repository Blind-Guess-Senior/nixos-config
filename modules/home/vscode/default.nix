{ config, pkgs, inputs, outputs, settings, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      xaver.clang-format
      
      ms-vscode-remote.remote-containers
      
      yzhang.markdown-all-in-one
      
      ocamllabs.ocaml-platform
      jnoortheen.nix-ide
    ];
  };
}

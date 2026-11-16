{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default.extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
      # About Format
      xaver.clang-format

      # About Remote
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-vscode.remote-explorer

      # About Utilities
      eamodio.gitlens
      mkhl.direnv

      # About Language
      ## Programming Language
      # ms-vscode.cpptools
      rust-lang.rust-analyzer
      # ocamllabs.ocaml-platform
      jnoortheen.nix-ide
      ## Mark & Document Language
      yzhang.markdown-all-in-one
      james-yu.latex-workshop
      tamasfe.even-better-toml
      redhat.vscode-yaml
      kdl-org.kdl

      # About Others
      yltx.vscode-luogu
    ];
  };
}

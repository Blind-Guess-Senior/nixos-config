{
  config,
  pkgs,
  inputs,
  outputs,
  settings,
  ...
}:

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

      # About Language
      yzhang.markdown-all-in-one
      tamasfe.even-better-toml
      redhat.vscode-yaml
      # ocamllabs.ocaml-platform
      jnoortheen.nix-ide
      # ms-vscode.cpptools

      # About Others
      yltx.vscode-luogu
    ];
  };
}

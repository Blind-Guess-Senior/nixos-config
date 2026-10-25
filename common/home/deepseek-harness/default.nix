{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [ inputs.deepseek-harness.homeModules.default ];

  programs.dsh = {
    enable = true;
    profiles.tui.bundles = lib.mkDefault (
      with pkgs.dsh.bundles;
      [
        tui
        web-app
        annotation
        at-file
        billion-context
        web-ui
        modsearch
        remote
        usage-stats
        vision-toolkit
      ]
    );
    defaultProfile = lib.mkDefault "nix-tui";
  };
}

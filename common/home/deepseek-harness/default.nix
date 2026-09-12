{
  inputs,
  pkgs,
  ...
}:

{
  imports = [ inputs.deepseek-harness.homeModules.default ];

  programs.dsh = {
    enable = true;
    profiles.tui.bundles = with pkgs.dsh.bundles; [
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
    ];
    defaultProfile = "nix-tui";
  };
}

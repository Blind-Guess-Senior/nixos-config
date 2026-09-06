{
  pkgs,
  ...
}:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      "osupd" = "sudo nixos-rebuild switch --show-trace";
      "osdry" = "sudo nixos-rebuild dry-activate --show-trace";
    };

    plugins = [
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }

      {
        name = "fish-proxy";
        src = pkgs.fetchFromGitHub {
          owner = "kaze-k";
          repo = "fish-proxy";
          rev = "f87e3c1f4e672daf0a954e24a765a49d1888bccb";
          sha256 = "sha256-h8Oy+YeAyeI911NBYFqsqF93v5wg7o4ME4ZPUMPqptM=";
        };
      }
    ];
  };
}

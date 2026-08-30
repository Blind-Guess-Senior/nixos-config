{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      "osupd" = "sudo nixos-rebuild switch --show-trace";
      "osdry" = "sudo nixos-rebuild dry-activate --show-trace";
    };
  };
}

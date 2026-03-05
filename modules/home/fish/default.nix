{ config, pkgs, inputs, outputs, settings, ... }:

{
  programs.fish = {
    enable = true;

    shellInit = ''
      direnv hook fish | source
    '';

    shellAliases = {
      "osupd" = "sudo nixos-rebuild switch --show-trace";
      "osdry" = "sudo nixos-rebuild dry-activate";
    };

  };
}

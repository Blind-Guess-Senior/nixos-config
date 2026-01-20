{ config, pkgs, inputs, outputs, settings, ... }:

{
  programs.fish = {
    shellAbbrs = {
      osupd = "sudo nixos-rebuild switch";
    };

    shellInit = ''
      direnv hook fish | source
    '';
  };
}

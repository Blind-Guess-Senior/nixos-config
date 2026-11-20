{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      "osupd" = "sudo nixos-rebuild switch --show-trace";
      "osdry" = "sudo nixos-rebuild dry-activate --show-trace";
      "oshistory" = "nix profile history --profile /nix/var/nix/profiles/system";
      "osclean14" =
        "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 14d";
      "osgc14" = "sudo nix-collect-garbage --delete-older-than 14d";
      "osrepl" = "nix repl -f flake:nixpkgs";

      "hsops" =
        ''sudo env EDITOR=nano SOPS_AGE_KEY="$(sudo ssh-to-age -private-key -i /etc/ssh/ssh_host_ed25519_key)" sops'';
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

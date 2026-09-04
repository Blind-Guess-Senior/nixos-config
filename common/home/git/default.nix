{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:

{
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user = {
        name = "Blind Guess Senior";
        email = "Blind-Guess-Senior@outlook.com";
      };
      init = {
        defaultBranch = "main";
      };

      core = {
        editor = "nvim";
        autocrlf = "input";
      };

      alias = {
        "pr" = "pull --rebase";
        "unadd" = "restore --staged";
      };

      safe = {
        directory = [ "/etc/nixos" ];
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}

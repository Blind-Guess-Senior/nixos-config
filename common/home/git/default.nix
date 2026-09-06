{
  lib,
  ...
}:

{
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = lib.mapAttrsRecursive (_path: value: lib.mkDefault value) {
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
        "lo" = "log --oneline";
        "commit-a" = "commit --amend";
        "commit-an" = "commit --amend --no-edit";
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

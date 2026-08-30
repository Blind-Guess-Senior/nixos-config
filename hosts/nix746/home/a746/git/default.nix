{
  config,
  pkgs,
  inputs,
  outputs,
  settings,
  ...
}:

{
  programs.git = {
    enable = true;

    lfs.enable = true;

    settings = {
      user = {
        name = "Blind Guess Senior";
        email = "94767867+Blind-Guess-Senior@users.noreply.github.com";
        # email = "Blind-Guess-Senior@outlook.com";
        signingkey = "803C629090780959";
      };
      core = {
        editor = "nvim";
      };
      commit = {
        gpgsign = true;
      };
      gpg = {
        format = "openpgp";
      };
      tag = {
        gpgSign = true;
      };
      init = {
        defaultBranch = "main";
      };

      safe = {
        directory = [
          "/etc/nixos"
          "/home/a746/nixos-config"
        ];
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}

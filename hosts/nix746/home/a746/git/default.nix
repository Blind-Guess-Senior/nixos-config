{
  ...
}:

{
  programs.git = {
    settings = {
      user = {
        name = "Blind Guess Senior";
        email = "94767867+Blind-Guess-Senior@users.noreply.github.com";
        # signingkey = "803C629090780959";
      };

      # commit = {
      #   gpgsign = true;
      # };
      # gpg = {
      #   format = "openpgp";
      # };
      # tag = {
      #   gpgSign = true;
      # };

      safe = {
        directory = [
          "/etc/nixos"
          "/home/a746/nixos-config"
        ];
      };
    };
  };
}

{
  ...
}:

{
  programs.git = {
    settings = {
      user = {
        name = "Blind Guess Senior";
        email = "94767867+Blind-Guess-Senior@users.noreply.github.com";
        signingkey = "1B440AC3239E6C0BDC2032548B77B7825A272CB8!";
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

      safe = {
        directory = [
          "/etc/nixos"
          "/home/a746/nixos-config"
        ];
      };
    };
  };
}

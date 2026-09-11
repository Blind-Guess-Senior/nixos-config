{ config, ... }:

{
  programs.lutris-coverup = {
    enable = true;
    apiKeyFile = config.sops.secrets."lutris-coverup".path;
  };

  sops.secrets = {
    "lutris-coverup" = {
      sopsFile = ../../secrets/users/a746/lutris-coverup.yaml;
    };
  };
}

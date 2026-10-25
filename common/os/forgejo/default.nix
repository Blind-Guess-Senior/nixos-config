{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.forgejo = {
    enable = true;

    package = lib.mkDefault pkgs.forgejo;

    database = builtins.mapAttrs (_option: value: lib.mkDefault value) {
      type = "postgres";
      name = "forgejo";
      user = "forgejo";
      createDatabase = true;
    };

    repositoryRoot = "${config.services.forgejo.stateDir}/repositories";

    lfs.enable = lib.mkDefault true;

    settings = lib.mapAttrsRecursive (_path: value: lib.mkDefault value) {
      actions = {
        ENABLED = true;
      };

      migrations = {
        ALLOWED_DOMAINS = "github.com,*.github.com,*.githubusercontent.com";
        BLOCKED_DOMAINS = "";
        ALLOW_LOCALNETWORKS = false;
      };
    };
  };
}

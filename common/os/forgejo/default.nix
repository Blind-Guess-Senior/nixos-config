{ config, pkgs, ... }:

{
  services.forgejo = {
    enable = true;

    package = pkgs.forgejo;

    database = {
      type = "postgres";
      name = "forgejo";
      user = "forgejo";
      createDatabase = true;
    };

    stateDir = "/mnt/data/forgejo";
    repositoryRoot = "${config.services.forgejo.stateDir}/repositories";

    lfs.enable = true;

    settings = {
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

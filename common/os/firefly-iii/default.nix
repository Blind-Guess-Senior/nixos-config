{ lib, ... }:

{
  services.firefly-iii = {
    enable = true;

    enableNginx = true;
    virtualHost = lib.mkDefault "firefly.blind-guess-senior.cc";

    settings = {
      APP_ENV = "production";
      APP_KEY_FILE = lib.mkDefault (
        throw "firefly-iii: must set services.firefly-iii.settings.APP_KEY_FILE."
      );
      APP_URL = lib.mkDefault (throw "firefly-iii: must set services.firefly-iii.settings.APP_URL.");
      TRUSTED_PROXIES = "**";

      SITE_OWNER = "Blind-Guess-Senior@blind-guess-senior.cc";

      TZ = "Asia/Shanghai";
      LOG_CHANNEL = "syslog";
      DEFAULT_LANGUAGE = "zh_CN";
      DEFAULT_LOCALE = "equal"; # follow language setting

      DB_CONNECTION = "pgsql";
      DB_HOST = "/run/postgresql";
      DB_DATABASE = "firefly-iii";
      DB_USERNAME = "firefly-iii";
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "firefly-iii" ];
    ensureUsers = [
      {
        name = "firefly-iii";
        ensureDBOwnership = true;
      }
    ];
  };

  systemd.services.firefly-iii-setup = {
    after = [ "postgresql.target" ];
    requires = [ "postgresql.target" ];
  };
}

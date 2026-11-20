{ config, ... }:

{
  services.firefly-iii = {
    settings = {
      APP_KEY_FILE = config.sops.secrets."firefly-iii/app-key".path;
      APP_URL = "https://firefly.blind-guess-senior.cc";
    };
  };

  sops.secrets = {
    "firefly-iii/app-key" = {
      sopsFile = ../../secrets/host/firefly-iii.yaml;
      owner = config.services.firefly-iii.user;
      group = config.services.firefly-iii.group;
      mode = "0400";
    };
  };
}

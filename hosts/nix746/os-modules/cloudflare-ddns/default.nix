{ config, ... }:
{
  services.cloudflare-ddns = {
    enable = true;
    credentialsFile = config.sops.secrets."cloudflare-ddns".path;

    domains = [
      "laptop.blind-guess-senior.cc"
    ];

    provider = {
      ipv4 = "local";
      ipv6 = "local";
    };

    updateCron = "@every 5m";
    proxied = "false";
    ttl = 1;
  };

  sops.secrets = {
    "cloudflare-ddns" = {
      sopsFile = ../../secrets/host/cloudflare-ddns.yaml;
      restartUnits = [ "cloudflare-ddns.service" ];
    };
  };
}

{ config, ... }:
{
  services.cloudflare-ddns = {
    enable = true;
    credentialsFile = config.sops.secrets."cloudflare-ddns".path;

    domains = [
      "htpc.blind-guess-senior.cc"
    ];

    provider = {
      ipv4 = "none";
      ipv6 = "local";
    };

    updateCron = "@every 5m";
    proxied = "false";
    ttl = 1;
  };

  sops.secrets = {
    "cloudflare-ddns" = {
      sopsFile = ../../secrets/cloudflare-ddns.yaml;
    };
  };

  systemd.services.cloudflare-ddns = {
    after = [
      "sops-nix.service"
      "network-online.target"
    ];
    wants = [
      "sops-nix.service"
      "network-online.target"
    ];
  };
}

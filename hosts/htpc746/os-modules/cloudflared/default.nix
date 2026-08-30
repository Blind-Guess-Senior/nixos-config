{ config, lib, ... }:
{
  services.cloudflared = {
    enable = true;

    tunnels = {
      "htpc746" = {
        default = "http_status:404";
        credentialsFile = config.sops.secrets."cloudflared".path;
        ingress = {
          "blind-guess-senior.cc" = "http://localhost:80";
          "ssh.blind-guess-senior.cc" = "ssh://localhost:22";
          "bt.blind-guess-senior.cc" = "http://localhost:80";
          "pt.blind-guess-senior.cc" = "http://localhost:80";
        };
      };
    };
  };

  sops.secrets = {
    "cloudflared" = {
      sopsFile = ../../secrets/cloudflared.yaml;
    };
  };

  systemd.services."cloudflared-tunnel-htpc746" = {
    after = [
      "sops-nix.service"
      "network-online.target"
    ];
    wants = [
      "sops-nix.service"
      "network-online.target"
    ];
    environment.TUNNEL_TRANSPORT_PROTOCOL = lib.mkForce "http2";
  };
}

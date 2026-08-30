{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:

{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;

    virtualHosts."192.168.1.10" = {
      default = true;
      # no ssl now
      forceSSL = false;
      enableACME = false;

      locations."/qbee/" = {
        proxyPass = "http://127.0.0.1:8080/";
        extraConfig = "";
      };
    };

    virtualHosts = {
      "blind-guess-senior.cc" = {
        forceSSL = false;
        enableACME = false;
        # locations."/" = {
        #   extraConfig = ''
        #     proxy_set_header X-Forwarded-Proto https;
        #     return 301 https://doc.blind-guess-senior.cc;
        #   '';
        # };
      };
      "bt.blind-guess-senior.cc" = {
        forceSSL = false;
        enableACME = false;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8080/";
          extraConfig = ''
            proxy_set_header X-Forwarded-Proto https;
            proxy_set_header X-Forwarded-Port 443;
          '';
        };
      };
      "pt.blind-guess-senior.cc" = {
        forceSSL = false;
        enableACME = false;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8081/";
          extraConfig = ''
            proxy_set_header X-Forwarded-Proto https;
            proxy_set_header X-Forwarded-Port 443;
          '';
        };
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "Blind-Guess-Senior@outlook.com";
  };
}

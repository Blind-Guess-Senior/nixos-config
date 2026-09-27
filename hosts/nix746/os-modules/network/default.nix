{ ... }:

{
  networking.networkmanager = {
    enable = true;

    settings = {
      connection = {
        "ipv6.addr-gen-mode" = "eui64";
        "ipv6.ip6-privacy" = "0";
      };
    };
  };
}

{ ... }:
{
  networking.useNetworkd = true;
  systemd.network = {
    enable = true;
    networks."10-lan" = {
      matchConfig.Name = "enp5s0";
      linkConfig = {
        MTUBytes = "1480";
      };
      address = [ "192.168.1.100/24" ];
      gateway = [ "192.168.1.1" ];
      dns = [
        "114.114.114.114"
        "2400:3200::1"
        "1.1.1.1"
        "2001:4860:4860::8888"
        "2606:4700:4700::1111"
      ];
    };
  };

}

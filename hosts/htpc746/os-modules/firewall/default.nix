{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:

{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
      80
      443
      2222
    ];
    allowedTCPPortRanges = [
      {
        from = 45600;
        to = 45700;
      }
    ];
    allowedUDPPorts = [ ];
  };
}

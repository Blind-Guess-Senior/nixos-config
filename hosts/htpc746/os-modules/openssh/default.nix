{ ... }:
{
  services.openssh = {
    enable = true;
    ports = [
      22
      2222
    ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}

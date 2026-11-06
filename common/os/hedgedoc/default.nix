{ lib, ... }:

{
  services.hedgedoc = {
    enable = true;

    settings = {
      db = {
        username = "hedgedoc";
        database = "hedgedoc";
        # host = "localhost:5432";
        # or via socket
        host = "/run/postgresql";
        dialect = "postgresql";
      };

      host = "127.0.0.1";
      port = lib.mkDefault 8084;
      protocolUseSSL = true;
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "hedgedoc" ];
    ensureUsers = [
      {
        name = "hedgedoc";
        ensureDBOwnership = true;
      }
    ];
  };
}

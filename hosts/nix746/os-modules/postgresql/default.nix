{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;

    extensions =
      ps: with ps; [
        postgis
        pg_repack
        pkgs.postgresql15Packages.pgvector
      ];
  };
}

{
  pkgs,
  ...
}:

{
  services.calibre-web = {
    enable = true;
    group = "media";
    listen = {
      ip = "127.0.0.1";
      port = 8083;
    };

    dataDir = "/var/lib/calibre-web";

    options = {
      enableBookUploading = true;
      enableBookConversion = true;
      calibreLibrary = "/mnt/data/calibre";
    };
  };
}

{ config, ... }:
{
  services.transmission = {
    enable = true;

    user = "transmission";
    group = "torrent";
    downloadDirPermissions = "770";

    home = "/mnt/data/transmission";

    openPeerPorts = true;
    openRPCPort = true;

    settings = {
      alt_speed_down = 1024;
      alt_speed_time_enabled = true;
      alt_speed_time_begin = 540;
      alt_speed_time_end = 2160;
      alt_speed_up = 512;

      dht_enabled = false;

      download-dir = "${config.services.transmission.home}/Downloads";

      download_queue_enabled = true;
      download_queue_size = 5;

      incomplete-dir = "${config.services.transmission.home}/.incomplete";
      incomplete-dir-enabled = true;

      lpd_enabled = false;
      pex_enabled = false;

      rpc_authentication_required = true;
      rpc_host_whitelist = "pt.blind-guess-senior.cc;127.0.0.1";
      rpc_host_whitelist_enabled = true;
      rpc_password = "{efaaafb5ca4228fd78a8de72be0bed3a93c5737aeazbH39.";
      rpc-port = 8081;
      rpc_username = "transmission";
      rpc_whitelist = "pt.blind-guess-senior.cc;127.0.0.1";
      rpc-whitelist-enabled = true;

      seed_queue_enabled = true;
      seed_queue_size = 10;

      speed_limit_down_enabled = true;
      speed_limit_down = 5120;
      speed_limit_up_enabled = true;
      speed_limit_up = 2048;

      umask = "002";

      watch-dir = "${config.services.transmission.home}/watchdir";
      watch-dir-enabled = true;
    };
  };
}

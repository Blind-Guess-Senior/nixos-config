{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:

{
  services.qbittorrent = {
    enable = true;
    package = pkgs.qbittorrent-enhanced-nox;
    user = "qbittorrent";
    group = "torrent";
    profileDir = "/mnt/data/qBittorrent/";
    openFirewall = true;
    webuiPort = 8080;

    serverConfig = {
      BitTorrent = {
        Session = {
          AddExtensionToIncompleteFiles = "true";
          AddTrackersEnabled = "true";
          AddTrackersFromURLEnabled = "true";
          AdditionalTrackers = ''http://1337.abcvg.info:80/announce\nhttp://bt.okmp3.ru:2710/announce\nhttp://ipv6.rer.lol:6969/announce\nhttp://nyaa.tracker.wf:7777/announce\nhttp://retracker.x2k.ru:80/announce\nhttp://t.nyaatracker.com:80/announce\nhttp://tk.greedland.net:80/announce\nhttp://torrentsmd.com:8080/announce\nhttp://tracker.bt4g.com:2095/announce\nhttp://tracker.electro-torrent.pl:80/announce\nhttp://tracker.files.fm:6969/announce\nhttp://www.all4nothin.net:80/announce.php\nhttp://www.wareztorrent.com:80/announce\nhttps://retracker2.x2k.ru:443/announce\nhttps://tr.burnabyhighstar.com:443/announce\nhttps://tracker.kuroy.me:443/announce\nhttps://tracker.tamersunion.org:443/announce\nhttps://tracker.yemekyedim.com:443/announce\nhttps://tracker1.520.jp:443/announce\nhttps://trackers.mlsub.net:443/announce\nudp://bt1.archive.org:6969/announce\nudp://bt2.archive.org:6969/announce\nudp://ec2-18-191-163-220.us-east-2.compute.amazonaws.com:6969/announce\nudp://evan.im:6969/announce\nudp://exodus.desync.com:6969/announce\nudp://open.demonii.com:1337/announce\nudp://open.demonoid.ch:6969/announce\nudp://open.stealth.si:80/announce\nudp://open.tracker.cl:1337/announce\nudp://open.tracker.ink:6969/announce\nudp://opentor.org:2710/announce\nudp://opentracker.io:6969/announce\nudp://p4p.arenabg.com:1337/announce\nudp://retracker.lanta.me:2710/announce\nudp://retracker01-msk-virt.corbina.net:80/announce\nudp://run.publictracker.xyz:6969/announce\nudp://thetracker.org:80/announce\nudp://tracker.0x7c0.com:6969/announce\nudp://tracker.birkenwald.de:6969/announce\nudp://tracker.breizh.pm:6969/announce\nudp://tracker.dler.com:6969/announce\nudp://tracker.doko.moe:6969/announce\nudp://tracker.dump.cl:6969/announce\nudp://tracker.fnix.net:6969/announce\nudp://tracker.opentrackr.org:1337/announce\nudp://tracker.skyts.net:6969/announce\nudp://tracker.theoks.net:6969/announce\nudp://tracker.tiny-vps.com:6969/announce\nudp://tracker.torrent.eu.org:451/announce\nudp://tracker.xor.st:6969/announce\nudp://tracker1.bt.moack.co.kr:80/announce\nudp://tracker3.t-1.org:6969/announce\nudp://ttk2.nbaonlineservice.com:6969/annou\n\nhttps://cdn.jsdelivr.net/gh/DeSireFire/animeTrackerList/AT_best.txt\nhttps://cdn.jsdelivr.net/gh/DeSireFire/animeTrackerList/AT_all.txt\nhttps://cdn.jsdelivr.net/gh/DeSireFire/animeTrackerList/AT_all_udp.txt\nhttps://cdn.jsdelivr.net/gh/DeSireFire/animeTrackerList/AT_all_http.txt\nhttps://cdn.jsdelivr.net/gh/DeSireFire/animeTrackerList/AT_all_https.txt\nhttps://cdn.jsdelivr.net/gh/DeSireFire/animeTrackerList/AT_all_ws.txt\nhttps://cdn.jsdelivr.net/gh/DeSireFire/animeTrackerList/AT_best_ip.txt\nhttps://cdn.jsdelivr.net/gh/DeSireFire/animeTrackerList/AT_all_ip.txt\nhttps://cdn.jsdelivr.net/gh/DeSireFire/animeTrackerList/AT_bad.txt\n\nhttp://open.acgtracker.com:1096/announce\nhttps://cf.trackerslist.com/best.txt\n'';
          AdditionalTrackersURL = "https://ngosang.github.io/trackerslist/trackers_best.txt";
          AlternativeGlobalDLSpeedLimit = 1024;
          AlternativeGlobalUPSpeedLimit = 1024;
          AnnounceToAllTrackers = "true";
          AutoBanBTPlayerPeer = "true";
          AutoBanUnknownPeer = "true";
          DiskIOReadMode = "DisableOSCache";
          DiskIOType = "Posix";
          DiskIOWriteMode = "DisableOSCache";
          FinishedTorrentExportDirectory = "/mnt/data/qBittorrent/qBittorrent/torrents";
          GlobalDLSpeedLimit = 2560;
          GlobalUPSpeedLimit = 1536;
          IgnoreLimitsOnLAN = "true";
          MaxActiveDownloads = 6;
          MaxActiveTorrents = 40;
          MaxActiveUploads = 20;
          Preallocation = "true";
          PublicTrackersList = ''http://tracker.opentrackr.org:1337/announce\n\nudp://open.demonii.com:1337/announce\n\nudp://open.stealth.si:80/announce\n\nudp://tracker.torrent.eu.org:451/announce\n\nudp://tracker1.myporn.club:9337/announce\n\nudp://tracker.theoks.net:6969/announce\n\nudp://tracker.srv00.com:6969/announce\n\nudp://tracker.qu.ax:6969/announce\n\nudp://tracker.filemail.com:6969/announce\n\nudp://tracker.bittor.pw:1337/announce\n\nudp://tracker-udp.gbitt.info:80/announce\n\nudp://run.publictracker.xyz:6969/announce\n\nudp://retracker01-msk-virt.corbina.net:80/announce\n\nudp://opentracker.io:6969/announce\n\nudp://open.dstud.io:6969/announce\n\nudp://leet-tracker.moe:1337/announce\n\nudp://explodie.org:6969/announce\n\nudp://bt.bontal.net:6969/announce\n\nudp://6ahddutb1ucc3cp.ru:6969/announce\n\nhttps://tracker.alaskantf.com:443/announce\n\n'';
          ReannounceWhenAddressChanged = "true";
          RefreshInterval = 5000;
          TorrentExportDirectory = "/mnt/data/qBittorrent/qBittorrent/torrents";
          UseAlternativeGlobalSpeedLimit = "true";
        };
        TrackerEnabled = "true";
      };
      Preferences = {
        BitTorrent.Session.AddExtensionToIncompleteFiles = "true";
        Scheduler = {
          start_time = ''@Variant(\0\0\0\xf\x2%Q\0)'';
          end_time = ''@Variant(\0\0\0\xf\0\0\0\0)'';
        };
        WebUI = {
          Username = "admin";
          Password_PBKDF2 = "fB7OeI0wNWHHGUN8qrrbXg==:Umg/H+/nyZlUhVZFBefCfd5cLXO0ooHhYGNtsr+T9wA5zXGeXa65IPBeOJ7LHVL3Dhqw7CJFX3JijAMMghTuVw==";
        };
      };
    };
  };
}

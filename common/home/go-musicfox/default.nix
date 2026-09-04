{ pkgs, ... }:

let
  toml = pkgs.formats.toml {};
in
{
  home.packages = [
    pkgs.go-musicfox
  ];

  xdg.configFile."go-musicfox/config.toml".source = toml.generate "go-musicfox-config.toml" {
    startup = {
      checkUpdate = false;
      signIn = false;
    };

    main = {
      altScreen = true;
      enableMouseEvent = true;
      frameRate = 5;
    };

    theme = {
      dynamicMenuRows = true;
    };

    storage = {
      downloadSongWithLyric = true;
      fileNameTpl = "{{.SongName}} - {{.SongArtists}}.{{.FileExt}}";
    };

    player = {
      engine = "mpv";
      songLevel = "lossless";

      mpv = {
        bin = "${pkgs.mpv}/bin/mpv";
      };
    };
  };

}

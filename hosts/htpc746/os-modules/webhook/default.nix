{
  config,
  lib,
  pkgs,
  ...
}:

let
  builds = [
    (import ./oneday-build.nix { inherit config lib pkgs; })
    (import ./blind-guess-senior.cc-build.nix { inherit config lib pkgs; })
  ];

  allTmpfiles = lib.concatMap (b: b.tmpfiles) builds;
  allHooks = lib.mergeAttrsList (map (b: b.hooks) builds);
in
{
  systemd.tmpfiles.rules = [
    # webhook
    "d /var/lib/webhook 0755 webhook webhook -"
    "d /var/lib/webhook/.config 0755 webhook webhook -"
    "d /var/lib/webhook/.cache 0755 webhook webhook -"
  ]
  ++ allTmpfiles;

  services.webhook = {
    enable = true;
    ip = "0.0.0.0";

    port = 9001;

    user = "webhook";
    group = "webhook";

    hooks = allHooks;
  };

  users.users.webhook = {
    isSystemUser = true;
    group = "webhook";
    createHome = true;
    home = "/var/lib/webhook";
    shell = pkgs.bash;
  };
}

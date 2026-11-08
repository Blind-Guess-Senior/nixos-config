{
  config,
  lib,
  pkgs,
  ...
}:

let
  forgejoRootUrl = lib.removeSuffix "/" config.services.forgejo.settings.server.ROOT_URL;
  repoPath = "Blind-Guess-Senior/Oneday.git";
  repoUrl = "${forgejoRootUrl}/${repoPath}";
  branch = "main";
  onedayBuild = pkgs.writeShellApplication {
    name = "oneday-build";

    runtimeInputs = [
      pkgs.git
      pkgs.git-lfs
      pkgs.nodejs_24
      pkgs.pnpm_11
      pkgs.coreutils
    ];

    text = ''
      set -euo pipefail

      sourceDir="/var/lib/oneday/source"
      webRoot="/srv/www/oneday"

      if [ ! -d "$sourceDir/.git" ]; then
        git clone --branch ${lib.escapeShellArg branch} ${lib.escapeShellArg repoUrl} "$sourceDir"
      fi

      cd "$sourceDir"

      git fetch --prune origin ${lib.escapeShellArg branch}
      git reset --hard origin/${lib.escapeShellArg branch}
      git lfs pull

      # echo "=== cwd: $(pwd)"
      # echo "=== PATH: $PATH"
      # echo "=== HOME: $HOME"
      # ls -la node_modules/.bin/astro || true
      # readlink -f node_modules/.bin/astro || true
      # command -v node || true
      # command -v astro || true

      pnpm install --frozen-lockfile

      # pnpm run build
      pnpm exec astro build

      # webRoot 目录保留，只清空内容，避免需要父目录 /srv/www 的写权限
      mkdir -p "$webRoot"
      find "$webRoot" -mindepth 1 -delete
      cp -a dist/. "$webRoot"/
    '';
  };
in
{
  systemd.tmpfiles.rules = [
    # webhook
    "d /var/lib/webhook 0755 webhook webhook -"
    "d /var/lib/webhook/.config 0755 webhook webhook -"
    "d /var/lib/webhook/.cache 0755 webhook webhook -"
    # oneday website
    "d /var/lib/oneday 0755 webhook webhook -"
    "d /srv/www/oneday 0755 webhook webhook -"
  ];

  services.webhook = {
    enable = true;
    ip = "0.0.0.0";

    port = 9001;

    user = "webhook";
    group = "webhook";

    environment = {
      # HOME = "/var/lib/webhook";
      # ASTRO_TELEMETRY_DISABLED = "1";
      # npm_config_script_shell = "${pkgs.bash}/bin/bash";
    };

    hooks = {
      build-oneday = {
        execute-command = "${onedayBuild}/bin/oneday-build";
        response-message = "Oneday build started";
      };
    };
  };

  users.users.webhook = {
    isSystemUser = true;
    group = "webhook";
    createHome = true;
    home = "/var/lib/webhook";
    shell = pkgs.bash;
  };
}

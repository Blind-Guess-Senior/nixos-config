{
  config,
  lib,
  pkgs,
}:

{
  name,
  repoPath,
  sourceDir,
  webRoot,
  hookName,
  responseMessage,
  branch ? "main",
  runtimeInputs ? [
    pkgs.git
    pkgs.git-lfs
    pkgs.nodejs_24
    pkgs.pnpm_11
    pkgs.coreutils
  ],
}:

let
  forgejoRootUrl = lib.removeSuffix "/" config.services.forgejo.settings.server.ROOT_URL;
  repoUrl = "${forgejoRootUrl}/${repoPath}";

  build = pkgs.writeShellApplication {
    inherit name runtimeInputs;

    text = ''
      set -euo pipefail

      sourceDir=${lib.escapeShellArg sourceDir}
      webRoot=${lib.escapeShellArg webRoot}

      if [ ! -d "$sourceDir/.git" ]; then
        git clone --branch ${lib.escapeShellArg branch} ${lib.escapeShellArg repoUrl} "$sourceDir"
      fi

      cd "$sourceDir"

      git fetch --prune origin ${lib.escapeShellArg branch}
      git reset --hard origin/${lib.escapeShellArg branch}
      git lfs pull

      pnpm install --frozen-lockfile
      pnpm exec astro build

      mkdir -p "$webRoot"
      find "$webRoot" -mindepth 1 -delete
      cp -a dist/. "$webRoot"/
    '';
  };
in
{
  tmpfiles = [
    "d ${sourceDir} 0755 webhook webhook -"
    "d ${webRoot} 0755 webhook webhook -"
  ];

  hooks.${hookName} = {
    execute-command = "${build}/bin/${name}";
    inherit responseMessage;
  };
}

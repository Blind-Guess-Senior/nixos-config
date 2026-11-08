{
  config,
  lib,
  pkgs,
  ...
}:

import ./libs/mkAstroBuild.nix { inherit config lib pkgs; } {
  name = "oneday-build";
  repoPath = "Blind-Guess-Senior/Oneday.git";
  sourceDir = "/var/lib/oneday/source";
  webRoot = "/srv/www/oneday";
  hookName = "oneday-build";
  responseMessage = "Oneday build started";
}

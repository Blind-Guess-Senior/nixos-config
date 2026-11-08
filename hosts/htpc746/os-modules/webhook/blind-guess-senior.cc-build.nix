{
  config,
  lib,
  pkgs,
  ...
}:

import ./libs/mkAstroBuild.nix { inherit config lib pkgs; } {
  name = "personal-site-build";
  repoPath = "Blind-Guess-Senior/Personal-Site.git";
  sourceDir = "/var/lib/blind-guess-senior.cc/source";
  webRoot = "/srv/www/blind-guess-senior.cc";
  hookName = "personal-site-build";
  responseMessage = "blind-guess-senior.cc build started";
}

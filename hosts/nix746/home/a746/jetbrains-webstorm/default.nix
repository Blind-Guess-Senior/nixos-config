{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  settings,
  ...
}:

let
  pluginList = [
    # inputs.nix-jetbrains-plugins.plugins."${settings.system}".webstorm."2025.2"."com.github.continuedev.continueintellijextension"
    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm."2026.1"."org.intellij.prisma"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm."2026.1"."com.intellij.bigdatatools.core"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm."2026.1"."com.intellij.bigdatatools.kafka"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm."2026.1"."intellij.bigdatatools.coreUi"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm."2026.1"."intellij.bigdatatools.awsBase"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm."2026.1"."com.intellij.react"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm."2026.1"."NodeJS"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm."2026.1"."com.intellij.microservices.ui"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm."2026.1"."com.anthropic.code.plugin"
  ];
in
{
  home.packages = [
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.webstorm pluginList)
  ];
}

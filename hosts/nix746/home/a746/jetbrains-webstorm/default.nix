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
  webstormPluginVersion = lib.versions.majorMinor pkgs.jetbrains.webstorm.version;

  pluginList = [
    # inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm.${webstormPluginVersion}."com.github.continuedev.continueintellijextension"
    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm.${webstormPluginVersion}."org.intellij.prisma"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm.${webstormPluginVersion}."com.intellij.bigdatatools.core"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm.${webstormPluginVersion}."com.intellij.bigdatatools.kafka"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm.${webstormPluginVersion}."intellij.bigdatatools.coreUi"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm.${webstormPluginVersion}."intellij.bigdatatools.awsBase"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm.${webstormPluginVersion}."com.intellij.react"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm.${webstormPluginVersion}."NodeJS"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm.${webstormPluginVersion}."com.intellij.microservices.ui"

    inputs.nix-jetbrains-plugins.plugins.${settings.laptopSystem}.webstorm.${webstormPluginVersion}."com.anthropic.code.plugin"
  ];
in
{
  home.packages = [
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.webstorm pluginList)
  ];
}

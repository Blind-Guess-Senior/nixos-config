{
  pkgs,
  inputs,
  ...
}:

{
  home.packages = [
    (inputs.nix-jetbrains-plugins.lib.buildIdeWithPlugins pkgs "webstorm" [
      "org.intellij.prisma"
      "com.intellij.bigdatatools.core"
      "com.intellij.bigdatatools.kafka"
      "com.intellij.react"
      "NodeJS"
      "com.intellij.microservices.ui"
      "com.anthropic.code.plugin"
    ])
  ];
}

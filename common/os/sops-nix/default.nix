{ lib, ... }:
{
  sops.age.sshKeyPaths = lib.mkDefault [ "/etc/ssh/ssh_host_ed25519_key" ];
  # sops.defaultSopsFile = ./secrets/example.yaml;
}

{ ... }:

{
  sops.secrets."nix_access_tokens_github" = {
    sopsFile = ./secrets/host/github-access-token.yaml;
  };
}

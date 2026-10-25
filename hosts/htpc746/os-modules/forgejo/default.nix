{ ... }:

{
  services.forgejo = {
    stateDir = "/mnt/data/forgejo";
    
    settings = {
      server = {
        DOMAIN = "git.blind-guess-senior.cc";
        ROOT_URL = "https://git.blind-guess-senior.cc/";
        HTTP_PORT = 7920;
        SSH_PORT = 7922;
      };
    };
  };
}

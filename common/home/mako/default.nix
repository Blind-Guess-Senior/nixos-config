{ ... }:

{
  services.mako = {
    enable = true;
    package = null;

    settings = {
      "max-history" = 20;
      "max-visible" = 7;

      "default-timeout" = 2500;
      "urgency=critical" = {
        "default-timeout" = 0;
      };
      "actionable=true" = {
        default-timeout = 4000;
      };
    };
  };
}

{ ... }:

{
  services.mako = {
    enable = true;

    settings = {
      "max-history" = 20;
      "max-visible" = 7;

      "default-timeout" = 3500;
      "urgency=critical" = {
        "default-timeout" = 0;
      };
      "actionable=true" = {
        default-timeout = 7500;
      };
    };
  };
}

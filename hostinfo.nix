let
  settings = import ./settings.nix;
in
{
  ${settings.htpcHostName} = {
    hardware = {
    };
  };

  ${settings.laptopHostName} = {
    hardware = {
      gpu = "intel";
    };
  };
}

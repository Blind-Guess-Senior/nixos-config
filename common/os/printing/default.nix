{ lib, pkgs, ... }:

{
  services.printing = {
    enable = true;

    drivers = lib.mkDefault (
      with pkgs;
      [
        gutenprint
        hplip
        splix
      ]
    );
  };
}

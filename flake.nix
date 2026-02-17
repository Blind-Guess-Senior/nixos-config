{
  description = "a746's Nix configuration";

  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can this to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , home-manager
    , ...
    }:
    let
      inherit (self) outputs;
      settings = import ./settings.nix;
      arguments = { inherit inputs outputs settings; };
    in
    {
      nixosConfigurations = {
        "${settings.hostName}" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = arguments;

          modules = [
            ./configuration.nix

            ./os-modules.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.${settings.username} = {
                imports = [
                  ./home.nix
                ];
              };
              home-manager.extraSpecialArgs = arguments;
            }
          ];
        };
      };
    };
}


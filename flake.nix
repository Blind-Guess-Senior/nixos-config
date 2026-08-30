{
  description = "Blind Guess Senior's Nix configuration";

  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can this to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    nix-jetbrains-plugins.url = "github:nix-community/nix-jetbrains-plugins";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      sops-nix,
      nix-vscode-extensions,
      ...
    }:
    let
      inherit (self) outputs;
      settings = import ./settings.nix;
      arguments = { inherit inputs outputs settings; };
    in
    {
      nixosConfigurations = {
        "${settings.htpcHostName}" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = arguments;

          modules = [
            ./hosts/${settings.htpcHostName}/configuration.nix
            ./hosts/${settings.htpcHostName}/os-modules/main.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = arguments;
              home-manager.backupFileExtension = "hm-backup-${toString self.lastModified}";

              home-manager.users = {
                a746 = {
                  imports = [
                    ./hosts/${settings.htpcHostName}/home/a746/home.nix
                  ];
                };
              };
            }

            sops-nix.nixosModules.sops
          ];
        };

        "${settings.laptopHostName}" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = arguments;

          modules = [
            ./hosts/${settings.laptopHostName}/configuration.nix
            ./hosts/${settings.laptopHostName}/os-modules/main.nix

            {
              nixpkgs.overlays = [
                nix-vscode-extensions.overlays.default
              ];
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = arguments;
              home-manager.backupFileExtension = "hm-backup-${toString self.lastModified}";

              home-manager.users = {
                a746 = {
                  imports = [
                    ./hosts/${settings.laptopHostName}/home/a746/home.nix
                  ];
                };
              };
            }

            sops-nix.nixosModules.sops
          ];
        };
      };
    };
}

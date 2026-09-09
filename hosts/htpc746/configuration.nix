# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "configurable-impure-env"
    ];

    # Nix channels mirror.
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    # GOPROXY for root. e.g. sudo nixos-rebuild switch
    impure-env = [ "GOPROXY=https://goproxy.cn,direct" ];

    auto-optimise-store = true;
  };

  nixpkgs.config = {
    # Allow unfree software.
    allowUnfree = true;
  };

  # GOPROXY for trusted user. e.g. nix shell
  systemd.services.nix-daemon.environment.GOPROXY = "https://goproxy.cn,direct";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "htpc746"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  programs.fish.enable = true;
  programs.zsh.enable = true;

  # virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    a746 = {
      isNormalUser = true;
      home = "/home/a746";
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "minecraft"
        "torrent"
        "media"
      ];
      packages = with pkgs; [
        p7zip
        gcc
        rar
      ];

      linger = true;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN8CFbi2UyFQo+5E2UNtb8NhZV7BNw9C9/PgJLgLJea6 home-Blind-Guess-Senior@outlook.com"

        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMvdXT17F99RX7tRcqLhPooTCX7gSuo37CBiOoIEHHLF nix746 Blind-Guess-Senior@outlook.com"

        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA/lGlK55+Ydy66jafZmpi8+DXYK1/9BFXU2y56TyH0v Blind-Guess-Senior@outlook.com"
      ];
    };

    Pale = {
      isNormalUser = true;
      home = "/home/Pale";
      shell = pkgs.bashInteractive;
      extraGroups = [
        "wheel"
        "docker"
        "torrent"
        "media"
      ];
      packages = with pkgs; [ ];

      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDt2+/loNXw71+pPbeOTn0ItYaBZl5jwwr6sqw53iDYuE+hgY38rS7JGcreDsj4GdZW1soCVboUHNcbAC4RBz/kRIcU5jEWfeck80wuXYJkFBa8ktOW46nnyT80i/tqKh2ZhmaT0kGfX9ty7xL/obcDghY7WhIgEdhE+T92bK2t4dMSZO5H4z7foemp/FV8U5mCarCIyVECFwv6gdDjPYmb6h8poxCYPPR0tQv3+jVCsVXCiTZ+9oh0ehf6E/m6a73qqbagdGdSemyMLPOsqHDUwoMsgvdm8phB/VvCmXhtEnUWb6gtfeU7u4f+LaOwXHP+NrwuiAi6EdFYfAM/y6UNeMmf1molqvVuLXYD3J33udFolz2oiCsn394/bIHRwdfl5GpyHbV7RCEHAz2zstg2D/gnei4IY3Wj4q33XtmKbYB2Ob/Kk9gb5P32BYPR8/HoL1jEuBHfFGpTEv8kY7LLNng39goMn3yezrPF85tbxsogzqncsEXiT50US1VqKLk= pale_knight_yq@163.com"
      ];
    };

    eastcloud = {
      isNormalUser = true;
      home = "/home/eastcloud";
      shell = pkgs.bashInteractive;
      extraGroups = [
        "wheel"
        "docker"
        "torrent"
        "media"
      ];
      packages = with pkgs; [ ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+dzg9Ut0Kfnxhj4YE9BPJ55dMjxF3fK789fhZER+p9 macbook"
      ];
    };
  };

  users.groups = {
    torrent = { };
    media = { };
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # Edit
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim

    # Network Utils
    wget
    nfs-utils
    # Network Hardware
    iw

    # File Utils
    # View
    tree
    ripgrep
    lsof
    # Compress
    libarchive
    zip
    unzip
    # Format
    nixfmt
    treefmt
    # File System
    parted

    # Development
    # VCS
    git
    # C & C++
    libgcc
    libclang
    libcxx
    libcxx.dev
    gnumake
    cmake
    ninja
    # Nix
    nixd

    # Shell
    zsh
    fish

    # Hardware
    # Monitor
    fastfetch
    btop
    # Info
    hardinfo2
    pciutils

    # Multimedia
    ffmpeg
    mpv
    alsa-utils
  ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}

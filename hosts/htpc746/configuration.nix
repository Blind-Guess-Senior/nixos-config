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
    ];

    # Nix channels mirror.
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
    ];
  };

  nixpkgs.config = {
    # Allow unfree software.
    allowUnfree = true;
    go-modules.proxy = "https://goproxy.cn,direct";
  };

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
        "transmission"
      ];
      packages = with pkgs; [
        p7zip
        gcc
      ];

      linger = true;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN8CFbi2UyFQo+5E2UNtb8NhZV7BNw9C9/PgJLgLJea6 home-Blind-Guess-Senior@outlook.com"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCNhDwcFKBHHkFUne2YpGVdtsYG5BS59IEDbsgzcfErqXIpc2DzWrK2xItDRwoMxDrbvRpW5mWeCq6YILGeXxZdnEWB50DM3cg9Nsyurwd+es10LhEZH/cX4W/6AfDgg3VNiupVbQXLVJD2YNHNh3dbh3CYa1cLWbX0TM8pL/3WObk2eJqKNhRX4jSo04GSYhzhfcWLHACmN4fWc3bpqDSV5r6Hv4YEmW2cLKBTm91/6IH3SGAPOgyXR/ULmcuoI+XXFqo5/ykUnUc0/P5v8CDIPv0Bc/APjhOEN/JvzEz+FtW02jjn9VyGn/5ixkDVv58Cq3DrK5+m98t3j3WBsnMl4y6Lq3SNuXY/EVXK+8XKNZfPXRLZJv4Ycn2XCLyzfOIbQDG41gz0AeZoB1t9iXp0nJJIvsXKvNIBBrV7S9rDT08dm7phoMm6EOptfqvomb0AlhqqQb8iou1L4ihSXZ89BOVDS1zCzrxARGrq2jVpv2vJYAjpkas8F7V0FS4lqqE= nix746.Blind-Guess-Senior@outlook.com
"
      ];
    };
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

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Edit
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim

    # Network Utils
    wget
    nfs-utils
    ndisc6
    tcpdump
    ethtool
    dig
    ## Network Hardware Utils
    iw

    # File Utils
    ## View
    tree
    ripgrep
    lsof
    ## Compress
    libarchive
    zip
    unzip
    ## Format
    nixfmt
    treefmt
    ## File System
    parted

    # Shell
    zsh
    fish

    # Hardware
    ## Monitor
    fastfetch
    btop
    ## Info
    hardinfo2
    pciutils
    usbutils

    # Multimedia
    ffmpeg
    mpv
    alsa-utils
  ];
}

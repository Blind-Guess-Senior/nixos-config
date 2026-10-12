{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # VCS
    git

    # C & C++
    libgcc
    libclang
    gnumake
    cmake
    ninja

    # Nix
    nixd
  ];
}

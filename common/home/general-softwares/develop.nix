{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Runtime & Build Tools
    ## C & C++
    gnumake
    cmake
    ninja
    gdb
    cgdb

    ## Javascript
    nodejs

    ## AI Agents
    # claude-code
    codex
  ];
}

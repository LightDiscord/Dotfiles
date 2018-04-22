{ lib, pkgs, ... }:

let
    sysconfig = (import <nixpkgs/nixos> {}).config;

    overlays = {
        mozilla = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
    };

    nixpkgs = import <nixpkgs> { overlays = [ overlays.mozilla ]; };

    packages = with pkgs; ([
    	taskwarrior
        gitAndTools.gitflow
        psmisc

        nixpkgs.latest.rustChannels.nightly.rust
    ] ++ lib.optionals sysconfig.services.xserver.enable [
        chromium
        discord
        spotify
        pavucontrol
        google-chrome
        nixpkgs.latest.firefox-nightly-bin
        feh
        obs-studio
    ]);
in {
    imports = ([
        ./cfg/git.nix
        ./cfg/fish
    ] ++ lib.optionals sysconfig.services.xserver.enable [
        ./cfg/i3wm.nix
        ./cfg/netflix.nix
        ./cfg/vscode
        ./cfg/mail.nix
        ./cfg/redshift.nix
    ]);

    home.packages = packages;
    home.keyboard.layout = "fr";

    programs.home-manager = {
        enable = true;
        path = "https://github.com/rycee/home-manager/archive/master.tar.gz";
    };
}

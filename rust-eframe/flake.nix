{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flakelight = {
      url = "github:nix-community/flakelight";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { flakelight, rust-overlay, ... }@inputs:
    flakelight ./. (
      { lib, ... }:
      {
        inherit inputs;
        withOverlays = [
          rust-overlay.overlays.default
        ];
        devShell = pkgs: rec {
          packages = with pkgs; [
            # Rust
            (rust-bin.stable.latest.default.override {
              extensions = [ "rust-src" ];
            })
            trunk

            # misc. libraries
            openssl
            pkgconf

            # GUI libs
            libxkbcommon
            libGL
            fontconfig

            # wayland libraries
            wayland

            # x11 libraries
            libxcursor
            libxrandr
            libxi
            libx11
          ];
          env = {
            LD_LIBRARY_PATH = lib.makeLibraryPath packages;
          };
        };
      }
    );
}

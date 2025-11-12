{
  description = "eframe devShell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      rust-overlay,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs, system, ... }:
        {
          _module.args.pkgs = import nixpkgs {
            inherit system;
            overlays = [
              rust-overlay.overlays.default
            ];
          };
          devShells.default =
            with pkgs;
            mkShell rec {
              packages = [
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
                xorg.libXcursor
                xorg.libXrandr
                xorg.libXi
                xorg.libX11
              ];

              LD_LIBRARY_PATH = lib.makeLibraryPath packages;
            };
        };
    };
}

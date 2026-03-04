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
    flakelight ./. {
      inherit inputs;
      withOverlays = [
        rust-overlay.overlays.default
      ];
      devShell =
        pkgs: with pkgs; {
          packages = [
            (rust-bin.stable.latest.default.override {
              extensions = [ "rust-src" ];
              targets = [ "wasm32-unknown-unknown" ];
            })
            dioxus-cli
            just
            nushell
          ];
        };
    };
}

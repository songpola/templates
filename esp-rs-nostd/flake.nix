{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    esp-rs-nix.url = "github:leighleighleigh/esp-rs-nix";
    esp-rs-nix.inputs.nixpkgs.follows = "nixpkgs";
    esp-rs-nix.inputs.flake-parts.follows = "flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs, inputs', ... }:
        let
          esp-rs = inputs'.esp-rs-nix.packages.default;
        in
        {
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              esp-rs
              esp-generate
              espflash
            ];
          };
        };
    };
}

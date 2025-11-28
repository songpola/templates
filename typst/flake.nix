{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flakelight = {
      url = "github:nix-community/flakelight";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    press = {
      url = "github:RossSmyth/press";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { flakelight, press, ... }@inputs:
    flakelight ./. {
      inherit inputs;
      withOverlays = [ press.overlays.default ];
      package =
        pkgs:
        # https://github.com/RossSmyth/press/blob/main/template/flake.nix
        pkgs.buildTypstDocument {
          name = "document";
          src = ./src;
        };
      devShell =
        pkgs: with pkgs; {
          inputsFrom = [ outputs'.packages.default ];
          stdenv = stdenvNoCC;
          packages = [
            just # Task runner
            tinymist # LSP
            typstyle # Formatter
          ];
        };
    };
}

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flakelight = {
      url = "github:nix-community/flakelight";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { flakelight, typix, ... }@inputs:
    flakelight ./. {
      inherit inputs;
      devShell =
        { inputs', ... }@pkgs:
        inputs'.typix.lib.devShell {
          # https://loqusion.github.io/typix/api/derivations/dev-shell.html
        };
    };
}

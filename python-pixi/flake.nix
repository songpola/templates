{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flakelight = {
      url = "github:nix-community/flakelight";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { flakelight, ... }@inputs:
    flakelight ./. {
      inherit inputs;
      devShell.packages =
        pkgs: with pkgs; [
          pixi
        ];
    };
}

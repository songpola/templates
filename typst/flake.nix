{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flakelight = {
      url = "github:nix-community/flakelight";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    press.url = "github:songpola/press/fix/transitive-typst-deps";
    fonts = {
      url = "github:songpola/my-typst-fonts";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flakelight.follows = "flakelight";
    };
  };

  outputs =
    {
      flakelight,
      press,
      ...
    }@inputs:
    flakelight ./. (
      { lib, ... }:
      let
        mkDoc =
          name:
          { buildTypstDocument, inputs' }:
          buildTypstDocument {
            pname = name;
            version = "latest";
            src = ./.;
            file = "src/${name}/main.typ";
            fonts = [
              inputs'.fonts.packages.th-sarabun-new-fonts
            ];
            typstEnv = p: with p; [ fletcher ];
          };

        # Get all directories in `src` that contain a `main.typ` file.
        srcDirs = map (path: builtins.baseNameOf (builtins.dirOf path)) (
          lib.fileset.toList (lib.fileset.fileFilter (file: file.name == "main.typ") ./src)
        );

        allDocs = lib.genAttrs srcDirs mkDoc;
      in
      {
        inherit inputs;
        systems = lib.systems.flakeExposed;
        withOverlays = [ press.overlays.default ];

        # Currently active package.
        # This package will also be added to `devShell::inputsFrom` automatically.
        # If you have troubles with dev env, try changing this to your current document.
        package = allDocs."main";

        packages = allDocs;

        devShell.packages =
          pkgs: with pkgs; [
            just
          ];
      }
    );
}

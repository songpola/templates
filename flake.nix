{
  description = "My collection of Nix templates";

  outputs =
    { ... }:
    {
      templates = rec {
        default = direnv;
        direnv = {
          path = ./direnv;
          description = "direnv: use flake";
        };
        flakelight = {
          path = ./default;
          description = "flakelight";
        };
        rust = {
          path = ./rust;
          description = "Rust: oxalica/rust-overlay";
        };
        rust-dioxus = {
          path = ./rust-dioxus;
          description = "Rust: Dioxus";
          welcomeText = ''
            - `cargo init`: Initialize a new Rust project in the current directory.
            - `cargo add dioxus`: Add Dioxus to the project dependencies.
            - `dx doctor`: To check the version of currently installed wasm-bindgen-cli.
            - `cargo add wasm-bindgen@=<version>`: Pin wasm-bindgen to the same version as the output of `dx doctor`. (Replace `<version>` with the version number).
            - Add these features to Cargo.toml:
              ```
              [features]
              default = ["web"]
              web = ["dioxus/web"]
              ```
          '';
        };
        rust-eframe = {
          path = ./rust-eframe;
          description = "Rust: eframe (based on emilk/eframe_template)";
        };
        typst = {
          path = ./typst;
          description = "Typst: RossSmyth/press";
        };
        python = {
          path = ./python;
          description = "Python: pkgs.python3";
        };
        python-pixi = {
          path = ./python-pixi;
          description = "Python: Pixi";
          welcomeText = ''
            - `pixi init`: Initialize a new Pixi project in the current directory.
            - `pixi add python`: Add Python interpreter to the project.
          '';
        };
        esp-idf = {
          path = ./esp-idf;
          description = "ESP-IDF: mirrexagon/nixpkgs-esp-dev";
        };
      };
    };
}

{
  description = "My collection of Nix templates";

  outputs =
    { ... }:
    {
      templates = {
        default = {
          path = ./default;
          description = "A basic development environment template using flakelight";
        };
        rust = {
          path = ./rust;
          description = "Rust development environment (using oxalica/rust-overlay)";
        };
        # https://github.com/emilk/eframe_template/
        rust-eframe = {
          path = ./rust-eframe;
          description = "Based on emilk/eframe_template, with flake-parts and oxalica/rust-overlay";
        };
        typst = {
          path = ./typst;
          description = "Typst development environment (using RossSmyth/press)";
        };
      };
    };
}

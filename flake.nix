{
  description = "My collection of Nix templates";

  outputs =
    { ... }:
    {
      templates = {
        rust = {
          path = ./rust;
          description = "Rust development environment (using oxalica/rust-overlay)";
        };
        # https://github.com/emilk/eframe_template/
        rust-eframe = {
          path = ./rust-eframe;
          description = "Based on emilk/eframe_template, with flake-parts and oxalica/rust-overlay";
        };
      };
    };
}

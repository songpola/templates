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
      };
    };
}

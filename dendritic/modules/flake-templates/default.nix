{ self', ... }:
{
  flake.templates = {
    node = {
      path = "./node";
      description = "Node template";
    };

    python = {
      path = "./python";
      description = "Python template";
    };

    rust = {
      path = "./rust";
      description = "Rust template";
    };

    zig = {
      path = "./zig";
      description = "Zig template";
    };
  };
}

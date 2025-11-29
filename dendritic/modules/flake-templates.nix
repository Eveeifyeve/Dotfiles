let
  templatesDir = ../templates;
in
{
  flake.templates = {
    node = {
      path = "${templatesDir}/node";
      description = "Node template";
    };

    python = {
      path = "${templatesDir}/python";
      description = "Python template";
    };

    rust = {
      path = "${templatesDir}/rust";
      description = "Rust template";
    };

    zig = {
      path = "${templatesDir}/zig";
      description = "Zig template";
    };
  };
}

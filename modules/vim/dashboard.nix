{ ... }:
{
  programs.nixvim.plugins.dashboard = {
    enable = true;
    settings = {
      theme = "hyper";
      hide = {
        tabline = false;
      };
      config = {
        packages.enable = false;
        week_header.enable = true;
        footer = [
          ''
            &copy 2024 eveeifyeve
          ''
        ];
        project.enable = false;
        header = [
          "  ███╗   ██╗███████╗ ██████╗ ██╗███████╗██╗   ██╗"
          "  ████╗  ██║██╔════╝██╔═══██╗██║██╔════╝╚██╗ ██╔╝"
          "  ██╔██╗ ██║█████╗  ██║   ██║██║█████╗   ╚████╔╝ "
          "  ██║╚██╗██║██╔══╝  ██║   ██║██║██╔══╝    ╚██╔╝  "
          "  ██║ ╚████║███████╗╚██████╔╝██║██║        ██║   "
          "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝╚═╝        ╚═╝   "
        ];
        shortcuts = [
          {
            desc = "📁 Find project";
            group = "String";
            action = "Telescope find_files";
            ket = "f";
          }
          {
            desc = " Git Projects";
            group = "@variable";
            action = "Telescope projects";
            key = "g";
          }
        ];
      };
    };
  };
}

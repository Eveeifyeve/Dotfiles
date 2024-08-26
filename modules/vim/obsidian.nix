{ ... }:
{
  programs.nixvim.plugins.obsidian = {
    enable = true;
    settings = {
      workspaces = [
        {
          name = "Main";
          path = "~/documents/obsidian";
        }
        # {
        #   name = "TeaClient";
        #   path = "~/projects/teaclient/obsidian";
        # }
      ];
      completion = {
        min_chars = 2;
        nvim_cmp = true;
      };
    };
  };
}

{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      nvim-autopairs.enable = true;
      luasnip.enable = true;
      treesitter.enable = true;
      trouble.enable = true;
      bufferline.enable = true;
      dashboard = {
        enable = true;
        header = [
          ''
            Eveeifyeve Config
          ''
        ];
        center = [
          {
            desc = "Find project";
            icon = "📁";
            action = "Telescope find_files";
            shortcut = "f";
          }
          {
            desc = "Git Projects";
            icon = "";
            action = "Telescope projects";
            shortcut = "g";
          }
        ];
        footer = [
          ''
            &copy 2024 eveeifyeve
          ''
        ];
        hideStatusline = true;
        hideTabline = true;
      };
      auto-save = {
        enable = true;
        enableAutoSave = true;
      };
      lightline.enable = true;
      telescope.enable = true;
      lazy.enable = true;
      direnv.enable = true;
      neocord.enable = true;
      lsp = {
        enable = true;
        servers = {
          rust-analyzer = {
            enable = true;
            autostart = true;
            installCargo = false;
            installRustc = false;
          };
          kotlin-language-server = {
            enable = true;
            autostart = true;
          };
          nil_ls = {
            enable = true;
            autostart = true;
          };
          java-language-server = {
            enable = true;
            autostart = true;
          };
          biome = {
            enable = true;
            autostart = true;
          };
          astro = {
            enable = true;
            autostart = true;
          };
          tsserver = {
            enable = true;
            autostart = true;
          };
          html = {
            enable = true;
            autostart = true;
          };
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
      };
      ccc.enable = true;
      codeium-nvim.enable = true;
      comment.enable = true;
      project-nvim.enable = true;
      todo-comments.enable = true;
      barbar = {
        enable = true;
        autoHide = true;
      };
      lualine = {
        enable = true;
      };
      obsidian = {
        enable = true;
        settings.workspaces = [
          {
            name = "Main";
            path = "~/documents/obsidian";
          }
          {
            name = "TeaClient";
            path = "~/projects/teaclient/obsidian";
          }
        ];
        settings.completion = {
          min_chars = 2;
          nvim_cmp = true;
        };
      };
    };

    extraConfigLua = ''
      require('telescope').load_extension('projects')
    '';
  };
}

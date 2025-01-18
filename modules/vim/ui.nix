{ ... }:
{
  programs.nixvim = {
    plugins = {
      # File finder
      telescope = {
        enable = true;
        extensions = {
          file-browser = {
            enable = true;
            settings = {
              hijack_netrw = true;
              hidden = true;
              grouped = true;
              collapse_dirs = true;
            };
          };
          fzf-native.enable = true;
        };

        keymaps = {
          "<leader><space>" = {
            action = "find_files";
            options = {
              desc = "Find project files";
            };
          };
          "<leader>fb" = {
            action = "file_browser";
            options = {
              desc = "Browse Project";
            };
          };
          "<leader>:" = {
            action = "command_history";
            options = {
              desc = "Command history";
            };
          };
          "<leader>gf" = {
            action = "git_files";
            options = {
              desc = "Search git files";
            };
          };
          "<leader>gc" = {
            action = "git_commits";
            options = {
              desc = "Commits";
            };
          };
          "<leader>ft" = {
            action = "live_grep";
            options = {
              desc = "Find text";
            };
          };
        };
      };

      # Line
      lualine = {
        enable = true;
      };

      # Code issues displayed clearly 
      trouble.enable = true;

      # Shows keymaps when using leader 
      which-key = {
        enable = true;
        settings.notify = true;
      };

      # Other
      indent-blankline.enable = true;

      # Warnings and notifications
      noice = {
        enable = true;
        lazyLoad.settings.event = "VeryLazy";
        settings = {
          notify.enabled = true;
          messages.enabled = true;
        };
      };

      notify.enable = true;

      # Very usefull telescope plugin.	

      harpoon = {
        enable = true;
        enableTelescope = true;
      };

      # Web dev icons
      web-devicons.enable = true;

    };
  };
}

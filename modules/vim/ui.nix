{ pkgs, ... }:
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
              mappings.n = {
                "<C-h>" = "require('telescope._extensions.file_browser.actions').goto_parent_dir";
                "<C-j" = "require('telescope.actions').move_selection_worse";
                "<C-k>" = "require('telescope.actions').move_selection_better";
                "<C-l" = "require('telescope.actions').select_default";
              };
            };
          };
          fzf-native.enable = true;
        };

        luaConfig.pre = ''
          					require("telescope").load_extension "pomodori"	
          				'';

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
          "<leader>pt" = {
            action = "function() require('telescope').extensions.pomodori.timers()";
            options = {
              desc = "Manage Pomodori Timers";
            };
          };
        };
      };

      # Line
      lualine = {
        enable = false;
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

    extraPlugins = with pkgs.vimPlugins; [ pomo-nvim ];
    extraConfigLua = ''
      			require("pomo").setup({
        sessions = {
          pomodoro = {
            { name = "Work", duration = "25m" },
            { name = "Short Break", duration = "5m" },
            { name = "Work", duration = "25m" },
            { name = "Short Break", duration = "5m" },
            { name = "Work", duration = "25m" },
            { name = "Long Break", duration = "15m" },
          },
        },
      })
      		'';
  };
}

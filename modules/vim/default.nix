{ pkgs, ... }:
{
  programs.nixvim = {
    # Basic Options
    enable = true;
    colorschemes.catppuccin.enable = true;
    clipboard.providers.wl-copy.enable = true;

    # Plugins
    plugins = {
      nvim-autopairs.enable = true;
      lazygit.enable = true;
      lazy.enable = true;
			lx-n.enable = true;
      direnv.enable = true;
      ccc.enable = true;
      todo-comments.enable = true;
    };

    extraPlugins = [
      (pkgs.vimPlugins.cord-nvim.overrideAttrs ({
        version = "unstable-2024-09-26";
        src = pkgs.fetchFromGitHub {
          owner = "vyfor";
          repo = "cord.nvim";
          rev = "a26b00d58c42174aadf975917b49cec67650545f";
          hash = "sha256-jUxBvWnj0+axuw2SZ2zLzlhZS0tu+Bk8+wHtXENofkw=";
        };

        cargoHash = "sha256-YlTmkyEo1ZsBd3fMMFpkWWfWt7CfUP1BI2G/G5UtUwg=";
      }))
    ];
    extraConfigLua = ''
      require("cord").setup({
      	display = {
      	  show_time = true,
      	  swap_fields = false,
      	  swap_icons = false,
      	},
      	ide = {
      	  enable = true,
      	  show_status = true,
      	  timeout = 300000,
      	  text = 'Idle',
      	  tooltip = '💤',
      	},
      	text = {
      	  viewing = 'Viewing {}',                    	 
      	  editing = 'Editing {}',                    
      	  file_browser = 'Browsing files in {}',     	  
      	  vcs = 'Committing changes in {}',
      	  workspace = 'In {}', 
      	  },
      })
    '';
  };
  imports = [
    ./settings.nix
    ./code.nix
    ./ui.nix
  ];
}

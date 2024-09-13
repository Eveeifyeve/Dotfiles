{ ... }:
{
  programs.nixvim = {
    plugins = {
# File finder
      telescope = {
	enable = true;
	extensions = {
	  file-browser.enable = true;
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

      harpoon = {
	enable = true;
	enableTelescope = true;
      };
    };
  };
}

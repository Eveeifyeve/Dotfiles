{
  programs.nixvim = {
    enableMan = true;

    # Vim/VI Aliases
    viAlias = true;
    vimAlias = true;

    # Options for nvim
    opts = {

      # Numbers
      number = true;
      relativenumber = true;

      # General Settings
      swapfile = false;
      termguicolors = true;
      shiftwidth = 2;

      # Searching 
      hlsearch = false;
      incsearch = true;
    };

    globals = {
      mapleader = " ";
    };

    # Keymaps
    keymaps = [
      {
        action = "<cmd>LazyGit<CR>";
        mode = "n";
        key = "<leader>gg";
        options = {
          silent = true;
        };
      }
    ];
  };
}

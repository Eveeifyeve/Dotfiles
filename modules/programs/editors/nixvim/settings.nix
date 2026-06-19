{
  nixvim.modules.base = {
    editorconfig.enable = true;
    viAlias = true;
    vimAlias = true;
    opts = {

      # Numbers
      number = true;
      relativenumber = true;

      # General Settings
      swapfile = false;
      termguicolors = true;
      showmode = false; # Cause I have a status line.
      wrap = false; # Wrapping that makes code a pain to know what line it is on.
      smartcase = true; # Ignore what case in search and just search the thing.

      # Indenting
      shiftwidth = 2;
      smartindent = true;
      tabstop = 2;

      # Searching
      hlsearch = false;
      incsearch = true;

      # Folding
      foldlevel = 99;
    };

    globals = {
      mapleader = " ";
    };

    # Keymaps
    keymaps = [
      {
        action = "<cmd>LazyGit<CR>";
        mode = "n";
        key = "<leader>g";
        options = {
          silent = true;
        };
      }
    ];
  };
}

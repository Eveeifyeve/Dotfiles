{
  programs.nixvim = {
    enableMan = true;

    # Vim/VI Aliases
    viAlias = true;
    vimAlias = true;

    # Options for nvim
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };

    # Keymaps
    keymaps = [ ];
  };
}

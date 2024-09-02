{
  programs.nixvim = {
    enableMan = true;
    viAlias = true;
    vimAlias = true;
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };

    keymaps = [ ];
  };
}
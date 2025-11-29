{
  nixvim.modules.base = {
    plugins = {
      cmp-nvim-lsp.enable = true;
      lsp-format.enable = true;
      lsp = {
        enable = true;
        inlayHints = true;
        keymaps = {
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
          };
          lspBuf = {
            K = "hover";
            gD = "references";
            gd = "definition";
            gi = "implementation";
            gt = "type_definition";
          };
        };
      };
    };
  };
}

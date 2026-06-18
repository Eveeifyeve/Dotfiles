{
  nixvim.modules.base = {
    plugins = {
      cmp-path.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          performance = {
            debounce = 60;
            fetchingTimeout = 200;
            maxViewEntries = 30;
          };
          snippet = {
            expand = "luasnip";
          };
          sources = [
            { name = "nvim_lsp"; }
            {
              name = "luasnip";
              keywordLength = 3;
            }
            { name = "cmp-dap"; }
            { name = "cmp-path"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
      };
    };
  };
}

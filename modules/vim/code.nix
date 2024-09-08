{ ... }:
{
  programs.nixvim.plugins = {

    #  Luasnip
    luasnip.enable = true;
    friendly-snippets.enable = true;

    # Cmp
    cmp-nvim-lsp.enable = true;
    cmp_luasnip.enable = true;
    dap.enable = true;
    cmp-dap.enable = true;
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
            name = "luasnip"; # snippets
            keywordLength = 3;
          }
          { name = "cmp-dap"; }
        ];
      };
    };

    # Saving 
    auto-save = {
      enable = true;
      settings.enable = true;
    };

    # Commenting 
    comment.enable = true;

    # Highlighting
    treesitter.enable = true;

    # Formatter plugins
    conform-nvim = {
      enable = true;
      settings.formatters_by_ft = {
        javascript = [ "dprint" ];
        typescript = [ "dprint" ];
        astro = [ "dprint" ];
      };
    };

    # LSP Stuff
    lsp = {
      enable = true;
      servers = {
        kotlin-language-server = {
          enable = true;
          autostart = true;
        };
        nil-ls = {
          enable = true;
          autostart = true;
        };
        java-language-server = {
          enable = true;
          autostart = true;
        };
        biome = {
          enable = true;
          autostart = true;
        };
        astro = {
          enable = true;
          autostart = true;
        };
        tsserver = {
          enable = true;
          autostart = true;
        };
        html = {
          enable = true;
          autostart = true;
        };
        rust-analyzer = {
          enable = true;
          autostart = true;
          installRustc = false;
          installCargo = false;
        };
      };
    };
  };
}

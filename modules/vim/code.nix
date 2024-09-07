{ ... }:
{
  programs.nixvim.plugins = {

  #  Luasnip
  luasnip.enable = true;
  friendly-snippets.enable = true;
    

  # Cmp
  cmp-nvim-lsp.enable = true;
  cmp_luasnip.enable = true;
  cmp = {
    enable = true;
    autoEnableSources = true;
  };

  # Formatter plugins
  conform-nvim = {
    enable = true;
    settings.formatters_by_ft = {
      javascript = ["dprint"];
      typescript = ["dprint"];
      astro = ["dprint"];
    };
  };

  # LSP Stuff
  rustaceanvim.enable = true;
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
    };
    };
  };
}

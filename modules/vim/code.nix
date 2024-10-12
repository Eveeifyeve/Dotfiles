{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {

      #  Luasnip
      luasnip.enable = true;
      friendly-snippets.enable = true;

      # Cmp
      cmp-nvim-lsp.enable = true;
      cmp_luasnip.enable = true;
      dap.enable = true;
      cmp-dap.enable = true;
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
              name = "luasnip"; # snippets
              keywordLength = 3;
            }
            { name = "cmp-dap"; }
            { name = "cmp-path"; }
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
      treesitter = {
        enable = true;
      };

      # Formatter plugins
      conform-nvim = {
        enable = true;
        settings.formatters_by_ft = {
          javascript = [ "dprint" ];
          typescript = [ "dprint" ];
          astro = [ "dprint" ];
        };
      };

      # JsonSchema store for yaml/json schemas 
      schemastore.enable = true;

      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          jsonls.enable = true;
          yamlls.enable = true;
          astro.enable = true;
          tailwindcss.enable = true;
          ts_ls.enable = true;
          marksman.enable = true;
          zls.enable = true;
          gopls.enable = true;
          ruff.enable = true;
          pyright.enable = true;
          java_language_server.enable = true;
          kotlin_language_server.enable = true;
          clojure_lsp.enable = true;
          mdx_analyzer = {
            enable = true;
            package = null;
          };
          rust_analyzer = {
            enable = true;
            installRustc = false;
            installCargo = false;
          };
          nixd = {
            enable = true;
            cmd = [ "nixd" ];
            settings = {
              nixpkgs.expr = "import <nixpkgs> { }";
              options =
                let
                  getFlake = ''(builtins.getFlake "./.")'';
                in
                {
                  nixvim.expr = ''${getFlake}.packages.${pkgs.system}.nvim.options'';
                  eveeifyeve-darwin.expr = ''${getFlake}.darwinConfigurations."eveeifyeve-macbook".options'';
                  flake-parts.expr = ''${getFlake}.debug.options'';
                  flake-parts2.expr = ''${getFlake}.currentSystem.options'';
                };
            };
          };
        };
      };
    };
  };
}

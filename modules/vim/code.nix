{ pkgs, lib, ... }:
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
        folding = true;
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

      # Lsp Formatting 
      lsp-format.enable = true;

			nvim-jdtls = {
				enable = true;
				data = "~/.cache/jdtls/workspace";
      	cmd = [
        	"${lib.getExe pkgs.jdt-language-server}"
      	];
			};

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
        servers = {
          nil_ls.enable = true;
          jsonls.enable = true;
          yamlls.enable = true;
          astro.enable = true;
          tailwindcss.enable = true;
          ts_ls.enable = true;
          marksman.enable = true;
          zls.enable = false;
          gopls.enable = true;
          ruff.enable = true;
          pyright.enable = true;
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

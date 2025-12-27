{ pkgs, ... }:
{
  programs.nixvim = {
    editorconfig.enable = true;
    extraConfigLuaPre =
      let
        java-debug = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server";
        java-test = "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server";
      in
      ''
        		  local jdtls = require("jdtls")
              local jdtls_dap = require("jdtls.dap")
              local jdtls_setup = require("jdtls.setup")

              _M.jdtls = {}
              _M.jdtls.bundles = {}

              local java_debug_bundle = vim.split(vim.fn.glob("${java-debug}" .. "/*.jar"), "\n")
              local java_test_bundle = vim.split(vim.fn.glob("${java-test}" .. "/*.jar", true), "\n")

              -- add jars to the bundle list if there are any
              if java_debug_bundle[1] ~= "" then
                  vim.list_extend(_M.jdtls.bundles, java_debug_bundle)
              end

              if java_test_bundle[1] ~= "" then
                  vim.list_extend(_M.jdtls.bundles, java_test_bundle)
              end
        		'';

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

      # Term colors
      colorizer.enable = true;

      # Commenting
      comment.enable = true;

      # Highlighting
      treesitter = {
        enable = true;
        folding.enable = true;
        settings = {
          highlight.enable = true;
        };
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
      schemastore.enable = false;

      # Lsp Formatting
      lsp-format.enable = true;

      jdtls = {
        enable = true;
        settings = {
          cmd = [
            "java"
            "--data ~/.cache/jdtls/workspace"
            "--configuration ~/.cache/jdtls/configurations"
          ];
          initOptions = {
            bundles.__raw = "_M.jdtls.bundles";
          };
        };
      };

      crates = {
        enable = true;
        lazyLoad.settings.event = "BufRead Cargo.toml";
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
          zls.enable = true;
          gleam.enable = true;
          asm_lsp.enable = true;
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

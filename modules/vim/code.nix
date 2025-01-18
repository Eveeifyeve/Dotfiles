{ pkgs, lib, ... }:
{
  programs.nixvim = {
    editorconfig.enable = true;
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
        settings = {
          java = {
            configuration = {
              updateBuildConfiguration = "interactive";
              runtimes = [
                pkgs.zulu23
                pkgs.zulu17
                pkgs.zulu11
                pkgs.zulu8
                pkgs.zulu
              ];
            };
            completion = {
              favoriteStaticMembers = [ ];
              filteredTypes = [
                "com.sun.*"
                "io.micrometer.shaded.*"
                "java.awt.*"
                "jdk.*"
                "sun.*"
                "net."
              ];
              importOrder = [
                "java"
                "javax"
                "com"
                "org"
              ];
            };
          };
          eclipse = {
            downloadSources = true;
          };
          format = {
            enabled = true;
            settings = {
              url = "${
                (pkgs.fetchurl {
                  url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml";
                  sha256 = "sha256-51Uku2fj/8iNXGgO11JU4HLj28y7kcSgxwjc+r8r35E=";
                })
              }";
              profile = "GoogleStyle";
            };
          };
          implementationCodeLens = {
            enabled = true;
          };
          import = {
            gradle = {
              enabled = true;
              wrapper = {
                enabled = true;
              };
            };
            maven = {
              enabled = true;
            };
          };
          inlayHints = {
            parameterNames = {
              enabled = "all";
            };
          };
          maven = {
            downloadSources = true;
          };
          references = {
            includeDecompiledSources = true;
          };
          referencesCodeLens = {
            enabled = true;
          };
          signatureHelp = {
            enabled = true;
          };
          preferred = "fernflower";
          sources = {
            organizeImports = {
              starThreshold = 9999;
              staticStarThreshold = 9999;
            };
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

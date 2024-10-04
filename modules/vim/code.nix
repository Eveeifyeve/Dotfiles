{pkgs, ... }:
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

# LSP Stuff
			lsp = let
				# These are defaults to disable a specific plugin remove the inherit and add it manually
				enable = true;
				autostart = true;
			in
			{
				inherit enable;
				servers = {


				# General
					nil-ls = {
						inherit enable autostart;
					};
					
					nixd = {
						inherit enable autostart;
					};
					
					jsonls = {
						inherit enable autostart;
					};

					# Yaml lsp
					yamlls = {
						inherit enable autostart;
					};

# Web Dev
					astro = {
						inherit enable autostart;
					};
					tailwindcss = {
						inherit enable autostart;
					};
					ts-ls = {
						inherit enable autostart;
					};
					marksman = {
						inherit enable autostart;
					};

# System programing
					rust-analyzer = {
						inherit enable autostart;
						installRustc = false;
						installCargo = false;
					};

					zls = {
						inherit enable autostart;
					};

					gopls = {
						inherit enable autostart;
					};

# Python 
					ruff = {
						inherit enable autostart;
					};
					pyright = {
						inherit enable autostart;
					};

# Minecraft Development 

					java-language-server = {
						inherit enable autostart;
					};

					kotlin-language-server = {
						inherit enable autostart;
					};
				};
				postConfig = ''
					require'lspconfig'.mdx_analyzer.setup({})
					'';
			};
		};
	};
}

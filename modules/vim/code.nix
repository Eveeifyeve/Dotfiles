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

# LSP Stuff
			lsp = {
				enable = true;
				servers = {
					nil-ls = {
						enable = true;
						autostart = true;
					};

# Web Dev
					biome = {
						enable = true;
						autostart = true;
					};
					astro = {
						enable = true;
						autostart = true;
					};
					tailwindcss = {
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


# System programing
					rust-analyzer = {
						enable = true;
						autostart = true;
						installRustc = false;
						installCargo = false;
					};

					zls = {
						enable = true;
						autostart = true;
					};

					gopls = {
						enable = true;
						autostart = true;
					};

# Python 
					ruff = {
						enable = true;
						autostart = true;
					};
					pyright = {
						enable = true; 
						autostart = true;
					};

# Minecraft Development 

					java-language-server = {
						enable = true;
						autostart = true;
					};

					kotlin-language-server = {
						enable = true;
						autostart = true;
					};
				};
				postConfig = ''
					require'lspconfig'.mdx_analyzer.setup({})
					'';
			};
		};
		extraConfigLua = ''
			vim.filetype.add({
					extension = {
					mdx = 'mdx'
					}
					})

			'';
	};
}

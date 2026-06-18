{
  nixvim.modules.base = {
    plugins.lsp.servers.mdx_analyzer = {
      enable = true;
      package = null;
    };
  };
}

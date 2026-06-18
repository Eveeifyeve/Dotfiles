{
  nixvim.modules.base = {
    plugins.dap-go.enable = true;
    plugins.lsp.servers.gopls.enable = true;
  };
}

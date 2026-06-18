{
  nixvim.modules.base = {
    plugins.lsp.servers = {
      ruff.enable = true;
      ty.enable = true;
    };
  };
}

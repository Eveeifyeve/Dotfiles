{
  nixvim.modules.base = {
    plugins = {
      dap.enable = true;
      dap-lldb.enable = true;
      cmp-dap.enable = true;
    };
  };
}

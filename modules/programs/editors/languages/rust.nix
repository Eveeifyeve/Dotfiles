{
  nixvim = {
    dap-config.rust = [
      {
        name = "Launch debugger";
        type = "lldb";
        request = "launch";
        stopOnEntry = false;
        runInTerminal = false;
        args = [ ];
      }
      {
        name = "(gdb) Launch debugger";
        type = "gdb";
        request = "launch";
        stopOnEntry = false;
        runInTerminal = false;
        args = [ ];
      }
    ];
    modules.base.plugins.lsp.servers.rust_analyzer = {
      enable = true;
      installRustc = false;
      installCargo = false;
    };
  };
}

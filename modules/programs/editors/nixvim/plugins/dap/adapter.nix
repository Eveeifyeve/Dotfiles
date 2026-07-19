{
  nixvim.modules.base =
    { lib, pkgs, ... }:
    {
      plugins.dap.adapters.executables = {
        lldb.command = "${lib.getExe' pkgs.lldb "lldb-vscode"}";
        gdb.command = "${lib.getExe pkgs.gdb}";
      };
    };
}

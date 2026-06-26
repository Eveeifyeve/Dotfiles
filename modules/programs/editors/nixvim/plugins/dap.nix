{
  nixvim.modules.base = {
    plugins = {
      dap.enable = true;
      dap-lldb.enable = true;
      cmp-dap.enable = true;
      dap-ui = {
        enable = true;
        lazyLoad = {
          enable = true;
          settings = {
            before.__raw = ''
              function()
                require('lz.n').trigger_load('nvim-dap')
              end
            '';
            keys = [
              {
                __unkeyed-1 = "<leader>du";
                __unkeyed-2.__raw = ''
                  								function()
                  								require('dap.ext.vscode').load_launchjs(nil, {
                  									["java"] = {"java"}
                  								})

                  								require("dapui").toggle()
                  							end
                '';
                desc = "Toggle Debugger UI";
              }
            ];
          };
        };
      };
    };
  };
}

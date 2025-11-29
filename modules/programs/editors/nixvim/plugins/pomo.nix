{
  nixvim.modules.base =
    { pkgs, ... }:
    {
      extraPlugins = with pkgs.vimPlugins; [ pomo-nvim ];
      extraConfigLua = ''
        			require("pomo").setup({
          sessions = {
            pomodoro = {
              { name = "Work", duration = "25m" },
              { name = "Short Break", duration = "5m" },
              { name = "Work", duration = "25m" },
              { name = "Short Break", duration = "5m" },
              { name = "Work", duration = "25m" },
              { name = "Long Break", duration = "15m" },
            },
          },
        })
        		'';
    };
}

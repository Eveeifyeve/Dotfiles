{ ... }:
{
  programs.nixvim = {
    plugins = {
      # File finder
      telescope.enable = true;

      # Line
      lualine = {
        enable = true;
      };

      # Code issues displayed clearly 
      trouble.enable = true;

      # Top files
      barbar = {
        enable = true;
        settings = {
          auto_hide = false;
        };
      };
    };
    extraConfigLua = ''
    '';
  };
}

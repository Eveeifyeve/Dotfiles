{ ... }:
{
  programs.nixvim.plugins = {
  rustaceanvim.enable = true;
  lsp = {
    enable = true;
    servers = {
      kotlin-language-server = {
        enable = true;
        autostart = true;
      };
      nil-ls = {
        enable = true;
        autostart = true;
      };
      java-language-server = {
        enable = true;
        autostart = true;
      };
      biome = {
        enable = true;
        autostart = true;
      };
      astro = {
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
    };
    };
  };
}

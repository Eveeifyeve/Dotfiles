{ ... }:
{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      rust-analyzer = {
        enable = true;
        autostart = true;
        installCargo = false;
        installRustc = false;
      };
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
}

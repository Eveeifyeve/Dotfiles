{
  nixvim.modules.base = {
    plugins.treesitter = {
      enable = true;
      nixGrammars = true;

      highlight.enable = true;
      indent.enable = true;
      folding.enable = true;
    };
  };
}

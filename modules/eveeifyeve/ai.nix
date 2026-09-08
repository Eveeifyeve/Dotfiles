{
  home.gui = hmArgs: {
    sops.secrets.openrouter-apikey-eveeifyeve.sopsFile = ./secrets/openrouter-apikey;

    programs.opencode.settings = {
      model = "openrouter/~z-ai/glm-flash-latest";
      small_model = "openrouter/~deepseek/deepseek-v4-flash-latest";
      provider.openrouter.options.apiKey = "{file:${hmArgs.config.sops.secrets.openrouter-apikey-eveeifyeve.path}}";
    };
  };
}

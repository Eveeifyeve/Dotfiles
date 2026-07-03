{
  home.base = hmArgs: {
    sops.secrets.openrouter-apikey-eveeifyeve = {
      sopsFile = ../secrets/openrouter-apikey;
      format = "binary";
    };

    programs.opencode.settings = {
      model = "alibaba/qwen3-coder-30b-a3b-instruct";
      provider.openrouter.options.apiKey = "{file:${hmArgs.config.sops.secrets.openrouter-apikey-eveeifyeve.path}}";
    };

    programs.nixvim.plugins.avante.settings = {
      provider = "openrouter";
      providers.openrouter = {
        __inherited_from = "openai";
        endpoint = "https://openrouter.ai/api/v1";
        model = "qwen3-coder-30b-a3b-instruct";
        api_key_name = "cmd: cat ${hmArgs.config.sops.secrets.openrouter-apikey-eveeifyeve.path}";
      };
    };
  };
}

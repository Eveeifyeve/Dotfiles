{
  homeManager.modules.gui =
    { pkgs, ... }:
    {
      programs.opencode = {
        enable = true;
        enableMcpIntegration = true;
        package = pkgs.llm-agents.opencode;
        settings = {
          autoshare = false;
          autoupdate = false;
          instructions = [
            "CONTRIBUTING.md"
            "docs/guidelines.md"
            "docs/CONTRIBUTING.md"
          ];
        };
      };
    };
}

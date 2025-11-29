{ lib, ... }:
{
  nixvim.modules.base =
    { pkgs, config, ... }:
    {
      extraConfigLuaPre = lib.optionalString config.plugins.dap.enable (
        let
          java-debug = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server";
          java-test = "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server";
        in
        ''
          local jdtls       = require("jdtls")
          local jdtls_dap   = require("jdtls.dap")
          local jdtls_setup = require("jdtls.setup")

          _M.jdtls = {}
          _M.jdtls.bundles = {}

          local java_debug_bundle = vim.split(vim.fn.glob("${java-debug}" .. "/*.jar"), "\\n")
          local java_test_bundle  = vim.split(vim.fn.glob("${java-test}"  .. "/*.jar", true), "\\n")

          if java_debug_bundle[1] ~= "" then
            vim.list_extend(_M.jdtls.bundles, java_debug_bundle)
          end

          if java_test_bundle[1] ~= "" then
            vim.list_extend(_M.jdtls.bundles, java_test_bundle)
          end
        ''
      );
      plugins = {
        jdtls = {
          enable = true;
          settings = {
            cmd = [
              "java"
              "--data ~/.cache/jdtls/workspace"
              "--configuration ~/.cache/jdtls/configurations"
            ];
            initOptions = {
              bundles.__raw = "_M.jdtls.bundles";
            };
          };
        };
      };
    };
}

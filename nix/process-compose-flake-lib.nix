{ lib }:
let
  inherit (lib) types;
  buildArgs = args: builtins.concatStringsSep " " args;
in
{
  mkProcessComposeArgumentsOption = {}:
    lib.mkOption {
      type = types.submodule
        ({ config, lib, ... }:
          let inherit (lib) types mkOption;
          in
          {
            options = {
              config = mkOption {
                type = types.listOf types.str;
                default = [ ];
              };
              detached = mkOption {
                type = types.bool;
                default = false;
              };
              disable-dotenv = mkOption {
                type = types.bool;
                default = false;
              };
              env = mkOption {
                type = types.listOf types.str;
                default = [ ];
              };
              hide-disabled = mkOption {
                type = types.bool;
                default = false;
              };
              keep-project = mkOption {
                type = types.bool;
                default = false;
              };
              namespace = mkOption {
                type = types.listOf types.str;
                default = [ ];
              };
              no-deps = mkOption {
                type = types.bool;
                default = false;
              };
              ref-rate = mkOption {
                type = types.str;
                default = "";
              };
              reverse = mkOption {
                type = types.bool;
                default = false;
              };
              sort = mkOption {
                type = types.str;
                default = "";
              };
              theme = mkOption {
                type = types.str;
                default = "";
              };
              tui = mkOption {
                type = types.bool;
                default = true;
              };
              log-file = mkOption {
                type = types.str;
                default = "";
              };
              no-server = mkOption {
                type = types.bool;
                default = false;

              };
              ordered-shutdown = mkOption {
                type = types.bool;
                default = false;
              };
              port = mkOption {
                type = types.nullOr types.int;
                default = null;
              };
              read-only = mkOption {
                type = types.bool;
                default = false;
              };
              unix-socket = mkOption {
                type = types.str;
                default = "";
              };
              use-uds = mkOption {
                type = types.bool;
                default = false;
              };
              output = mkOption {
                type = types.submodule {
                  options = {
                    global = mkOption {
                      type = types.str;
                      default = buildArgs ((
                        if config.log-file != "" then
                          [
                            "--log-file"
                            config.log-file
                          ]
                        else
                          [ ]
                      )
                      ++ (if config.no-server then [ "--no-server" ] else [ ])
                      ++ (if config.ordered-shutdown then [ "--ordered-shutdown" ] else [ ])
                      ++ (if config.port != null then [ "--port ${builtins.toString config.port}" ] else [ ])
                      ++ (if config.read-only then [ "--read-only" ] else [ ])
                      ++ (
                        if config.unix-socket != "" then
                          [
                            "--unix-socket"
                            config.unix-socket
                          ]
                        else
                          [ ]
                      )
                      ++ (if config.use-uds then [ "--use-uds" ] else [ ]));
                    };
                    up = mkOption {
                      type = types.str;
                      default = buildArgs ((builtins.map (v: "--config " + v) config.config)
                        ++ (if config.detached then [ "--detached" ] else [ ])
                        ++ (if config.disable-dotenv then [ "--disable-dotenv" ] else [ ])
                        ++ (builtins.map (v: "--env " + v) config.env)
                        ++ (if config.hide-disabled then [ "--hide-disabled" ] else [ ])
                        ++ (if config.keep-project then [ "--keep-project" ] else [ ])
                        ++ (builtins.map (v: "--namespace " + v) config.namespace)
                        ++ (if config.no-deps then [ "--no-deps" ] else [ ])
                        ++ (
                        if config.ref-rate != "" then
                          [
                            "--ref-rate"
                            config.ref-rate
                          ]
                        else
                          [ ]
                      )
                        ++ (if config.reverse then [ "--reverse" ] else [ ])
                        ++ (
                        if config.sort != "" then
                          [
                            "--sort"
                            config.sort
                          ]
                        else
                          [ ]
                      )
                        ++ (
                        if config.theme != "" then
                          [
                            "--theme"
                            config.theme
                          ]
                        else
                          [ ]
                      )
                        ++ (if config.reverse then [ "--reverse" ] else [ ])
                        ++ (if config.tui then [ ] else [ "--tui=false" ]));
                    };
                  };
                };
                default = { };
              };
            };
          });
      default = { };
    };
}

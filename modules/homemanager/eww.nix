{ lib, pkgs, ... }:
{
  programs.eww = {
    enable = true;
    configDir = ./eww;
  };
  systemd.user.services.eww = {
    Unit = {
      Description = "ElKowars wacky widgets daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service =
      let
        eww = lib.getExe pkgs.eww;
      in
      {
        Type = "simple";
        ExecStart = "${eww} daemon --no-daemonize";
        ExecStop = "${eww} kill";
        ExecReload = "${eww} reload";
      };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}

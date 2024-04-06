let 
  email = "eveeg1971@gmail.com";
  name = "Eveeifyeve";
in {
  programs.git = {
    enable = true; 
    extraConfig = {
    core.editor = "vscode";
    credential.helper = "store";
    github.user = name;
    push.autoSetupRemote = true;
   };
  userEmail = email;
  userName = name;
  };
}
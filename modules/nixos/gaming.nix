{config, lib, pkgs, ...}: {

  options = {
    gaming.enable = lib.mkEnableOption "Enabling steam and its settings";
  };

  config = lib.mkIf config.gaming.enable {
    
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    
    environment.systemPackages = with pkgs; [
      bottles
      heroic
      lutris
      mangohud
      protonup
    ];

    programs.gamemode.enable = true;

    # Move to Home Manager
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
        "/home/dkersting/.steam/root/compatibilitytools.d";
    };
  };
}

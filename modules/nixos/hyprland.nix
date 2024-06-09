{pkgs, lib, config, ...} :
{
  options = {
    hyprland.enable = 
      lib.mkEnableOption "enables Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    # Enable Hyprland and additional features
    programs.hyprland = {
      enable = true;
      nvidiaPatches = true;
      xwayland.enable = true;
    };

    environment.sessionVariables = {
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";

      # If your cursor becomes invisible
      # WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}

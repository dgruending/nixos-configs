# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/modules.nix
    ];

  # enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # install and enable extra nix-utility tools
  environment = {
    sessionVariables = {
      FLAKE = "/configuration";
    };
    
    systemPackages = with pkgs; [
      nh
      nix-output-monitor
      nvd
    ];
  };

  # enable custom modules
  fonts.enable = true;
  nvidia.enable = true;
  gaming.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  boot.initrd.luks.devices."luks-a5c8f3c1-5343-4be4-8775-72cfe805f30d".device = "/dev/disk/by-uuid/a5c8f3c1-5343-4be4-8775-72cfe805f30d";
  networking.hostName = "nixToSee"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Garbage collectiong
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 14d";

  # Auto Updating
  # system.autoUpgrade.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "de_DE.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };
 
  # Enable Hyprland
  #wayland.windowManager.hyprland.enable = true;
  #environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable XFCE Desktop.
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers =[ pkgs.gutenprint ];
  };
  
  # Enable SANE for scanning documents
  hardware.sane.enable = true; 

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Group Management
  users.groups = {
    steam = {};
    configuration = {};
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dkersting = {
    isNormalUser = true;
    description = "Dominik Kersting";
    extraGroups = [ "networkmanager" "wheel" "steam" "configuration" "scanner" "lp"];
    packages = with pkgs; [
      thunderbird
    ];
  };
  nix.settings.trusted-users = [ "root" "@wheel" ];

  users.users.fkersting = {
    isNormalUser = true;
    description = "Franziska Kersting";
    extraGroups = [ "steam" "configuration"];
  };

  # Install firefox.a
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Add kernel param to disable sgx warning
  boot.kernelParams = ["nosgx"]; 
  
  # Enable XDG autostart
  services.xserver.desktopManager.runXdgAutostartIfNone = true;
 
  # Add .NET sessionvariable for git-credential-manager
  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.dotnet_8.runtime}";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Mullvad VPN
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

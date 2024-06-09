{pkgs, ...} :
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    anki-bin
    bitwarden 
    discord
    dotnetCorePackages.dotnet_8.runtime
    git-credential-manager
    gitFull
    home-manager
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    libreoffice-qt
    mplayer
    naps2
    nerdfonts
    obsidian
    paperwork
    python3
    renpy
    thunderbird
    unp
    vim 
    wget
  ];
}

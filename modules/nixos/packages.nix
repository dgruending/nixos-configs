{pkgs, ...} :
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    anki-bin
    appimage-run
    ausweisapp
    bitwarden 
    discord
    dotnetCorePackages.dotnet_8.runtime
    freetube
    git-credential-manager
    gitFull
    go
    home-manager
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
    jdk
    libreoffice-qt
    mplayer
    naps2
    nerdfonts
    obsidian
    paperwork
    path-of-building
    python3
    renpy
    thunderbird
    unp
    unrar-free
    vim
    vscode 
    wget
  ];
}

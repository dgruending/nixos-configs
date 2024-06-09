{pkgs, lib, config, ...} :
{
  options = {
    fonts.enable = 
      lib.mkEnableOption "enables multiple (japanese) fonts"; 
  };
  
  config = lib.mkIf config.fonts.enable {
    # Enable IME
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };  

    # Fonts
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        carlito
        dejavu_fonts
        ipafont
        ipaexfont
        kanji-stroke-order-font
        kochi-substitute
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        noto-fonts-emoji-blob-bin
        noto-fonts-monochrome-emoji
        mplus-outline-fonts.githubRelease
        source-code-pro
        ttf_bitstream_vera
      ];
      fontconfig = {
        defaultFonts = {
          monospace = [
            "DejaVu Sans Mono"
            "IPAGothic"
          ];
          sansSerif = [
            "DejaVu Sans"
            "IPAPGothic"
          ];
          serif = [
            "DejaVu Serif"
            "IPAPMincho"
          ];
        };
      };
    };
  };
}

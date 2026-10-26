{ pkgs, ... }:
{
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = {
      base00 = "120019";
      base01 = "1B0027";
      base02 = "2A0038";
      base03 = "6B5285";
      base04 = "FFB3D9";
      base05 = "FF10F0";
      base06 = "FF6EF9";
      base07 = "FFFFFF";
      base08 = "FF5555";
      base09 = "FFB86C";
      base0A = "F1FA8C";
      base0B = "50FA7B";
      base0C = "8BE9FD";
      base0D = "8c1ad7";
      base0E = "FF79C6";
      base0F = "4B0082";
    };

    fonts = {
      monospace = { package = pkgs.dejavu_fonts; name = "DejaVu Sans Mono"; };
      sansSerif = { package = pkgs.dejavu_fonts; name = "DejaVu Sans"; };
      serif     = { package = pkgs.dejavu_fonts; name = "DejaVu Serif"; };
      sizes = { applications = 10; terminal = 11; desktop = 10; popups = 10; };
    };
  };
}

{ pkgs, ... }:
{
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = {
      base00 = "1D0712";
      base01 = "2C0C1C";
      base02 = "43142B";
      base03 = "753857";
      base04 = "D8649E";
      base05 = "F797C7";
      base06 = "FBBBDB";
      base07 = "FEE6F2";
      base08 = "FF3399";
      base09 = "FF5CAD";
      base0A = "FF85C2";
      base0B = "F91A8A";
      base0C = "FB74B8";
      base0D = "FF52A8";
      base0E = "F43494";
      base0F = "C1156B";
    };

    fonts = {
      monospace = { package = pkgs.dejavu_fonts; name = "DejaVu Sans Mono"; };
      sansSerif = { package = pkgs.dejavu_fonts; name = "DejaVu Sans"; };
      serif     = { package = pkgs.dejavu_fonts; name = "DejaVu Serif"; };
      sizes = { applications = 10; terminal = 11; desktop = 10; popups = 10; };
    };
  };
}

{ config, pkgs, ... }:

# dwm / st / dmenu bake their colours into config.h at compile time,
# so Stylix cannot theme them. This module patches their colours from
# the Stylix palette. `--replace-fail` makes the build fail loudly if
# upstream changes a default colour, instead of silently doing nothing.
let
  c = config.lib.stylix.colors.withHashtag;

  stColors = pkgs.writeText "st-colors.h" ''
    static const char *colorname[] = {
      /* 8 normal */
      "${c.base00}", "${c.base08}", "${c.base0B}", "${c.base0A}",
      "${c.base0D}", "${c.base0E}", "${c.base0C}", "${c.base05}",
      /* 8 bright */
      "${c.base03}", "${c.base08}", "${c.base0B}", "${c.base0A}",
      "${c.base0D}", "${c.base0E}", "${c.base0C}", "${c.base07}",

      [255] = 0,

      "${c.base06}", /* 256 cursor */
      "${c.base03}", /* 257 reverse cursor */
      "${c.base05}", /* 258 default fg */
      "${c.base00}", /* 259 default bg */
    };
  '';

  dwm = pkgs.dwm.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace config.def.h \
        --replace-fail '#222222' '${c.base00}' \
        --replace-fail '#444444' '${c.base02}' \
        --replace-fail '#bbbbbb' '${c.base05}' \
        --replace-fail '#eeeeee' '${c.base00}' \
        --replace-fail '#005577' '${c.base0D}'
    '';
  });

  dmenu = pkgs.dmenu.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace config.def.h \
        --replace-fail '#bbbbbb' '${c.base05}' \
        --replace-fail '#222222' '${c.base00}' \
        --replace-fail '#eeeeee' '${c.base00}' \
        --replace-fail '#005577' '${c.base0D}' \
        --replace-fail '#000000' '${c.base00}' \
        --replace-fail '#00ffff' '${c.base0C}'
    '';
  });

  st = pkgs.st.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      sed -i '/^static const char \*colorname\[\] = {/,/^};/d' config.def.h
      cat ${stColors} >> config.def.h
      grep -q '${c.base00}' config.def.h
    '';
  });
in
{
  services.xserver.windowManager.dwm.package = dwm;
  environment.systemPackages = [ st dmenu ];
}

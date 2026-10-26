{ config, lib, pkgs, ... }:
{

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.cleanOnBoot = true;

  # Strip the extras
  documentation.enable = false;
  documentation.nixos.enable = false;
  documentation.man.enable = false;
  documentation.info.enable = false;
  documentation.doc.enable = false;

  environment.defaultPackages = lib.mkForce [ ];
  environment.systemPackages = with pkgs; [ vim ];
  environment.stub-ld.enable = false;
  programs.command-not-found.enable = false;

  services.udisks2.enable = false;
  xdg.autostart.enable = false;
  xdg.icons.enable = false;
  xdg.menus.enable = false;
  xdg.mime.enable = false;
  xdg.sounds.enable = false;

  # Nix housekeeping
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };

}

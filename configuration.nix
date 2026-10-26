{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [
    ./modules/trimmed.nix
    ./modules/stylix.nix
    ./hardware-configuration.nix
  ];

  # ── Boot ──
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # ── Network ──
  networking.hostName = "nixos";
  networking.wireless.iwd.enable = true;
  time.timeZone = "Asia/Ho_Chi_Minh";

  # ── User ──
  users.users.iodis = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "121233";
  };
  services.getty.autologinUser = "iodis";

  # ── Display ──
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    displayManager.startx.enable = true;
    displayManager.startx.generateScript = true;
  };
  services.libinput.enable = true;
  hardware.graphics.enable = true;

  # ── Audio ──
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # ── Packages ──
  environment.systemPackages = with pkgs; [
    st
    dmenu
    git
  ];
  environment.variables.EDITOR = "nano";

  # ── Extra trimming ──
  systemd.coredump.enable = false;
  services.journald.extraConfig = "SystemMaxUse=100M";
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "26.05";
}

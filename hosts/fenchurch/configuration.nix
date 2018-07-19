# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Import local modules
    ../../overlays/local/modules/default.nix
  ];

  # The NixOS release to be compatible with for stateful data such as databases.
  system.nixos.stateVersion = "18.09";

  # Use local nixpkgs checkout
  nix.nixPath = [
    "nixpkgs=/etc/nixos/nixpkgs"
    "nixos-config=/etc/nixos/configuration.nix"
  ];

  # Local overlays
  nixpkgs.overlays = [
    (import ../../overlays/local/pkgs/default.nix)
  ];

  networking.hostName = "fenchurch";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Hardware settings
  hardware.cpu.intel.updateMicrocode = true;

  # Enable nvidia xserver driver
  services.xserver.videoDrivers = [ "nvidia" ];

  # Disable CUPS to print documents.
  services.printing.enable = false;

  # Build nix stuff with all the power
  nix.buildCores = 9;

  # Disable root login for ssh
  services.openssh.permitRootLogin = "no";

  # Enable common cli settings for my systems
  my.common-cli.enable = true;

  # Enable gpg related stuff
  my.gpg-utils.enable = true;

  # Enable common graphical stuff
  my.common-graphical.enable = true;

  # Enable my gnome desktop settings
  my.desktop-gnome.enable = true;

  # Define a user account.
  my.user.enable = true;

  # Enable virtualbox and friends.
  my.vbox.enable = true;

  # Enable gaming related thingys.
  my.gaming.enable = true;
}

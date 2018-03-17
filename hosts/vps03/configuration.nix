{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ../../profiles/common.nix
  ];

  networking.hostName = "vps03";

  # Set up bootloader
  boot.loader.grub.device = "/dev/vda";
  boot.cleanTmpDir = true;

  # Caddy
  services.caddy.enable = true;
  services.caddy.agree = true;
  services.caddy.email = "elis@hirwing.se";
  services.caddy.config = ''
    elis.nu, www.elis.nu {
      tls {
        protocols tls1.2
        key_type p384
      }

      header / {
        Strict-Transport-Security max-age=31536000
      }

      proxy / https://etu.github.io/ {
        header_upstream Host {host}
      }
    }
  '';

  # Firewall
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}

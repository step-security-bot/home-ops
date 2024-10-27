# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include nfs config.
      ./nfs.nix
      ../../users.nix
      ../../modules/neovim.nix
      ../../modules/k3s.nix
    ];

  # enable nix-flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "auto";
  boot.loader.efi.canTouchEfiVariables = true;

  # btrfs
  boot.supportedFilesystems = [ "btrfs" "xfs" ];

  # enable ipv6 forwarding (mixed ip stack)
  boot.kernel.sysctl = {
    "net.ipv6.conf.all.forwarding" = 1;
    "net.ipv6.conf.default.forwarding" = 1;
  };

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "kube-nas"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Nice font for the framebuffer console
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-120n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "de";
  };

  # link /libexec from derivations to /run/current-system/sw
  environment.pathsToLink = [ "/libexec" ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;


  # Configure keymap in X11
  services.xserver.xkb.layout = "de";

  # Disable suspend https://discourse.nixos.org/t/why-is-my-new-nixos-install-suspending/19500/2
  services.xserver.displayManager.gdm.autoSuspend = false;

  # services.xserver.xdb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with 'passwd'.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable 'sudo' for the user.
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
  # };
  # users.users.nils = {
  #   isNormalUser = true;
  #   createHome = true;
  #   home = "/home/nils";
  #   extraGroups = [ "wheel" "networkmanager" ];
  #   openssh.authorizedKeys.keys =
  #     let
  #       authorizedKeys = pkgs.fetchurl {
  #         url = "https://github.com/tyriis.keys";
  #         sha256 = "HQJOzIzdTcapfYRMueESfmlWGaylteMBLU8AqqwMTS4=";
  #       };
  #     in
  #     pkgs.lib.splitString "\n" (builtins.readFile
  #       authorizedKeys);
  # };
  # users.users.jasmin = {
  #   isNormalUser = true;
  #   createHome = true;
  #   home = "/home/jasmin";
  #   extraGroups = [ "wheel" "networkmanager" ];
  #   openssh.authorizedKeys.keys =
  #     let
  #       authorizedKeys = pkgs.fetchurl {
  #         url = "https://github.com/jazzlyn.keys";
  #         sha256 = "Xeu/F1/mWxWwE4uN+Jar+R25ChQx0EEYZxE0E3Yxj5s=";
  #       };
  #     in
  #     pkgs.lib.splitString "\n" (builtins.readFile
  #       authorizedKeys);
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    htop
    # ok lets add some kubernetes stuff for our NAS
    fluxcd
    # k3s
    kubectl
    kubernetes-helm
    k9s
    cilium-cli
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    # openFirewall = true;
  };

  # Enable zsh.
  programs.zsh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # if this is not disabled cilium does not work and therefore other thinks does not work aswel, but should be fixed
  networking.firewall.enable = false;
  # networking.firewall.allowedTCPPorts = [
  #   22    # SSH
  #   2049  # NFS
  #   6443  # Kubernetes
  # ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  # try to disable powermanagment
  # https://discourse.nixos.org/t/stop-pc-from-sleep/5757
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
  # powerManagement.enable = false;

  # Enable VSCode server
  # https://nixos.wiki/wiki/Visual_Studio_Code#nix-ld
  programs.nix-ld.enable = true;

  # create folder
  # https://discourse.nixos.org/t/adding-folders-and-scripts/5114/4
  systemd.tmpfiles.rules = [
    "d /mnt/volume1/data 0777 root root"
    "d /mnt/volume1/minio 0755 568 568" # 568 is the minio user
  ];
}

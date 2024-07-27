# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,  ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
boot.loader={
      # systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      
      grub={
          configurationLimit = 10;
          enable = true;
          device = "nodev";
          useOSProber = true;
          efiSupport = true;
      };
  };
  
# virtualbox
virtualisation.virtualbox.host.enable = true;

# virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;
virtualisation.docker.enable = true;

virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm; # only emulates host arch, smaller download
        swtpm.enable = true; # allows for creating emulated TPM
        ovmf.packages = [(pkgs.OVMF.override {
          secureBoot = false;
          tpmSupport = true;
        }).fd]; # or use pkgs.OVMFFull.fd, which enables more stuff
      };
};



  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;


  networking.nameservers = [ "208.67.222.222" "208.67.220.220" ];


  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  ##### moving everything related to user to home-manager
  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.thbabua = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "thbabua";
    extraGroups = [
      "qemu-libvirtd"
      "libvirtd"
      "wheel"
      "video"
      "audio"
      "disk"
      "networkmanager"
      "docker"
    ];
    #      packages = with pkgs; [ 
    #      cargo zsh clang gcc fd ripgrep xclip 
    #      lazygit kubernetes-helm kubectl podman home-manager 
    #      ];
  };


  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    kdePackages.kamera
    wget
    file
    git
    jq
    yq
    electron
    curl
    firefox
    teams-for-linux
    vim
    tcpdump
    tmux
    dnsutils
    libsecret
    gnome.gnome-keyring
    cacert
    gnome.seahorse
    tree
    ansible
    # gnome.gnome-disk-utility
    # go
    # zsh
    # alacritty
    # podman
    # kubectl
    # k9s
    # terraform
    # ansible
    # vagrant
    # fzf
    # starship
    # qemu
    # libvirt
    # zoxide
    # stow
    # kubelogin
    # neofetch
    # nodejs
    # azure-cli
    home-manager
  ];

nix.settings.experimental-features = [ "nix-command" "flakes" ];
nix.settings.auto-optimise-store = true;
nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 15d";
	};
# nix.binaryCaches = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];

programs.seahorse.enable=true;
programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
programs.dconf.enable = true;

  # enables zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # services.gnome3.gnome-keyring.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
  # system.copySystemConfiguration = true;

}

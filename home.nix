{ config, pkgs,unstable-pkgs , ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "thbabua";
  home.homeDirectory = "/home/thbabua";
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your environment.
  #
  # home.packages = with pkgs; [
  home.packages = with pkgs; [
    alacritty
    qbittorrent
    openssl
    direnv
    ansible
    azure-cli
    azure-cli-extensions.azure-devops
    azure-cli-extensions.aks-preview
    firefox
    flameshot
    fzf
    git
    gitleaks
    vscode
    copyq
    gnome.gnome-disk-utility
    gnupg
    go
    k9s
    kubectl
    kubelogin
    kubernetes-helm
    lazygit
    libreoffice
    libvirt
    mpv
    neofetch
    neovim
    # unstable-pkgs.neovim
    zip
    obsidian
    pass
    powershell
    python3
    python3.pkgs.pip
    qemu
    virt-manager
    ripgrep
    # rnix-lsp
    starship
    python3
    tig
    tmux
    vagrant
    xclip
    zoxide
    unzip
    zsh
    # vscodium
    gcc
    syncthing
    
    ### neovim dependencies
    python3.pkgs.pynvim


    # #### gaming
    # bottles
    # lutris
    # steam

    #### work related stuff
    go-task
    chromium
    libsForQt5.kamoso
    bruno
    htop
    # popeye
    # kube-score
    jq
    gh
    bfg-repo-cleaner
    # azuredatastudio

    #### hobbies
    parallel
    velero
    ollama
    baobab
    k8sgpt

    

    # (nerdfonts.override { fonts = [ "FiraCode" ]; })
    #   # # Adds the 'hello' command to your environment. It prints a friendly
    #   # # "Hello, world!" when run.
    #
    #   # # It is sometimes useful to fine-tune packages, for example, by applying
    #   # # overrides. You can do that directly here, just don't forget the
    #   # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    #   # # fonts?
    #   # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    #
    #   # # You can also create simple shell scripts directly inside your
    #   # # configuration. For example, this adds a command 'my-hello' to your
    #   # # environment:
  ];



dconf.settings = {
  "org/virt-manager/virt-manager/connections" = {
    autoconnect = ["qemu:///system"];
    uris = ["qemu:///system"];
  };
};

# services.gnome3.gnome-keyring.enable = true;
programs.zsh = {
    enableCompletion=true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
};

  programs.git = {
    enable = true;
    userName = "thbabua";
    userEmail = "";
  };
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/thbabua/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

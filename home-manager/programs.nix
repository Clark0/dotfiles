{
  config,
  pkgs,
  username,
  useremail,
  homeDirectory,
  ...
}: {
  home.packages = with pkgs; [
    hello
    neovim
    git
    just
    neofetch
    wget
    sshs
    htop
    zellij
    lazygit
    bat
    eza
    zoxide
    ripgrep
  ];

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
    ".config/alacritty".source = ./config/alacritty;
    ".config/zellij".source = ./config/zellij;
    ".vimrc".source = ./config/vim/vimrc;
    ".config/tmux".source = ./config/tmux;
    # ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/home-manager/config/zsh/zshrc";
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/home-manager/config/nvim";
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = username;
    userEmail = useremail;
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = {
      l = "eza --icons --git --time-style=long-iso --group --group-directories-first --color-scale=all";
      ll = "l --all --header --long";
      cat = "bat";
      lg = "lazygit";
    };
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "sudo"];
      theme = "dst";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}

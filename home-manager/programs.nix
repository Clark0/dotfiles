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
      lt = "l --tree";
      cat = "bat";
      lg = "lazygit";
    };
    initExtra = ''
      if [ -f ~/.config/zsh/.zshextra ]; then
        source ~/.config/zsh/.zshextra
      fi
    '';
    sessionVariables = {
      PATH="$HOME/.local/bin:$PATH";
    };
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "sudo"];
      theme = "dst";
    };
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.0";
          sha256 = "0s1z3whzwli5452h2yzjzzj27pf1hd45g223yv0v6hgrip9f853r";
        };
      }
    ];
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

{pkgs, ...}: {
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

      # start zellij if using alacritty
      [ -z "$ALACRITTY_LOG" ] || eval "$(zellij setup --generate-auto-start zsh)"
    '';
    sessionVariables = {
      PATH = "$HOME/.local/bin:$PATH";
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
}

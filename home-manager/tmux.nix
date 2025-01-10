{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    historyLimit = 50000;
    terminal = "tmux-256color";
    mouse = true;
    baseIndex = 1;
    plugins = with pkgs; [
      tmuxPlugins.cpu
      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.catppuccin
    ];
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      # set-option -g status-position top
      set -g prefix C-a
      unbind-key C-b
      bind-key C-a send-prefix

      set -g @catppuccin_flavor 'macchiato'
      # Disable catppuccin styling windows.
      set -g @catppuccin_window_status_style "basic"
      set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M:%S"
      set -g @catppuccin_window_current_text "#{pane_current_path}"
      set -g status-left ""
      set -g  status-right "#{E:@catppuccin_status_application}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      set -ag status-right "#{E:@catppuccin_status_user}"
      set -ag status-right "#{E:@catppuccin_status_host}"
      set -ag status-right "#{E:@catppuccin_status_date_time}"

      # set vi-mode
      set-window-option -g mode-keys vi

      bind -n M-h resize-pane -L 5
      bind -n M-j resize-pane -D 5
      bind -n M-k resize-pane -U 5
      bind -n M-l resize-pane -R 5

      # keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}

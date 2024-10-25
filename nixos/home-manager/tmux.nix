{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    historyLimit = 1000000;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    shortcut = "n";
    shell = "${pkgs.zsh}/bin/zsh";
    sensibleOnTop = true;
    plugins = with pkgs.tmuxPlugins; [
      tokyo-night-tmux
      yank
      better-mouse-mode
      {
        plugin = tmux-floax;
        extraConfig = ''
          set -g @floax-width '80%'
          set -g @floax-height '80%'
          set -g @floax-border-color 'magenta'
          set -g @floax-text-color 'blue'
          set -g @sessionx-bind 'o'
        '';
      }
    ];

    extraConfig = ''
      bind-key -T copy-mode-vi v send-keys -X begin-selection

    '';
  };
}
# bind-key -T copy-mode-vi v send-keys -X begin-selection
#
# bind : command-prompt
# set -g detach-on-destroy off     # don't exit from tmux when closing a session
# set -g renumber-windows on
# set -g set-clipboard on
# set -g default-terminal "${TERM}"
# setw -g mode-keys vi
# set -g mouse on
#
# # colors
# set -g status-position top
# set -g status-style bg=default,fg=magenta
#
# # sessions
# bind ^X lock-server
# bind ^D detach
# bind * list-clients
# bind S choose-session
# # set -g @plugin 'tmux-plugins/tmux-resurrect'
# # set -g @plugin 'tmux-plugins/tmux-continuum'
# set -g @plugin 'omerxx/tmux-sessionx'
# set -g @sessionx-x-path '~/dots'
# set -g @sessionx-window-height '85%'
# set -g @sessionx-window-width '75%'
# set -g @sessionx-zoxide-mode 'on'
# set -g @continuum-restore 'on'
# set -g @continuum-save-interval '20'
# set -g @resurrect-strategy-nvim 'session'
#
# # windows
# bind r command-prompt "rename-window %%"
# bind ^C new-window
# bind ^H previous-window
# bind ^L next-window
# bind ^A last-window
# bind ^W list-windows
# bind w list-windows
# bind | split-window
# bind s split-window -v -c "#{pane_current_path}"
# bind v split-window -h -c "#{pane_current_path}"
# bind '"' choose-window
#
# # panes
# bind z resize-pane -Z
# bind h select-pane -L
# bind l select-pane -R
# bind -r -T prefix , resize-pane -L 20
# bind -r -T prefix . resize-pane -R 20
# bind -r -T prefix - resize-pane -D 7
# bind -r -T prefix = resize-pane -U 7
# bind * setw synchronize-panes
# bind P set pane-border-status
# bind c kill-pane
# bind x swap-pane -D
# set -g pane-active-border-style 'fg=magenta,bg=default'
# set -g pane-border-style 'fg=brightblack,bg=default'
# # tmux + neovim
# is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
#     | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
# bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
# bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
# bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
# bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
# tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
# if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
#     "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
# if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
#     "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"
#
# bind-key -T copy-mode-vi 'C-h' select-pane -L
# bind-key -T copy-mode-vi 'C-j' select-pane -D
# bind-key -T copy-mode-vi 'C-k' select-pane -U
# bind-key -T copy-mode-vi 'C-l' select-pane -R
# bind-key -T copy-mode-vi 'C-\' select-pane -l
#
# # terminal
# set-option -g default-terminal 'screen-256color'
# set-option -g terminal-overrides ',xterm-256color:RGB'
#
# # fzf
# set -g @fzf-url-fzf-options '-p 60%,30% --prompt="   " --border-label=" Open URL "'
# set -g @fzf-url-history-limit '2000'
# set -g @plugin 'sainnhe/tmux-fzf'
# set -g @plugin 'wfxr/tmux-fzf-url'
#
# # floating
# set -g @sessionx-bind 'o'


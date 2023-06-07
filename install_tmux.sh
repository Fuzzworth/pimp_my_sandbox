#!/bin/bash

# Install tmux if not already installed
if ! command -v tmux &> /dev/null; then
	echo "Installing tmux..."
	sudo apt-get update
	sudo apt-get install -y tmux
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Content to append to ~/.tmux.conf
content=$(cat <<EOF
# Send prefix
set-option -g prefix C-a
unbind-key C-a
bind-key C-a send-prefix

# Use Alt-arrow keys to switch panes
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Shift arrow to switch windows
bind -n S-Left previous-window
bind -n S-Right next-window

# Mouse mode
setw -g mouse on

# Set easier window split keys
bind-key v split-window -h
bind-key h split-window -v

# Set New Window to PWD
new-window -c "#{pane_current_path}"
bind  c  new-window      -c "#{pane_current_path}"


# Easy config reload
bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded."
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-net-speed'
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'tmux-plugins/tmux-logging'
set -g @plugin 'wfxr/tmux-power'
set -g @plugin 'thewtex/tmux-mem-cpu-load'
# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'github_username/plugin_name#branch'
# set -g @plugin 'git@github.com:user/plugin'
# set -g @plugin 'git@bitbucket.com:user/plugin'
set -g @net_speed_interfaces "wlan0 vmnet1 vmnet8"
set -g @net_speed_format "D:%10s U:%10s"
set -g @tmux_power_theme 'moon'
set -g status-right '#[fg=green]#($TMUX_PLUGIN_MANAGER_PATH/tmux-mem-cpu-load/tmux-mem-cpu-load --colors --powerline-right --interval 2)#[default]'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
EOF
)

echo "$content" >> ~/.tmux.conf

echo "Content appended to ~/.tmux.conf successfully."

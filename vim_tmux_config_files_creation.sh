#!/bin/bash

#This script creates configuration files for tmux, Vim, and aliases for DEBIAN based systems
	#These commands creates three configurations
	
	touch .bash_aliases	

	touch .tmux.conf
	
	touch .vimrc

	mkdir -p $HOME/Documents/scripts

	mkdir -p $HOME/Documents/logs

#Add respective lines to .bash_aliases

	cat <<EOL >> .bash_aliases	

PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '

#HISTCONTROL=ignoredups
# gnome-terminal -- sh -c 'watch "ls /tmp -lht | grep -v systemd"'

#Aliases for easy edition easy access
alias add="vim $HOME/.bash_aliases"
alias catn='cat -n'

#Remote sessions
alias sshadd='vim $HOME/.ssh/config'
alias sshlog="sudo netstat -atnp | grep 'ESTABLISHED.*sshd'"	#Search for ssh connections established
alias sshtail='tail -f /var/log/auth.log'
alias sshconfig="sudo vim /etc/ssh/sshd_config"
alias sshlist="ls -la ~/.ssh"
alias sshrestart="sudo systemctl restart ssh"

alias b="source $HOME/.bashrc"
alias bashgui="gedit $HOME/.bash_aliases" 	#Show .bashrc file in GUI text editor
alias respaldo='cat $HOME/.bash_aliases >> $HOME/Documents/respaldo.txt' 	#Creates a backup of bashrc with the name respaldo file
alias h='history | grep'
alias a='alias | grep'
alias A='cat -n $HOME/.bash_aliases | grep'
alias ba='cat -n $HOME/.bash_aliases | grep'
alias p='PS1=$' #Shorten bash prompt
alias cdbin='cd /usr/local/bin && ls -lh'
alias cdtmp='cd /tmp'
alias cdtest="cd $HOME/Documents/scripts/; ls -lha"
alias cdlog="cd $HOME/Documents/logs/; ls -lha"
alias dirs='dirs -v -l'
alias tailog="cd $HOME/Documents/ && tail -f logs.txt"	#Practical when updating a system and looking the updates live.
alias nanol='nano -l'	#start nano with lines
alias wi='whatis'
alias tmphist='history >> /tmp/hist.txt && lsa'

EOL

#Add respective lines to .tmux.conf file

	cat <<EOL >> .tmux.conf
#Configuration taken from, credits from:
#https://www.learnlinux.tv/learn-tmux-part-5-how-to-customize-tmux-and-make-it-your-own/
# Initial setup
set -g default-terminal xterm-256color
set -g status-keys vi


# use C-j and C-f for the prefix.
set-option -g prefix C-j
set-option -g prefix2 C-f
unbind-key C-j
bind-key C-j send-prefix
set -g base-index 1


# Use Alt-arrow keys without prefix key to switch panes
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D


# Set easier window split keys
bind-key v split-window -h
bind-key h split-window -v


# Shift arrow to switch windows
bind -n S-Left  previous-window
bind -n S-Right next-window


# Easily reorder windows with CTRL+SHIFT+Arrow
bind-key -n C-S-Left swap-window -t -1
bind-key -n C-S-Right swap-window -t +1


# Synchronize panes
bind-key y set-window-option synchronize-panes\; display-message "synchronize mode toggled."


# Easy config reload
bind-key r source-file ~/.tmux.conf \; display-message "tmux.conf reloaded."


# Easy clear history
bind-key L clear-history

# Start history_file
set -g history-file ~/.tmux_history


# Key bindings for copy-paste
setw -g mode-keys vi
unbind p
bind p paste-buffer
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel


# Mouse Mode
set -g mouse on


# Lengthen the amount of time status messages are displayed
set-option -g display-time 3000
set-option -g display-panes-time 3000


# Set the base-index to 1 rather than 0
set -g base-index 1
set-window-option -g pane-base-index 1


# Automatically set window title
set-window-option -g automatic-rename on
set-option -g set-titles on


# Allow the arrow key to be used immediately after changing windows.
set-option -g repeat-time 0


# No delay for escape key press
set -sg escape-time 0


# Theme
set-window-option -g window-status-current-style bold,bg=blue,fg=colour234
set-window-option -g window-status-style fg=colour35
set -g window-status-activity-style bold,bg=colour234,fg=white
set-option -g message-style bg=colour237,fg=colour231
set-option -g pane-border-style fg=colour36
set-option -g pane-active-border-style fg=colour35


# Change background color of a tab when activity occurs
setw -g monitor-activity on


# Do NOT reset the color of the tab after activity stops occuring
setw -g monitor-silence 0


# Disable bell
setw -g monitor-bell off


# Disable visual text box when activity occurs
set -g visual-activity off


# Status Bar
set -g status-justify centre
set -g status-bg black
set -g status-fg colour35
set -g status-interval 60
set -g status-left-length 50
set -g status-left "#[bg=colour35]💻#[fg=colour234,bold] #H#[bg=colour34]#[bg=colour35,nobold]#[fg=colour234] [#S] $tmux_target_lower"
set -g status-right '#[bg=colour35] 🕔 #[fg=colour234,bold]%H:%M '

EOL

#Add respective lines to .vimrc file

	cat <<EOL >> .vimrc
set nu
set clipboard+=unnamedplus
" Uncomment the options if needed 
"" syntax on
"" filetype on
EOL

#Download bash_script_creator

wget https://raw.githubusercontent.com/tenorediforza/bash_script/refs/heads/main/create_new_bash_script.sh || curl https://raw.githubusercontent.com/tenorediforza/bash_script/refs/heads/main/create_new_bash_script.sh > create_new_bash_script.sh

#NOTE:Copy and paste from clipboard feature in VIM. Make sure you have these packages installed:
#	| wl-clipboard |	| xsel |	| xclip |


#Move the two configuration files to home folder

	mv .* $HOME/

	mv create_new_bash_script.sh $HOME/Documents/scripts	

	echo "La comedia è finita"

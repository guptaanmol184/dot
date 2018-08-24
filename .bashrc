#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '

# Enable bash-completion
# Make it conditional
source /usr/share/bash-completion/bash_completion

# convert this into a function
alias ym='youtube-dl --extract-audio --audio-format mp3 '

# Better tab completion in bash
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# configuration files
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'

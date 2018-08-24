#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Add scripts to path
PATH="$PATH:$HOME/scripts"

# alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '

# Enable bash-completion
# Make it conditional
source /usr/share/bash-completion/bash_completion

# Better tab completion in bash
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# Version control my dotfiles
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'


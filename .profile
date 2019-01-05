#!/bin/bash
# Profile file. Runs on login.

# Adds `~/.scripts` and all subdirectories to $PATH
export PATH="$PATH:$(du "$HOME/.scripts/" | cut -f2 | tr '\n' ':')"
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="termite"
export BROWSER="firefox"
export READER="zathura"

# XDG environment variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb=$'\E[01;31m'    # begin bold
export LESS_TERMCAP_md=$'\E[01;31m'    # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\E[0m'        # begin reverse video
export LESS_TERMCAP_so=$'\E[01;44;33m' # reset reverse video
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export LESS_TERMCAP_us=$'\E[01;32m'    # begin underline

# Create .shortcuts
[ ! -f ~/.shortcuts ] && shortcuts >/dev/null 2>&1

# source .bashrc
echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# Start graphical server
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi


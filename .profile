#!/bin/bash
# Profile file. Runs on login.

# Adds `~/.scripts` and all subdirectories to $PATH
export PATH="$HOME/.scripts:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="termite"
export BROWSER="firefox"
export READER="zathura"

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb=$'\E[01;31m'    # begin bold
export LESS_TERMCAP_md=$'\E[01;31m'    # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\E[0m'        # begin reverse video
export LESS_TERMCAP_so=$'\E[01;44;33m' # reset reverse video
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export LESS_TERMCAP_us=$'\E[01;32m'    # begin underline

# source .bashrc
echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# Start graphical server if i3 not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx

#!/bin/bash
# Profile file. Runs on login.

#PATH
appendpath () {
    if [[ ! -d "$1" ]]; then
        echo "Directory does not exist: $1"
        return
    fi
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}
PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | tr '\n' ':')"
#appendpath "$HOME/.pub-cache/bin"
export PATH
unset appendpath

# Adds `~/.scripts` and all subdirectories to $PATH
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"
export READER="zathura"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"

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

# make qt5 applications use gtk2 styles
export QT_QPA_PLATFORMTHEME=gtk2

# Create .shortcuts
[ ! -f ~/.shortcuts ] && shortcuts >/dev/null 2>&1

# source .bashrc
echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# Map caps lock to escape
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

# Start ssh-agent if not already running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

# Start graphical server
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

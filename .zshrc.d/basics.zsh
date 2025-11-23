#!/dev/null

#############################################
#                                           #
#        I stole this from somewhere        #
#        but tbh I have no idea where       #
#                                           #
#############################################

# ~/.zshrc: executed by zsh for interactive shells.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# append to the history file, don't overwrite it
setopt APPEND_HISTORY

# for setting history length
HISTSIZE=1000
SAVEHIST=2000
HISTFILE=~/.zsh_history

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable zsh completion
autoload -Uz compinit && compinit

# case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

LS_COLORS=$LS_COLORS:'ln=1;32:ow=1;34:' ; export LS_COLORS

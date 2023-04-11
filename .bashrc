# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

git config --global credential.helper 'cache --timeout=3600'

bind 'set completion-ignore-case on'

LS_COLORS=$LS_COLORS:'ln=1;32:ow=1;34:' ; export LS_COLORS
# export PS1="\[\e[01;38;5;198m\](\@)\[\e[0m\] \[\e[01;38;5;46m\]\h\[\e[0m\]:\[\e[01;38;5;33m\]\W\[\e[0m\] "

function gitbranch() {
	str="$(git branch 2>/dev/null | grep '^*' | sed s/..//)"
	if [ -z "$str" ]
	then
		branch=""
	else
		branch=" [$str]"
	fi
	echo "$branch"
}
export PS1='$(printf "%s%s \n$ " "\[\e[01;38;5;198m\](\@)\[\e[0m\] \[\e[01;38;5;46m\]\h\[\e[0m\]:\[\e[01;38;5;33m\]\W\[\e[0m\]" "\[\e[01;38;5;198m\]$(gitbranch)\[\e[0m\]")'

function colors() {
    iter=16
    while [ $iter -lt 52 ]
    do
        second=$[$iter+36]
        third=$[$second+36]
        four=$[$third+36]
        five=$[$four+36]
        six=$[$five+36]
        seven=$[$six+36]
        if [ $seven -gt 250 ];then seven=$[$seven-251]; fi

        echo -en "\033[38;5;$(echo $iter)m█ "
        printf "%03d" $iter
        echo -en "   \033[38;5;$(echo $second)m█ "
        printf "%03d" $second
        echo -en "   \033[38;5;$(echo $third)m█ "
        printf "%03d" $third
        echo -en "   \033[38;5;$(echo $four)m█ "
        printf "%03d" $four
        echo -en "   \033[38;5;$(echo $five)m█ "
        printf "%03d" $five
        echo -en "   \033[38;5;$(echo $six)m█ "
        printf "%03d" $six
        echo -en "   \033[38;5;$(echo $seven)m█ "
        printf "%03d" $seven

        iter=$[$iter+1]
        printf '\r\n'
    done
}

bind '"\e[1;5D" backward-word'
bind '"\e[1;5C" forward-word'

function up() {
	cd $(eval printf '../'%.0s {1..$1})
}

# All my aliases and exports

export PATH=$PATH:~/.bash
export PATH=$PATH:/usr/games

export TEXINPUTS=".:~/.latex:"

export UNAME=$(uname)

alias sml='rlwrap sml'
alias ocaml='rlwrap ocaml'
alias smlnj='rlwrap sml'
alias coin='rlwrap coin'
alias python='python3'
alias pip='pip3.10'

alias pls='sudo $(history -p !!)'
alias la='ls -a'
alias clr='clear'
alias root='cd /'
alias diff='diff --color'
alias units='units -v -1'

alias :q='exit'

function init () {
	if [ $1 == "tex" ]
	then
		cp ~/Files/.templates/tex/document.tex $2.tex
	elif [ $1 == "style" ]
	then
		cp ~/Files/.templates/tex/mystyle.sty ~/texmf/tex/latex/mystyle.sty
	elif [ $1 == "beamer" ]
	then
		cp ~/Files/.templates/tex/beamer.tex $2.tex
	elif [ $1 == "cheatsheet" ]
	then
		cp ~/Files/.templates/tex/cheatsheet.tex $2.tex
	else
		echo "Template type is invalid"
	fi
}

alias edit='vim'
alias vimrc='vim ~/dotfiles/.vimrc'
alias bashrc='vim ~/dotfiles/.bashrc'
alias srcbash='source ~/.bashrc'

# Fortunes
function wisecow() {
	fortune "$@" | cowsay -n -W -1
}
function speakfortune() {
	fortune "$@" > /tmp/fortune.txt
	cat /tmp/fortune.txt | pico2wave -w=/tmp/test.wav
	cat /tmp/fortune.txt | cowsay
	aplay /tmp/test.wav
	rm /tmp/fortune.txt
	rm /tmp/test.wav
}
function newfortune() {
	sudo touch /usr/share/games/fortunes/$1
	sudo touch /usr/share/games/fortunes/$1.dat
	sudo chown soumilm /usr/share/games/fortunes/$1*
	sudo chgrp soumilm /usr/share/games/fortunes/$1*
}
wisecow

function Hello () {
	if [ "$1" = "There" ]; then
		echo "General Kenobi"
	fi
}

function cleantex () {
  rm *.fls
  rm *.out
  rm *.fdb_latexmk
  rm *.log
  rm *.aux
}

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

alias gst='git status'
alias ga='git add'
alias gd='git diff'
alias gds='git diff --staged'
alias commits='git log --oneline | head'
alias hash='git rev-parse HEAD'

alias sl='ls'

case "$(uname -sr)" in
   Darwin*)
     source "$HOME/dotfiles/.work_bashrc" # this file intentionally not checked in
     alias x='open'
     alias opendir='open .'
     ;;

   Linux*)
     alias x='xdg-open'
     alias opendir='xdg-open .'
     alias pbcopy='xclip -selection clipboard'
     alias pbpaste='xclip -selection clipboard -o'
     ;;

   *)
     echo 'OS unknown'
     ;;
esac

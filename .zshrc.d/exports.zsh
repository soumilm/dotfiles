#! /dev/null

export GOPATH=$HOME/go

export PATH=~/.zsh:$PATH
export PATH=/usr/games:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/dotfiles/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
# Added by flyctl installer
export FLYCTL_INSTALL="/home/soumilm/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

precmd() {
    fc -W  # Write history to file after each command
}

export TEXINPUTS=".:~/.latex:"

export UNAME=$(uname)

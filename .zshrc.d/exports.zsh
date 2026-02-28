#! /dev/null

export GOPATH=$HOME/go

export PATH=~/.zsh:$PATH
export PATH=/usr/games:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=/usr/local/bin:$PATH

precmd() {
    fc -W  # Write history to file after each command
}

export TEXINPUTS=".:~/.latex:"

export UNAME=$(uname)

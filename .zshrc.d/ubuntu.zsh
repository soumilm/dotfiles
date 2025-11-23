#!/dev/null

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

export OPEN='xdg-open'
alias x=$OPEN
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
export FORTUNES="/usr/share/games/fortunes"
alias claude='npm i -g @anthropic-ai/claude-code; claude'

function newfortune() {
  sudo touch $FORTUNES/$1
  sudo touch $FORTUNES/$1.dat
  sudo chown soumilm $FORTUNES/$1*
  sudo chgrp soumilm $FORTUNES/$1*
}

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

#!/dev/null

export OPEN='open'
alias x=$OPEN
export FORTUNES="/opt/homebrew/Cellar/fortune/9708/share/games/fortunes"

# Enable zsh completions from homebrew
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit && compinit
fi

alias ls='ls -G'

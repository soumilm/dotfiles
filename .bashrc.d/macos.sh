#!/dev/null

export OPEN='open'
alias x=$OPEN
export FORTUNES="/opt/homebrew/Cellar/fortune/9708/share/games/fortunes"
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
alias ls='ls -G'

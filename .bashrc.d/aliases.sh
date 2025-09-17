#!/dev/null

function up() {
	cd $(eval printf '../'%.0s {1..$1})
}

alias python='python3'
if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
fi

alias la='ls -A'
alias clr='clear'
alias diff='diff --color'
alias less='less -r'
alias units='units -v -1'

alias :q='exit'

export EDITOR=nvim
export GIT_EDITOR=$EDITOR

alias vim=$EDITOR
alias viml="$EDITOR --listen /tmp/nvim"
alias bashrc="$EDITOR ~/dotfiles/.bashrc"
alias srcbash='source ~/.bashrc'
alias dotfiles="cd ~/dotfiles"

function wisecow() {
	fortune "$@" | cowsay -n -W -1
}

alias ga='git num add'
alias gd='git num diff'
alias gds='git num diff --staged'
alias grst='git num restore'
alias what='git num convert'
function gv () {
  $EDITOR "$(git num convert "$1")"
}
function gst () {
  git num
}

alias commits='git log --oneline | head'
alias hash='git rev-parse HEAD'

alias sl='ls'

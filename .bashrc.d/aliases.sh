#!/dev/null

function up() {
	cd $(eval printf '../'%.0s {1..$1})
}

alias python='python3'
alias cat='bat'

alias la='ls -A'
alias clr='clear'
alias diff='diff --color'
alias less='less -r'
alias units='units -v -1'

alias :q='exit'

alias vim='nvim'
alias bashrc="$EDITOR ~/dotfiles/.bashrc"
alias srcbash='source ~/.bashrc'
alias dotfiles='cd ~/dotfiles'

function wisecow() {
	fortune "$@" | cowsay -n -W -1
}

alias ga='git num add'
alias gd='git num diff'
alias gds='git num diff --staged'
alias grst='git num restore'
alias what='git num convert'
function gv () {
  vim "$(git num convert "$1")"
}
function gst () {
  git num
}

alias commits='git log --oneline | head'
alias hash='git rev-parse HEAD'

alias sl='ls'

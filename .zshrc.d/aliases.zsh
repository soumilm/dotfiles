#!/dev/null

function up() {
    local d=""
    local count=${1:-1}
    for ((i=1; i<=count; i++)); do
        d="../$d"
    done
    cd "$d"
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
alias zshrc="$EDITOR ~/dotfiles/.zshrc"
alias src='source ~/.zshrc'
alias dotfiles="cd ~/dotfiles"

function wisecow() {
	fortune "$@" | cowsay -n -W -1
}

alias ga='git num add'
alias gd='git num diff'
alias gdw='git num diff -w'
alias gds='git num diff --staged'
alias gdsw='git num diff --staged -w'
alias grst='git num restore'
alias what='git num convert'
alias gcan='git commit --amend --no-edit'
alias gpf='git push -f'
alias grim='git rebase -i master'
alias stash='git num stash push'
function gv () {
  $EDITOR "$(git num convert "$1")"
}
function gst () {
  git num
}

alias commits='git log --oneline | head'
alias hash='git rev-parse HEAD'

function merged() {
  case "$1" in
    ""|delete) ;;
    *)
      echo "Usage: merged [delete]"
      return 1
      ;;
  esac
  git fetch -p >/dev/null 2>&1
  local branches=$(git branch -vv | grep ": gone]" | awk '{if ($1 == "*") print $2; else print $1}')
  if [[ -z "$branches" ]]; then
    echo "No branches with gone remotes."
    return 0
  fi
  case "$1" in
    "")
      echo "$branches"
      ;;
    delete)
      git checkout main 2>/dev/null || git checkout master
      git pull >/dev/null 2>&1 &
      echo "$branches" | xargs git branch -D
      wait
      ;;
  esac
}

alias sl='ls'

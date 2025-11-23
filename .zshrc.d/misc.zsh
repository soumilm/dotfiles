#!/dev/null

function reattach-tmux () {
  if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
  fi
}

function print-wisecow () {
  # Check if cowsay and fortune commands exist
  if command -v cowsay > /dev/null && command -v fortune > /dev/null; then
    wisecow
  fi
}

if [ "$TERM_PROGRAM" != "vscode" ] && [ -z "$CLAUDECODE" ]; then
  reattach-tmux
  print-wisecow
fi

source <(fzf --zsh)

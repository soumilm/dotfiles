#!/dev/null

function reattach-tmux () {
  tmux attach -t default || tmux new -s default
}

function print-wisecow () {
  # Check if cowsay and fortune commands exist
  if command -v cowsay > /dev/null && command -v fortune > /dev/null; then
    wisecow
  fi
}

if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ]; then
  reattach-tmux
  print-wisecow
fi

# Check if cowsay and fortune commands exist
if command -v cowsay > /dev/null && command -v fortune > /dev/null && [ -z "$CLAUDECODE" ]; then
  wisecow
fi

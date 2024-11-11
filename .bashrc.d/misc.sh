#!/dev/null

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default
fi

# Check if cowsay and fortune commands exist
if command -v cowsay > /dev/null && command -v fortune > /dev/null; then
  wisecow
fi

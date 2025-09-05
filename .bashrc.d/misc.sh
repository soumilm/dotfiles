#!/dev/null

if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ]; then
  tmux attach -t default || tmux new -s default
fi

# Check if cowsay and fortune commands exist
if command -v cowsay > /dev/null && command -v fortune > /dev/null && [ -z "$CLAUDECODE" ]; then
  wisecow
fi

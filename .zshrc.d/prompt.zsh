#!/dev/null

function gitbranch() {
    local str="$(git branch 2>/dev/null | grep '^*' | sed s/..//)"
    if [ -z "$str" ]; then
        branch=""
    else
        branch=" [$str]"
    fi
    echo "$branch"
}

# zsh prompt with git branch
# %F{color} / %f for foreground colors
# %~ for current directory, %n for username, %m for hostname
setopt PROMPT_SUBST  # Enable command substitution in prompt
PROMPT=$'%F{198}(%D{%-I:%M%p})%f %F{46}%m%f:%F{33}%1~%f%F{198}$(gitbranch)%f \n$ '

if [ -z "$CLAUDECODE" ]; then
  # Key bindings for word navigation
  bindkey '^[[1;5D' backward-word  # Ctrl+Left
  bindkey '^[[1;5C' forward-word   # Ctrl+Right
fi

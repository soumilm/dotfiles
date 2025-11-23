#!/dev/null

function gitbranch() {
	str="$(git branch 2>/dev/null | grep '^*' | sed s/..//)"
	if [ -z "$str" ]
	then
		branch=""
	else
		branch=" [$str]"
	fi
	echo "$branch"
}
export PS1='$(printf "%s%s \n$ " "\[\e[38;5;198m\](\@)\[\e[0m\] \[\e[38;5;46m\]\h\[\e[0m\]:\[\e[38;5;33m\]\W\[\e[0m\]" "\[\e[38;5;198m\]$(gitbranch)\[\e[0m\]")'

if [ -z "$CLAUDECODE" ]; then
  bind '"\e[1;5D" backward-word'
  bind '"\e[1;5C" forward-word'
fi

package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
	"syscall"

	"github.com/charmbracelet/bubbles/key"
	"github.com/charmbracelet/huh"
)

const newSessionValue = "__new__"

func main() {
	sessions, err := tmuxSessions()
	if err != nil {
		fmt.Fprintf(os.Stderr, "failed to list tmux sessions: %v\n", err)
		os.Exit(1)
	}

	var selected string

	var opts []huh.Option[string]
	for _, s := range sessions {
		name := strings.SplitN(s, ":", 2)[0]
		opts = append(opts, huh.NewOption(s, name))
	}
	opts = append(opts, huh.NewOption("+ New session", newSessionValue))

	km := huh.NewDefaultKeyMap()
	km.Select.Next = key.NewBinding(key.WithKeys("enter", " "), key.WithHelp("enter/space", "select"))
	km.Select.Submit = key.NewBinding(key.WithKeys("enter", " "), key.WithHelp("enter/space", "submit"))

	err = huh.NewForm(
		huh.NewGroup(
			huh.NewSelect[string]().
				Title("Pick a tmux session").
				Options(opts...).
				Value(&selected),
		),
	).WithKeyMap(km).Run()
	if err != nil {
		if err.Error() == "user aborted" {
			os.Exit(0)
		}
		fmt.Fprintf(os.Stderr, "error: %v\n", err)
		os.Exit(1)
	}

	tmuxPath, err := exec.LookPath("tmux")
	if err != nil {
		fmt.Fprintf(os.Stderr, "tmux not found: %v\n", err)
		os.Exit(1)
	}

	if selected == newSessionValue {
		var name string
		err = huh.NewForm(
			huh.NewGroup(
				huh.NewInput().
					Title("Session name").
					Value(&name),
			),
		).Run()
		if err != nil {
			if err.Error() == "user aborted" {
				os.Exit(0)
			}
			fmt.Fprintf(os.Stderr, "error: %v\n", err)
			os.Exit(1)
		}
		name = strings.TrimSpace(name)
		if name == "" {
			fmt.Fprintln(os.Stderr, "session name cannot be empty")
			os.Exit(1)
		}
		syscall.Exec(tmuxPath, []string{"tmux", "new-session", "-s", name}, os.Environ())
		return
	}

	// Inside tmux: switch client. Outside: attach.
	if os.Getenv("TMUX") != "" {
		syscall.Exec(tmuxPath, []string{"tmux", "switch-client", "-t", selected}, os.Environ())
	} else {
		syscall.Exec(tmuxPath, []string{"tmux", "attach-session", "-t", selected}, os.Environ())
	}
}

func tmuxSessions() ([]string, error) {
	out, err := exec.Command("tmux", "ls").Output()
	if err != nil {
		return nil, err
	}

	var sessions []string
	for _, line := range strings.Split(strings.TrimSpace(string(out)), "\n") {
		if line != "" {
			sessions = append(sessions, line)
		}
	}
	return sessions, nil
}

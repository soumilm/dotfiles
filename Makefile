CMDS := $(notdir $(wildcard cmd/*))
LINKS := $(addprefix bin/,$(CMDS))

.PHONY: links clean

# Ensure bin/<name> -> _go-run symlinks exist for every cmd/<name>.
# Binaries are built on demand by bin/_go-run into a cache dir, not here.
links: $(LINKS)

bin/%:
	ln -sf _go-run $@

clean:
	rm -rf $${XDG_CACHE_HOME:-$$HOME/.cache}/dotfiles-go

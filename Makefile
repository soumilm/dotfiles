CMDS := $(notdir $(wildcard cmd/*))
BINS := $(addprefix bin/,$(CMDS))

.PHONY: all clean

all: $(BINS)

bin/%: cmd/%/*.go go.mod
	go build -o $@ ./cmd/$*

clean:
	rm -f $(BINS)

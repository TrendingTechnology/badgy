SHELL = /bin/bash

prefix ?= /usr/local
bindir ?= $(prefix)/bin
libdir ?= $(prefix)/lib
srcdir = Sources

REPODIR = $(shell pwd)
BUILDDIR = $(REPODIR)/.build
SOURCES = $(wildcard $(srcdir)/**/*.swift)

.DEFAULT_GOAL = all

.PHONY: all
all: badgy_build

badgy_build: $(SOURCES)
	@swift build \
		-c release \
		--disable-sandbox \
		--build-path "$(BUILDDIR)"

.PHONY: install
install: badgy_build
	@install -d "$(bindir)" "$(libdir)"
	@install "$(BUILDDIR)/release/badgy" "$(bindir)"

.PHONY: uninstall
uninstall:
	@rm -rf "$(bindir)/badgy"

.PHONY: clean
distclean:
	@rm -f $(BUILDDIR)/release

.PHONY: clean
clean: distclean
	@rm -rf $(BUILDDIR)


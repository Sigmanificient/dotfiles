ifneq ($(shell whoami), sigmanificient)
   $(error This makefile is meant as a personal way to install my dotfiles)
endif

CMD_NOT_FOUND = $(error $(strip $(1)) is required for this rule)
CHECK_CMD = $(if $(shell command -v $(1)),, $(call CMD_NOT_FOUND, $(1)))
CHECK_CMDS = $(foreach cmd, $(1), $(call CHECK_CMD, $(1)))

DEPS := ._deps.lock
INSTALL := ._install.lock

DEPS_DIR := $(HOME)/deps
WALLPAPER := $(HOME)/Pictures/wallpaper.png

HOME_FOLDERS := $(HOME)/Pictures
HOME_FOLDERS := $(HOME)/Pictures/screenshots
HOME_FOLDERS += $(HOME)/Desktop
HOME_FOLDERS += $(HOME)/Downloads

REPO_NAME := Sigmanificient/dotfiles.git
BARE_REPO_DIR := $(HOME)/.git

GIT := /usr/bin/git
YAY := /usr/bin/yay
B_LOCKSCREEN := /usr/bin/betterlockscreen

all: $(INSTALL)

$(BARE_REPO_DIR): $(GIT)
	@ $(GIT) clone --bare https://github.com/$(REPO_NAME) $@
	@ $(GIT) --git-dir=$@ --work-tree=$(HOME) remote set-url origin git@github.com:$(REPO_NAME)
	@ $(GIT) config --local core.bare false
	@ $(GIT) pull
	@ $(GIT) init

$(HOME_FOLDERS):
	@ mkdir -p $@

$(GIT):
	$(call CHECK_CMDS, pacman sudo)
	@ sudo pacman -Sy git

$(YAY): $(GIT)
	$(call CHECK_CMD, makepkg)
	@ $(GIT) clone https://aur.archlinux.org/yay.git
	@ cd yay && makepkg -si
	@ touch $@

$(DEPS): $(shell find $(DEPS_DIR) -type f -name "*.deps") $(YAY)
	$(call CHECK_CMD, yay)
	@ $(YAY) -Sy $(shell cat $(HOME)/deps/*)
	@ touch $@

$(WALLPAPER):
	@ cp $(HOME)/assets/wallpaper.png $(WALLPAPER)

$(INSTALL): $(DEPS) $(BARE_REPO_DIR) $(HOME_FOLDERS)
	$(call CHECK_CMD, $(B_LOCKSCREEN))
	@ $(B_LOCKSCREEN) -u $(WALLPAPER)
	@ touch $@

clean:
	@ $(RM) $(DEPS) $(INSTALL)

re:	clean all

.PHONY: clean re

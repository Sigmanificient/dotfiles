CMD_NOT_FOUND = $(error `$(strip $(1))` is required for this rule)

CHECK_CMD = $(if $(shell command -v $(1)),,$(call CMD_NOT_FOUND,$(1)))
CHECK_CMDS = $(foreach cmd, $(1), $(call CHECK_CMD, $(cmd)))

all: install

restart:
	$(call CHECK_CMD, qtile)
	@ qtile cmd-obj -o cmd -f restart

.PHONY: restart

clean:
	$(call CHECK_CMD, find)
	@ find -type d -name __pycache__  -exec rm -rf {} +

.PHONY: clean

install:
	$(call CHECK_CMD, qtile)
	@ cp -r * ~/.config/qtile
	@ qtile cmd-obj -o cmd -f reload_config
	@ $(MAKE) -s restart

.PHONY: install

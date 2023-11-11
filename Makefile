HOME_DIR=$(HOME)
CONF_DIR=$(HOME_DIR)/.config
SCRIPT_DIR=$(HOME_DIR)/.local/bin

HOME_DOTFILES = bashrc imwheelrc profile tmux.conf vimrc Xresources zshrc
CONF_DOTFILES = i3 ranger zathura

.PHONY: *

all: home config scripts

init: sync home config scripts

home: $(HOME_DOTFILES)
config: $(CONF_DOTFILES)

scripts:
	@ln -sfv $(PWD)/scripts/* $(SCRIPT_DIR)/

$(HOME_DOTFILES):
	@ln -sfv $(PWD)/$@ $(HOME_DIR)/.$@

$(CONF_DOTFILES):
	@rm -rf $(CONF_DIR)/$@
	@ln -sv $(PWD)/$@ $(CONF_DIR)/$@

sync: 
	git submodule update --recursive

check:
	@echo "--- CHCKING DEAD LINKS ---"
	@find $(HOME_DIR) -maxdepth 1 -xtype l
	@find $(CONF_DIR) -maxdepth 1 -xtype l
	@find $(SCRIPT_DIR) -maxdepth 1 -xtype l
	@echo "---    DONE CHCKING    ---"

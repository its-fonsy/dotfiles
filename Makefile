HOME_DIR=$(HOME)
CONF_DIR=$(HOME_DIR)/.config

HOME_DOTFILES = profile tmux.conf vimrc zshrc
CONF_DOTFILES = ranger zathura nvim sway waybar foot

.PHONY: *

all: home config

init: all

home: $(HOME_DOTFILES)
config: $(CONF_DOTFILES)

$(HOME_DOTFILES):
	@ln -sfv $(PWD)/$@ $(HOME_DIR)/.$@

$(CONF_DOTFILES):
	@rm -rf $(CONF_DIR)/$@
	@ln -sv $(PWD)/$@ $(CONF_DIR)/$@

check:
	@echo "--- CHECKING DEAD LINKS ---"
	@find $(HOME_DIR) -maxdepth 1 -xtype l
	@find $(CONF_DIR) -maxdepth 1 -xtype l
	@echo "---    DONE CHECKING    ---"

# ███████╗ ██████╗ ███╗   ██╗███████╗██╗   ██╗
# ██╔════╝██╔═══██╗████╗  ██║██╔════╝╚██╗ ██╔╝
# █████╗  ██║   ██║██╔██╗ ██║███████╗ ╚████╔╝
# ██╔══╝  ██║   ██║██║╚██╗██║╚════██║  ╚██╔╝
# ██║     ╚██████╔╝██║ ╚████║███████║   ██║
# ╚═╝      ╚═════╝ ╚═╝  ╚═══╝╚══════╝   ╚═╝
#
# file: .zshrc
# github: its-fonsy/dotfiles

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
export PS1

# Sources shortcuts and aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# History Search
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^R" history-beginning-search-backward-end
bindkey "^T" history-beginning-search-forward-end

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Aliases
alias ls='ls -lh --color=auto --group-directories-first'
alias grep='grep --color'
alias cls='clear'
alias n="neomutt"
alias shutdown="shutdown -h 0"
alias reboot="shutdown -r 0"
alias grub-up='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias backup='sudo ~/.local/bin/backup'
alias nas-mount='sudo mount -t cifs //nas-backup/admin /nas -o user=admin,vers=1.0'
alias r='ranger'
alias blitz="wine '/home/fonsy/Games/Blitz/drive_c/users/fonsy/Local Settings/Application Data/Blitz/Blitz.exe' && exit"
alias imwheel="imwheel --kill -b 45"
alias lol="sudo sh -c 'sysctl -w abi.vsyscall32=0'"
#alias drivep='CUR_DIR=$(pwd); cd ~/gdrive && drive push && cd $CUR_DIR'

#source $HOME/.config/shortcuts

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null


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
PS1="┌%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}
└─$%b "
export PS1

# Remove .xsession-errors
[ -e $HOME/.xsession-errors ] && rm $HOME/.xsession-errors

# GPG stuff
GPG_TTY=$(tty)
export GPG_TTY

# Sources shortcuts and aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc/aliasrc"

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# If history doesn't exist create it
if test ! -e $HISTFILE
then
	mkdir -p "${HISTFILE%/*}"
	touch "$HISTFILE"
fi

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

# NNN configuration
export NNN_OPENER=opener
function n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn -E "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

function ard ()
{
	# usage: ardu ARDUINO PORT SKETCH

	[ -x "$(command -v arduino-cli)" ] || { echo "arduino-cli not installed"; return 1; }
	
	case "$1" in
		"nano")
			board="arduino:avr:nano:cpu=atmega328old"
			;;
		"uno")
			board="arduino:avr:uno"
			;;
		*)
			echo "usage: ardu BOARD PORT SKETCH"
			return 1
			;;
	esac

	{ echo "[COMPILING]"; arduino-cli compile --fqbn $board $3; } && \
		{  echo "[UPLOADING]"; arduino-cli upload -p $2 --fqbn $board $3; } && \
		echo "done"
}

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

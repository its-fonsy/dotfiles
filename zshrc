# Enable colors and change prompt:
autoload -U colors && colors
setopt autocd
stty stop undef

# Prompt
setopt PROMPT_SUBST
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true

zstyle ':vcs_info:*' formats '(%F{green}%u%c%b%f) '
zstyle ':vcs_info:*' unstagedstr '%f%F{red}'
zstyle ':vcs_info:*' stagedstr '%f%F{yellow}'
precmd () { vcs_info }

PROMPT='${vcs_info_msg_0_}[%F{cyan}%n%f @ %3~] $ '

# Remove .xsession-errors
[ -e $HOME/.xsession-errors ] && rm $HOME/.xsession-errors

# GPG stuff
GPG_TTY=$(tty)
export GPG_TTY

# aliases
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
alias gpg2='gpg2 --homedir "$XDG_DATA_HOME"/gnupg'

alias gst='git status'
alias gcm='git commit'
alias gdf='git diff'
alias gad='git add'

alias r='ranger'
alias v='vim .'
alias imwheel='imwheel --kill -b 45'
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias cls="clear"
alias grep="grep --color"

alias ls="ls --color=auto"
alias la="ls -a --color=auto"
alias ll="ls -lh --color=auto --group-directories-first"
alias lla="ls -lah --color=auto --group-directories-first"

# History in cache directory:
HISTFILE=$XDG_CACHE_HOME/zsh/history
HISTSIZE=10000
SAVEHIST=10000

if ! [ -f $HISTFILE ]; then
    mkdir -p "${HISTFILE%/*}"
    touch "$HISTFILE"
fi

# zoxide
_ZO_DATA_DIR=$XDG_DATA_HOME/.local/share
_ZO_ECHO=1
_ZO_RESOLVE_SYMLINKS=1
eval "$(zoxide init zsh)"

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

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
autoload -Uz compinit && compinit

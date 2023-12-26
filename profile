#!/usr/bin/zsh

# zsh profile file. Runs on login. Environmental variables are set here.

# PATH folders
export PATH=$PATH:$HOME/.local/bin/
export PATH=$PATH:$HOME/.local/bin/fonsy/
export PATH=$PATH:$HOME/.local/share/cargo/bin/
export PATH=$PATH:/opt/riscv/bin

# LaTeX env-vars
export PATH=$PATH:$HOME/.local/opt/texlive/2023/bin/x86_64-linux
export MANPATH=$MANPATH:$HOME/.local/opt/texlive/2023/texmf-dist/doc/man
export INFOPATH=$INFOPATH:$HOME/.local/opt/texlive/2023/texmf-dist/doc/info

# Default programs:
export EDITOR="vim"
export TERMINAL="xterm"
export BROWSER="firefox"
export LYRICS_DIR="/media/musica/lyrics"

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

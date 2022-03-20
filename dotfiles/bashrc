# ███████╗ ██████╗ ███╗   ██╗███████╗██╗   ██╗
# ██╔════╝██╔═══██╗████╗  ██║██╔════╝╚██╗ ██╔╝
# █████╗  ██║   ██║██╔██╗ ██║███████╗ ╚████╔╝
# ██╔══╝  ██║   ██║██║╚██╗██║╚════██║  ╚██╔╝
# ██║     ╚██████╔╝██║ ╚████║███████║   ██║
# ╚═╝      ╚═════╝ ╚═╝  ╚═══╝╚══════╝   ╚═╝
#
# file: bashrc
# github: its-fonsy/dotfiles

# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Nice looking terminal
#PS1="[\[$(tput sgr0)\]\[\033[38;5;111m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;203m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] - \[$(tput sgr0)\]\[\033[38;5;82m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] ]\\$ \[$(tput sgr0)\]"
export PS1="[\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;114m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;228m\]\h\[$(tput sgr0)\] - \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;137m\]\w\[$(tput sgr0)\] ] \n $ \[$(tput sgr0)\]"
#PS1="[ $(tput bold)\u$(tput sgr0)@\h - \w]\n $ \[$(tput sgr0)\]"
export PS1

# Default Programs
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="brave"

# Import colorscheme from 'wal' asynchronously
(cat ~/.cache/wal/sequences &)
cat ~/.cache/wal/sequences
source ~/.cache/wal/colors-tty.sh

# Path
export PATH="$HOME/.local/bin:$PATH"

# Aliases
alias ls='ls -l --color=auto'
alias grep='grep --color'
alias cls='clear'
alias n="neomutt"
alias sd="shutdown -h 0"
alias grub-up='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias backup='sudo ~/.local/bin/backup'
alias nas-mount='sudo mount -t cifs //nas-backup/admin /nas -o user=admin,vers=1.0'
alias drivep='CUR_DIR=$(pwd); cd ~/gdrive && drive push && cd $CUR_DIR'
alias r='ranger'
alias blitz="wine '/home/fonsy/Games/Blitz/drive_c/users/fonsy/Local Settings/Application Data/Blitz/Blitz.exe' && exit"
alias imwheel="imwheel --kill -b 45"
alias lol="sudo sh -c 'sysctl -w abi.vsyscall32=0'"

# Shortcut
# ! Remember to export EDITOR before sourcing the shortcuts
source $HOME/.config/shortcuts

export QSYS_ROOTDIR="/media/quartus/quartus/sopc_builder/bin"

source /home/fonsy/.config/broot/launcher/bash/br

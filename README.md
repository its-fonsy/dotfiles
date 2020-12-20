# dotfiles
Github repo of my dotfiles!
![screenshot](screen.png "screenshot")

# Install
For a fast installation of dotfiles use GNU `stow`. Once installed simply run

	$ stow home config local

# My configuration

+ **Window manager** `bspwm`
+ **Terminal** `alacritty`
+ **compositor** `picom`
+ **Shell** `zsh` (I also have a `.bashrc`, just in case something goes wrong)
+ **Notification Manager** `dunst`

# Utilities 

+ **Editor** Neovim
+ **Music Player** `mpd` and `ncmpcpp`
+ **File manager** `nnn`

# Scripts
All the scripts are in `local/.local/bin`.

+ `chaudio`: using `dmenu` to select the audio interface to use
+ `chnet`: using `dmenu` to select the internet interface to use
+ `shortcuts`: with `folderc` and `configrc` (in `.config`) make shortcuts for shell and `ranger`
+ `wallp`: choose randomly a wallpaper

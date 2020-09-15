# dotfiles
Using Github to manage and track my dotfiles.

# Install
For a fast installation of dotfiles use GNU `stow`. Once installed simply run

	$ stow home config local

# My configuration

+ **Shell** `zsh` (I also have a `.bashrc`, just in case something goes wrong)
+ **Editor** Neovim (there is also `.vimrc` in `config/vim`)
+ **Music Player** `mpd` and `ncmpcpp`
+ **Notification Manager** `dunst`
+ **File manager** `nnn`

# Scripts
All the scripts are in `local/.local/bin`.

+ `chaudio`: using `dmenu` to select the audio interface to use
+ `chnet`: using `dmenu` to select the internet interface to use
+ `shortcuts`: with `folderc` and `configrc` (in `.config`) make shortcuts for shell and `ranger`
+ `wallp`: choose randomly a wallpaper

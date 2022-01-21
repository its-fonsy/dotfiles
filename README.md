# dotfiles
Github repo of my dotfiles handled with [dotbot](https://github.com/anishathalye/dotbot)!

[screenshot](screenshot.png)

In the screenshot above you can see [my fork of dwm](https://github.com/its-fonsy/dwm),
in this repo you can find all the configs of other programs that I use daily.

# Install

First thing to do is to install dwm

	git clone https://github.com/its-fonsy/dwm
	cd dwm
	sudo make clean install

next install configs files 

	cd ..
	git clone https://github.com/its-fonsy/dotfiles.git
	./install desktop scripts

If you are curious how the script works check [dotbot](https://github.com/anishathalye/dotbot)
(I've also modified it to be more modular following
[this](https://github.com/anishathalye/dotbot/pull/11#issuecomment-73082152) issue).

# Configuration

## DWM 6.3

I wonted to use as little patches as possible to stay aligned with the suckless
philosophy. The one that I installed are:

+ fullgaps
+ alwayscenter
+ scratchpads
+ systray

I changed the colorschem to [Dracula](https://draculatheme.com/) and some keybindings.
To see all of them give a look at the source code of the
[dwm repo](https://github.com/its-fonsy/dwm).

I use rofi as an application launcher (<kbd>MOD</kbd>+<kbd>R</kbd>) and
as a powermenu (<kbd>MOD</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>).

## Others

General programs that I use daily are:

+ **Terminal**: `alacritty`
+ **Shell**: `zsh`
+ **Editor**: `neovim`
+ **Bar**: `slstatus`
+ **Lock screen**: `slock`

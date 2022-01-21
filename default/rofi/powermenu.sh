#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

theme="style_powermenu"
dir="$HOME/.config/rofi"

uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $dir/$theme"

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# Confirmation
confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-theme $dir/confirm.rasi
}

# Message
msg() {
	rofi -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"
chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 2)"

# if the user quit the script with ESC exit
if [[ -z $chosen ]]; then
	exit 0
fi

# ask the suer to confirm quitting
ans=$(confirm_exit &)

# chekc if the answer is negative or typed correctly
if [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" || -z $ans ]]; then
	exit 0
elif [[ $ans != "yes" && $ans != "YES" && $ans != "y" && $ans != "Y" ]]; then
	msg
	exit 0
fi

# perform user action
case $chosen in
    $shutdown) systemctl poweroff ;;
    $reboot) systemctl reboot ;;
    $lock) [[ -x "$(command -v slock)" ]] && slock ;;
    $suspend) systemctl suspend ;;
    $logout) killall dwm ;;
	*) exit 1 ;;
esac

exit 0

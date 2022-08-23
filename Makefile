.ONESHELL:
SHELL := /bin/bash

install:
	if pacman -Q | grep "bpytop"; then
		cp -r .config/bpytop ~/.config/bpytop
	fi

	if pacman -Q | grep "alacritty"; then
		cp .config/alacritty.yml ~/.config/alacritty.yml
	fi

	if pacman -Q | grep "fish"; then
		cp -r .config/fish ~/.config/fish
	fi

	if pacman -Q | grep "neofetch"; then
		cp -r .config/neofetch ~/.config/neofetch
	fi

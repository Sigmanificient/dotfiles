#!/bin/sh

rm -rf "$HOME/.oh-my-zsh/custom"
mkdir "$HOME/.oh-my-zsh/custom"

ln -s "$HOME/extra/zsh/plugins" "$HOME/.oh-my-zsh/custom"
ln -s "$HOME/extra/zsh/themes" "$HOME/.oh-my-zsh/custom"

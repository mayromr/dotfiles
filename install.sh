#!/usr/bin/bash
STOW_FOLDERS="nvim,tmux,zsh,alacritty,bottom,karabiner,fish,starship"
DOTFILES=$HOME/dotfiles

pushd $DOTFILES

for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    echo "stow $folder"
    stow -D $folder
    stow $folder
done
popd

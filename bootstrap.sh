#!/bin/bash

if [[ "$(uname)" == 'Darwin' ]]; then
    type -p brew &>/dev/null ||\
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

ln -sf vimrc ~/.vimrc
ln -sf gitconfig ~/.gitconfig
ln -sf zshrc ~/.zshrc
#ln -sf oh-my-zsh ~/.oh-my-zsh
#ln -sf tmux ~/.tmux
ln -sf tmux.conf ~/.tmux.conf
#ln -sf cask ~/.cask
#ln -sf pentadactylrc ~/.pentadactylrc
#ln -sf pentadactyl ~/.pentadactyl

[[ -d ~/.tmux ]] && [[ -d ~/.tmux/plugins ]] || mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

[[ -d ~/.vim ]] || mkdir -p ~/.vim
for dir in vim/*; do ln -s "$dir" "$HOME/.vim/${dir##*/}"; done

chsh -s /bin/zsh && exec zsh

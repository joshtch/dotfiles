#!/bin/bash

if [[ `uname` == "Darwin" ]]; then
    type -p brew &>/dev/null ||\
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"\
    && brew tap rcmdnk/file \
    && brew install brew-file \
    && brew file set_repo -r https://github.com/joshtch/dotfiles \
    && brew file update
fi

ln -sf vimrc ~/.vimrc
ln -sf gitconfig ~/.gitconfig
ln -sf zshrc ~/.zshrc
ln -sf oh-my-zsh ~/.oh-my-zsh
ln -sf tmux ~/.tmux
ln -sf tmux.conf ~/.tmux.conf
ln -sf cask ~/.cask
ln -sf pentadactylrc ~/.pentadactylrc
ln -sf pentadactyl ~/.pentadactyl

chsh -s /bin/zsh && exec zsh

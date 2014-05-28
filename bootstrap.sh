#!/bin/bash

if [[ `uname` == "Darwin" ]]; then
    type -p brew &>/dev/null ||\
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"\
    && brew tap rcmdnk/brewall \
    && brew install brewall \
    && brewall set_repo -r https://github.com/joshtch/dotfiles \
    && brewall update
fi

ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/oh-my-zsh ~/.oh-my-zsh
ln -sf ~/dotfiles/tmux ~/.tmux
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/cask ~/.cask
ln -sf ~/dotfiles/pentadactylrc ~/.pentadactylrc
ln -sf ~/dotfiles/pentadactyl ~/.pentadactyl
ln -sf ~/.vim/bundle/pterosaur/pterosaur.js ~/dotfiles/pentadactyl/plugins/pterosaur.js

mkdir -p ~/.vim/syntax
mkdir -p ~/.vim/ftdetect
ln -sf ~/dotfiles/syntax/pentadactyl.vim ~/.vim/syntax
ln -sf ~/dotfiles/ftdetect/pentadactyl.vim ~/.vim/ftdetect
chsh -s /bin/zsh && exec zsh

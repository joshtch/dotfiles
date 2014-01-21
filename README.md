dotfiles
========

    cd
    git clone https://github.com/joshtch/dotfiles.git
    ln -sf dotfiles/vimrc ~/.vimrc
    ln -sf dotfiles/gitconfig ~/.gitconfig
    ln -sf dotfiles/zshrc ~/.zshrc
    ln -sf dotfiles/oh-my-zsh ~/.oh-my-zsh
    ln -sf dotfiles/tmux ~/.tmux
    ln -sf dotfiles/tmux.conf ~/.tmux.conf
    ln -sf dotfiles/cask ~/.cask
    ln -sf dotfiles/pentadactylrc ~/.pentadactylrc
    ln -sf dotfiles/pentadactyl ~/.pentadactyl

These four lines are used for syntax highlighting pentadactyl scripts in vim.

    mkdir -p ~/.vim/syntax
    mkdir -p ~/.vim/ftdetect
    ln -sf dotfiles/syntax/pentadactyl.vim ~/.vim/syntax
    ln -sf dotfiles/ftdetect/pentadactyl.vim ~/.vim/ftdetect

TODO:
=====

Make vim open as many vsplits as it can when it's opened with filenames in the
 command line

Figure out how to put plugins in separate file to be sourced.

Install:

http://www.reddit.com/r/vim/comments/1giij9/list_you_favorite_plugins/

https://github.com/kana/vim-textobj-user/wiki

dotfiles
========

    cd ~
    git clone https://github.com/joshtch/dotfiles.git
    ln -sf dotfiles/vimrc ~/.vimrc
    cp -p dotfiles/syntax/pentadactyl.vim ~/.vim/syntax/
    cp -p dotfiles/ftdetect/pentadactyl.vim ~/.vim/ftdetect/


TODO:
=====

Make vim open as many vsplits as it can when it's opened with filenames in the
 command line

Add create "append after/insert before text object" operator

More textobjects!

Make a branch of focus.vim that removes the annoying mapping and clears
 unnamed buffers when focusmode is toggled

Figure out how to put plugins in separate file to be sourced

Install:

kana/vim-smartinput

Others from:

http://www.reddit.com/r/vim/comments/1giij9/list_you_favorite_plugins/

https://github.com/kana/vim-textobj-user/wiki

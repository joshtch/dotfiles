dotfiles
========

Note: you don't need the last two lines if you don't use pentadactyl. In that case you only need the vimrc.

    cd ~
    git clone https://github.com/joshtch/dotfiles.git
    ln -sf dotfiles/vimrc ~/.vimrc
    cp -p dotfiles/syntax/pentadactyl.vim ~/.vim/syntax/
    cp -p dotfiles/ftdetect/pentadactyl.vim ~/.vim/ftdetect/


TODO:
=====

Make vim open as many vsplits as it can when it's opened with filenames in the
 command line

More textobjects!

Make a branch of focus.vim that removes the annoying mapping and clears
 unnamed buffers when focusmode is toggled

Figure out how to put plugins in separate file to be sourced

Install:

kana/vim-smartinput

(Maybe)  
https://github.com/troydm/easybuffer.vim

Others from:

http://www.reddit.com/r/vim/comments/1giij9/list_you_favorite_plugins/

https://github.com/kana/vim-textobj-user/wiki

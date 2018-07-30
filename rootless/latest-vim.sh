#!/bin/bash

set -e

TEMP=$(mktemp -d /tmp/vim.XXXXXXXX)
cd "$TEMP"

if hg clone https://code.google.com/p/vim/; then
    cd vim
    hg pull
    hg update
else
    SOURCE=$(curl http://www.vim.org/sources.php | grep -E 'vim-[0-9.]+tar.bz2[^.]')
    REGEX='(ftp://ftp.vim.org/pub/vim/unix/vim-([0-9.]+).tar.bz2)'
    [[ "$SOURCE" =~ "$REGEX" ]]
    URL=${BASH_REMATCH[1]}
    VERSION=${BASH_REMATCH[2]}
    if "$URL" == '' || "$VERSION" == ''; then exit 1; fi
    curl "$URL" -o vim.tar.bz2
    bunzip2 vim.tar.bz2
    tar xf vim.tar
    mv vim"$VERSION" vim
    rm vim.tar
    cd vim
fi

./configure --with-features=huge \
    --enable-rubyinterp \
    --enable-pythoninterp \
    --with-python-config-dir=/usr/lib/python2.7-config \
    --with-x \
    --enable-perlinterp \
    --enable-gui \
    --enable-cscope \
    --enable-mzschemeinterp \
    --enable-luainterp \
    --prefix="$HOME"

make install

# Basic directory operations
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

function urand {
    NUMBYTES="$@"
    valid_num_regexp='[1-4]'
    if [[ "$#" > 0 ]]
    then
        if [[ $NUMBYTES =~ $valid_num_regexp ]]
        then
            od -vAn -N$NUMBYTES -tu4 < /dev/urandom
        else
            echo "Usage: $0 [1|2|3|4]"
        fi
    else
        od -vAn -N3 -tu4 < /dev/urandom
    fi
}

alias gds='git diff --stat --color | cat'

# Show history
alias h='fc -l 1'
# Show ten most used commands
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# Portably colorize ls
if "${commands[ls]}" --color -d /dev/null &>/dev/null; then
    # Using GNU ls
    alias ls="${commands[ls]} --color=auto -H -F"

elif /usr/gnu/bin/ls --color=auto /dev/null &>/dev/null; then
    # GNU ls in /usr/gnu/bin/ls but not default (Solaris)
    alias ls="/usr/gnu/bin/ls --color=auto -H -F"

elif [[ -x "${commands[brew]}" ]] \
    && "$(brew --prefix coreutils)"/libexec/gnubin/ls --color=auto /dev/null &>/dev/null; then
    # GNU ls installed with homebrew coreutils (OSX)
    alias ls='$(brew --prefix coreutils)/libexec/gnubin/ls --color=auto -H -F'

elif "${commands[ls]}" -G -d /dev/null &>/dev/null; then
    # BSD ls
    alias ls='${commands[ls]} -G -H -F'
fi

if [[ -x "${commands[dircolors]}" ]] \
    && ([[ -d "$HOME/.zsh/dircolors-solarized" ]] \
    || git clone https://github.com/seebi/dircolors-solarized.git "$HOME/.zsh/dircolors-solarized"); then
    eval `dircolors "$HOME/.zsh/dircolors-solarized/dircolors.ansi-universal"`
fi

# List directory contents
alias l='ls -lv'
alias sl=ls
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.
alias le='ls -lv |less'    #  Pipe through 'less'
alias lr='ls -lvR'         #  Recursive ls.
alias la='ls -lvA'         #  Show hidden files.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...

if [[ -d ~/dotfiles ]]; then
    alias vv='vim ~/dotfiles/vimrc'
    alias bb='vim ~/dotfiles/bashrc'
    alias aa='vim ~/dotfiles/aliases.zsh; source ~/dotfiles/aliases.zsh'
    alias tt='vim ~/dotfiles/tmux.conf'
    alias zz='vim ~/dotfiles/zshrc; exec zsh'
else
    alias vv='vim ~/.vimrc'
    alias bb='vim ~/.bashrc; exec bash'
    alias aa='vim ~/.oh-my-zsh/custom/aliases.zsh; source ~/.oh-my-zsh/custom/aliases.zsh'
    alias zz='vim ~/.zshrc; exec zsh'
fi
alias ll='vim ~/.localrc.zsh; source ~/.localrc.zsh'

alias z='exec zsh'
alias less='"${commands[less]}" -R'
alias more='less'
alias grep='grep --color=auto'

alias j='jobs -l'
alias r='fc -e -'
alias c='clear && ls'
alias x=exit

function stackoverflow() {
    firefox "http://stackoverflow.com/search?q=$*" &
}

function google() {
    firefox "http://google.com/search?q=$*" &
}

if [[ "$(uname)" == 'Darwin' ]]; then
    alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
    alias man='_() { echo $1; man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1 1>/dev/null 2>&1; if [ "$?" -eq 0 ]; then man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1; else man $1; fi }; _'
    alias rm='trash'

    if `whence brewall &>/dev/null`; then
        alias ba='brewall brew'
        alias bran='brewall brew noinit'
    fi

    alias gif='echo "mplayer -ao null -loop 0 -ss 0:11:22 -endpos 5 file.avi";
    echo "mplayer -ao null -ss 0:11:22 -endpos 5 file.avi -vo jpeg:outdir=somedir"'

    DefineApps () {
        export T=$(mktemp /tmp/$PPID''XXXXXX) ;
        find "$@" '(' -type d -or -type l ')' -name '*.app' -prune -print0 2>/dev/null |\
            xargs -0 python -c 'import os,sys,re,distutils.spawn;os.chdir("/usr/bin")'$'\n''def orApp(c):'$'\n'' if not distutils.spawn.find_executable(c): return c'$'\n'' elif not distutils.spawn.find_executable(c+"-app"): return c+"-app"'$'\n\n''def getF(Command):'$'\n'' if "." in Command or "-" in Command: return lambda App: "alias \""+Command+"\"=\"open -W -a \\\""+App+"\\\"\""'$'\n'' else: return lambda App:Command+" () { open -W -a \""+App+"\" \"$@\" ; } ; export -f "+Command'$'\n\n''print "\n".join((lambda Command:getF(orApp(Command))(App))(Command=re.sub("[^a-z0-9._-]","",re.sub(".*/","",App)[:-4].replace(" ","-").lower())) for App in sys.argv[1:])' >> $T ; . $T ; rm $T ; unset T; } 2>/dev/null 1>/dev/null
    DefineApps ~/Applications /Applications /usr/local/Cellar/emacs 2>/dev/null 1>/dev/null
    if declare -F xcode >/dev/null; then
        DefineApps "$(declare|grep -i '^ *open.*/Xcode.app'|head -1|sed -e 's/[^"]*"//' -e 's/".*//')/Contents/Applications" 2>/dev/null 1>/dev/null;
    fi
    unset DefineApps

    # Play audio files
    if ! which -s play >/dev/null; then play () { afplay "$@" ; } >/dev/null; export -f play >/dev/null; fi

    alias spotlight-disable='sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist'
    alias spotlight-enable='sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist'
    alias spotlight-hide='sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search && killall SystemUIServer'
    alias spotlight-show='sudo chmod 755 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search && killall SystemUIServer'

elif [[ "$(uname)" == 'Linux' ]]; then
    function open() { xdg-open "${@:-.}" }
fi

function size() {
    du -sh "$@" 2>&1 | grep -v '^du:'
}

function ssht(){
    ssh $* -t 'tmux a || tmux || /bin/bash'
}

alias dud='du --max-depth=1 -h'
alias du-dir='du --max-depth=1 -h'
alias duf='du -sh *'
alias du-file='du -sh *'
alias fd='find . -type d -name'
alias find-dir='find . -type d -name'
alias ff='find . -type f -name'
alias find-file='find . -type f -name'

alias hgrep="fc -El 0 | grep"
alias j='jobs'
alias p='ps -f'
alias sortnr='sort -n -r'

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"

if [[ "$SHELL" == 'zsh' ]]; then     # For portability with bash
    fancy-ctrl-z () {
        if [[ $#BUFFER -eq 0 ]]; then
            fg
            zle redisplay
        else
            zle push-input
            zle clear-screen
        fi
    }
    zle -N fancy-ctrl-z
    bindkey '' fancy-ctrl-z

    up-line-or-history-beginning-search () {
        if [[ -n $PREBUFFER ]]; then
            zle up-line-or-history
        else
            zle history-beginning-search-backward
        fi
    }
    down-line-or-history-beginning-search () {
        if [[ -n $PREBUFFER ]]; then
            zle down-line-or-history
        else
            zle history-beginning-search-forward
        fi
    }
    zle -N up-line-or-history-beginning-search
    zle -N down-line-or-history-beginning-search
    bindkey '' up-line-or-history-beginning-search
    bindkey '' down-line-or-history-beginning-search

    # zsh is able to auto-do some kungfoo
    # depends on the SUFFIX :)
    if [ ${ZSH_VERSION//\./} -ge 420 ]; then
        # open browser on urls
        _browser_fts=(htm html de org net com at cx nl se dk dk php)
        for ft in $_browser_fts ; do alias -s $ft=$BROWSER ; done

        _editor_fts=(cpp cxx cc c hh h inl asc txt TXT tex)
        for ft in $_editor_fts ; do alias -s $ft=$EDITOR ; done

        _image_fts=(jpg jpeg png gif mng tiff tif xpm)
        for ft in $_image_fts ; do alias -s $ft=$XIVIEWER; done

        _media_fts=(ape avi flv mkv mov mp3 mpeg mpg ogg ogm rm wav webm)
        for ft in $_media_fts ; do alias -s $ft=mplayer ; done

        #read documents
        alias -s pdf=acroread
        alias -s ps=gv
        alias -s dvi=xdvi
        alias -s chm=xchm
        alias -s djvu=djview

        #list whats inside packed file
        alias -s zip="unzip -l"
        alias -s rar="unrar l"
        alias -s tar="tar tf"
        alias -s tar.gz="echo "
        alias -s ace="unace l"
    fi

    # Make zsh know about hosts already accessed by SSH
    zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
fi

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias cl='clear; ls'

# Show contents of directory on cd
alias cdl='cd && ls'

# Super user
alias sudo='sudo ' # make sudo play nice with other aliases
alias _='sudo'
alias please='sudo'

function rand {
    NUMBYTES="$@"
    valid_num_regexp="[1-4]"
    if [[ $NUMBYTES != "" ]]
    then
        if [[ $NUMBYTES =~ $valid_num_regexp ]]
        then
            od -vAn -N$NUMBYTES -tu4 < /dev/urandom
        else
            echo "Usage: $0 [NUMBYTES]"
        fi
    else
        od -vAn -N3 -tu4 < /dev/urandom
    fi
}

alias gsl='git diff --stat --color | cat'

# Show history
alias history='fc -l 1'
# Show ten most used commands
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# ugly hack to get color by default in different versions of ls
if ls --color -d . >/dev/null 2>&1; then # GNU
    function ls {/bin/ls --color=auto "$@" }
elif ls -G -d . >/dev/null 2>&1; then # BSD
    function ls {/bin/ls -G "$@" }
elif /usr/gnu/bin/ls --color=auto >/dev/null 2>&1; then
    # Solaris but with GNU ls installed
    function ls {/usr/gnu/bin/ls --color=auto "$@" }
else
    # Solaris/something else. I don't know if colored ls is possible.
fi

# List directory contents
alias l='ls -lv'
alias sl=ls
alias ls='ls -h -F'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.
alias lm='ls -lv |more'    #  Pipe through 'more'
alias lr='ls -lvR'         #  Recursive ls.
alias la='ls -lvA'         #  Show hidden files.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...

if [[ -d ~/dotfiles ]] then
    alias vv='vim ~/dotfiles/vimrc'
    alias bb='vim ~/dotfiles/bashrc; exec bash'
    alias aa='vim ~/dotfiles/custom/aliases.zsh; exec zsh'
    alias zz='vim ~/dotfiles/zshrc; source ~/.zshrc'
else
    alias vv='vim ~/.vimrc'
    alias bb='vim ~/.bashrc; exec bash'
    alias aa='vim ~/.oh-my-zsh/custom/aliases.zsh; exec zsh'
    alias zz='vim ~/.zshrc; source ~/.zshrc'
fi
alias ll='vim ~/.localrc.zsh; source ~/.localrc.zsh'

alias z='exec zsh'
alias vbundle='cd ~/.vim/bundle'
alias more='less'
alias grep='grep --color=auto'

# progress bar on file copy
alias pcp='rsync --progress -ravz'

alias h=history
alias j='jobs -l'
alias r='fc -e -'
alias c=clear
alias x=exit

function stackoverflow() {
    firefox "http://stackoverflow.com/search?q=$*" &
}

function google() {
    firefox "http://google.com/search?q=$*" &
}

if [[ "$(uname)" == "Darwin" ]]; then
    alias rm='trash'

    alias gif='echo "mplayer -ao null -loop 0 -ss 0:11:22 -endpos 5 file.avi";
    echo "mplayer -ao null -ss 0:11:22 -endpos 5 file.avi -vo jpeg:outdir=somedir"'
fi

function size() {
    du -sh "$@" 2>&1 | grep -v '^du:'
}

function ssht(){
    ssh $* -t 'tmux a || tmux || /bin/bash'
}

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

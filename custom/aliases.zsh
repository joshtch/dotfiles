# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Show contents of directory on cd
alias cdl='cd && ls'

# Super user
alias sudo='sudo ' # make sudo play nice with other aliases
alias _='sudo'
alias please='sudo'

alias rand='od -vAn -N4 -tu4 < /dev/urandom'

# git shortcuts {{{
alias grep='grep --color=auto'

alias g='git'
alias ga='git add'
alias gr='git rm'

alias gf='git fetch'
alias gu='git pull'
alias gup='git pull && git push'

alias gs='git status --short'
alias gd='git diff'
alias gds='git diff --staged'
alias gdisc='git discard'

function gc() {
    args=$@
    git commit -m "$args"
}
function gca() {
    args=$@
    git commit --amend -m "$args"
}

alias gp='git push'

# git commit -m ... && git push
function gcp() {
    args=$@
    git commit -a -m "$args" && git push -u origin
}
alias gcl='git clone'
alias gch='git checkout'
alias gl='git log --no-merges'
# }}}

# Show history
alias history='fc -l 1'
# Show ten most used commands
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# List direcory contents
alias l='ls -lv'
alias sl=ls # often screw this up
alias ls='ls -h -F -G'
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
alias ll='vim ~/localrc.zsh; source ~/localrc.zsh'

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

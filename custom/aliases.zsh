# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Super user
alias sudo='sudo ' # make sudo play nice with other aliases
alias _='sudo'
alias please='sudo'

alias grep='grep --color=auto'
alias g='grep -in'

# Show history
alias history='fc -l 1'

# List direcory contents
alias l='ls -la'
alias sl=ls # often screw this up
alias ls='ls -h -F -G'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.
alias ll='ls -lv'
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...

alias afind='ack-grep -il'

if [[ -d ~/dotfiles ]] then
    alias vv='vim ~/dotfiles/vimrc'
    alias bb='vim ~/dotfiles/bashrc; exec bash'
    alias aa='vim ~/dotfiles/oh-my-zsh/custom/aliases.zsh; exec zsh'
    alias zz='vim ~/dotfiles/zshrc; source ~/.zshrc'
else
    alias vv='vim ~/.vimrc'
    alias bb='vim ~/.bashrc; exec bash'
    alias aa='vim ~/.oh-my-zsh/custom/aliases.zsh; exec zsh'
    alias zz='vim ~/.zshrc; source ~/.zshrc'
fi

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
    alias trash='open ~/.trash/'

    alias gif='echo "mplayer -ao null -loop 0 -ss 0:11:22 -endpos 5 file.avi";
    echo "mplayer -ao null -ss 0:11:22 -endpos 5 file.avi -vo jpeg:outdir=somedir"'
fi

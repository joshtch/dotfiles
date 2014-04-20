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
elif /usr/gnu/bin/ls --color=auto >/dev/null 2>&1; then
    # GNU ls installed in /usr/gnu/bin/ls but not default (Solaris)
    function ls {/usr/gnu/bin/ls --color=auto "$@" }
elif $(brew --prefix coreutils)/libexec/gnubin/ls --color=auto >/dev/null 2>&1; then
    # GNU ls installed in /usr/gnu/bin/ls but not default (Solaris)
    function ls {$(brew --prefix coreutils)/libexec/gnubin/ls --color=auto "$@" }
elif /bin/ls -G -d . >/dev/null 2>&1; then # BSD
    function ls {/bin/ls -G "$@" }
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
alias le='ls -lv |less'    #  Pipe through 'less'
alias lr='ls -lvR'         #  Recursive ls.
alias la='ls -lvA'         #  Show hidden files.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...

if [[ -d ~/dotfiles ]] then
    alias vv='vim ~/dotfiles/vimrc'
    alias bb='vim ~/dotfiles/bashrc'
    alias aa='vim ~/dotfiles/aliases.zsh; exec zsh'
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
    alias man='_() { echo $1; man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1 1>/dev/null 2>&1; if [ "$?" -eq 0 ]; then man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1; else man $1; fi }; _'
    alias rm='trash'

    alias gif='echo "mplayer -ao null -loop 0 -ss 0:11:22 -endpos 5 file.avi";
    echo "mplayer -ao null -ss 0:11:22 -endpos 5 file.avi -vo jpeg:outdir=somedir"'

    DefineApps () { export T=$(mktemp /tmp/$PPID''XXXXXX) ; find "$@" '(' -type d -or -type l ')' -name '*.app' -prune -print0 2>/dev/null | xargs -0 python -c 'import os,sys,re,distutils.spawn;os.chdir("/usr/bin")'$'\n''def orApp(c):'$'\n'' if not distutils.spawn.find_executable(c): return c'$'\n'' elif not distutils.spawn.find_executable(c+"-app"): return c+"-app"'$'\n\n''def getF(Command):'$'\n'' if "." in Command or "-" in Command: return lambda App: "alias \""+Command+"\"=\"open -W -a \\\""+App+"\\\"\""'$'\n'' else: return lambda App:Command+" () { open -W -a \""+App+"\" \"$@\" ; } ; export -f "+Command'$'\n\n''print "\n".join((lambda Command:getF(orApp(Command))(App))(Command=re.sub("[^a-z0-9._-]","",re.sub(".*/","",App)[:-4].replace(" ","-").lower())) for App in sys.argv[1:])' >> $T ; . $T ; rm $T ; unset T; } 2>/dev/null 1>/dev/null
    DefineApps ~/Applications /Applications /usr/local/Cellar/emacs 2>/dev/null 1>/dev/null
    if declare -F xcode >/dev/null; then
        DefineApps "$(declare|grep -i '^ *open.*/Xcode.app'|head -1|sed -e 's/[^"]*"//' -e 's/".*//')/Contents/Applications" 2>/dev/null 1>/dev/null;
    fi
    unset DefineApps

    # Play audio files
    if ! which -s play >/dev/null; then play () { afplay "$@" ; } >/dev/null; export -f play >/dev/null; fi

    if ! which -s umount >/dev/null; then umount () { diskutil umount "$@" ; }  >/dev/null; export -f umount >/dev/null; fi

    alias spotlight-disable="sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist"
    alias spotlight-enable="sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist"

elif [[ "$(uname)" == "Linux" ]]; then
    if ! which -s open >/dev/null; then open() { if "$#" > 0; then xdg-open "$@"; else; xdg-open .; fi } >/dev/null; export -f open >/dev/null; fi
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

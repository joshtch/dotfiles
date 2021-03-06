# vi: fm=marker sw=4 ts=4 et si

if [[ `uname` == 'Darwin' ]]; then
    # Copy last command to clipboard
    alias pbget='fc -ln -1 | pbcopy'
fi

# Basic directory operations
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Changing/making/removing directory
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
alias d='dirs -v | head -10'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

#echo $[${RANDOM}%1000] # random between 0-999
#echo $[${RANDOM}%11+10] # random between 10-20
#echo ${(l:3::0:)${RANDOM}} # N digits long (3 digits)
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
if [ "$HIST_STAMPS" = "mm/dd/yyyy" ]
then
    alias history='fc -fl 1'
elif [ "$HIST_STAMPS" = "dd.mm.yyyy" ]
then
    alias history='fc -El 1'
elif [ "$HIST_STAMPS" = "yyyy-mm-dd" ]
then
    alias history='fc -il 1'
else
    alias history='fc -l 1'
fi
# Show ten most used commands
alias history-stat="fc -l 1 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
alias hgrep='history | grep'
alias psgrep='ps aux | grep -v "e4a8704f594b025627f40f9d5107ec90" | grep'

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
[[ -f "$HOME/.zsh/dircolors-solarized/dircolors.ansi-universal" ]] \
    && eval `dircolors "$HOME/.zsh/dircolors-solarized/dircolors.ansi-universal"`

# Restart Tor session with password
# Refer to http://pundirtech.com/data-scraping-series-2-1-rotating-your-tor-ip-address-php-or-linux/
rtor-passwd () {
    echo "Password: "
    read -s PASS
    echo -e "AUTHENTICATE \"$PASS\"\r\nsignal NEWNYM\r\nQUIT" | nc 127.0.0.1 9051
    unset PASS
}

# List directory contents
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.
alias le='ls -lv |less'    #  Pipe through 'less'
alias lr='ls -lvR'         #  Recursive ls.
alias la='ls -lvA'         #  Show hidden files.
if [[ -x "${commands[tree]}" ]]; then
    alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...
elif [[ -x "${commands[m]}" ]]; then
    alias tree='m dir tree'
fi

if [[ -d "$DFS" ]] || [[ -d "$HOME/dotfiles" ]]; then
    alias vv='vim ~/dotfiles/vimrc'
    alias aa='vim ~/dotfiles/aliases.zsh; source ~/dotfiles/aliases.zsh'
    alias tt='vim ~/dotfiles/tmux.conf'
    alias zz='vim ~/dotfiles/zshrc; exec zsh'
else
    alias vv='vim ~/.vimrc'
    alias aa='vim ~/.oh-my-zsh/custom/aliases.zsh; source ~/.oh-my-zsh/custom/aliases.zsh'
    alias zz='vim ~/.zshrc; exec zsh'
fi
alias ll='vim ~/.localrc.zsh; source ~/.localrc.zsh'

alias less='"${commands[less]}" -R'
alias more='less'
alias grep='grep --color=auto'

alias j='jobs -l'
alias r='fc -e -'
alias c='clear && ls'

if [[ -x "${commands[nvim]}" ]]; then
    alias vim='nvim'
fi

if [[ "$(uname)" == 'Darwin' ]]; then
    alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

    function man() {
        echo "$1"
        "${commands[man]}" -M "$(brew --prefix)/opt/coreutils/libexec/gnuman" "$1" 1>/dev/null 2>&1
        if [ "$?" -eq 0 ]; then
            "${commands[man]}" -M "$(brew --prefix)/opt/coreutils/libexec/gnuman" "$1"
        else
            "${commands[man]}" "$1"
        fi
    }

    alias rm='trash'
    if [[ -x '/Applications/MacVim.app/Contents/MacOS/Vim' ]]; then
        alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
    fi

    alias gif='echo "mplayer -ao null -loop 0 -ss 0:11:22 -endpos 5 file.avi";
               echo "mplayer -ao null -ss 0:11:22 -endpos 5 file.avi -vo jpeg:outdir=somedir"'

    DefineApps () {
        export T=$(mktemp /tmp/$PPID''XXXXXX) ;
        find "$@" '(' -type d -or -type l ')' -name '*.app' -prune -print0 2>/dev/null |\
            xargs -0 python -c '
import os,sys,re,distutils.spawn
os.chdir("/usr/bin")
def orApp(c):
    if not distutils.spawn.find_executable(c):
        return c
    elif not distutils.spawn.find_executable(c+"-app"):
        return c+"-app"
def getF(Command):
    if "." in Command or "-" in Command:
        return lambda App: "alias \""+Command+"\"=\"open -a \\\""+App+"\\\"\""
    else:
        return lambda App:Command+" () { open -a \""+App+"\" \"$@\" ; }; export -f "+Command

print "\n".join((lambda Command:getF(orApp(Command))(App))(Command=re.sub("[^a-z0-9._-]","",re.sub(".*/","",App)[:-4].replace(" ","-").lower())) for App in sys.argv[1:])
' >> $T ; . $T ; rm $T ; unset T; } 2>/dev/null 1>/dev/null
    DefineApps ~/Applications /Applications /usr/local/Cellar/emacs 2>/dev/null 1>/dev/null
    if declare -F xcode >/dev/null; then
        DefineApps "$(declare|grep -i '^ *open.*/Xcode.app'|head -1|sed -e 's/[^"]*"//' -e 's/".*//')/Contents/Applications" 2>/dev/null 1>/dev/null;
    fi
    unset DefineApps

    alias spotlight-disable='sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist'
    alias spotlight-enable='sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist'
    alias spotlight-hide='sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search && killall SystemUIServer'
    alias spotlight-show='sudo chmod 755 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search && killall SystemUIServer'

elif [[ "$(uname)" == 'Linux' ]]; then
    function open() { xdg-open "${@:-.}" }
fi

function ssht(){
    ssh $* -t 'tmux a || tmux || zsh'
}

alias gcal='gcalcli'

alias venvactive='source venv/bin/activate'
function venv () {
    if ! [[ -d './venv' || -d './.venv' ]]; then
        echo 'No virtualenv at ./venv or ./.venv; creating new virtualenv at ./venv'
        virtualenv venv
    fi
    source venv/bin/activate
}

alias dockerstop='docker ps -q -a | xargs docker rm'
alias dockerclear='docker images | awk '"'"'$2 == "^<none>" {print $3}'"'"' | xargs docker rmi'
function hubdl() {
    if [ $# -eq 2 ]; then
        url="https://api.github.com/repos/$1/$2/releases/latest"
        curl -O "$(curl -s "$url" | grep 'browser_' | cut -d\" -f4)"
    else
        echo "$0: Download latest release of software from Github."
        echo "Usage:"
        echo "    $0 User_Name Repo_Name"
        return 1
    fi
}

function nn() {
    note_name=
    note_dir="$HOME/notes"
    timestamp="$(date +%Y-%m-%d)"
    if (( $# > 0 )); then
        topic="$1"
        note_name="${1}-"
    fi
    mkdir -p "${note_dir}"
    vim "${note_dir}/${topic}/${note_name}${timestamp}.${2:-adoc}"
}

alias httpserve='nohup python -c "import BaseHTTPServer as bhs, SimpleHTTPServer as shs; bhs.HTTPServer(("127.0.0.1", 8888), shs.SimpleHTTPRequestHandler).serve_forever()" & disown'

[[ "$SHELL" =~ 'zsh' ]] || return # For portability with bash

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
if [[ ${ZSH_VERSION} > 4.20 ]]; then
    # open browser on urls
    _browser_fts=(htm html de org net com at cx nl se dk dk php)
    for ft in $_browser_fts ; do alias -s $ft=$BROWSER ; done

    _editor_fts=(cpp cxx cc c hh h inl asc txt TXT tex)
    for ft in $_editor_fts ; do alias -s $ft=$EDITOR ; done

    _image_fts=(jpg jpeg png gif mng tiff tif xpm)
    for ft in $_image_fts ; do alias -s $ft=$XIVIEWER; done

    if [[ -x "${commands[mplayer]}" ]]; then
        _media_fts=(ape avi flv mkv mov mp3 mpeg mpg ogg ogm rm wav webm)
        for ft in $_media_fts ; do alias -s $ft=mplayer ; done
    fi

    #read documents
    alias -s pdf=acroread
    alias -s ps=gv
    alias -s dvi=xdvi
    alias -s chm=xchm
    alias -s djvu=djview

    #list whats inside packed file
    alias -s zip='unzip -l'
    alias -s rar='unrar l'
    alias -s tar='tar tf'
    alias -s tar.gz='echo '
    alias -s ace='unace l'

    alias -s webarchive='firefox'
    alias -s html='firefox'
    alias -s org='firefox'
    alias -s net='firefox'
    alias -s com='firefox'
fi

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Use caching for completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Ignore patterns for commands you don't have
zstyle ':completion:*:functions' ignored-patterns '_*'

# Complete process IDs with menu selection
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

bindkey ' ' magic-space

# when using sudo, complete commands in root's path even if not available to user
zstyle ':completion:*:sudo::' environ PATH="/sbin:/usr/sbin:$PATH" HOME="/root"

# Magic-abbrev -- auto-expand special abbreviations {{{
# From http://zshwiki.org/home/examples/zleiab
setopt extended_glob
typeset -Ag abbreviations
abbreviations=(
  "Im"    "| more"
  "Ia"    "| awk"
  "Ig"    "| grep"
  "Ieg"   "| egrep"
  "Iag"   "| agrep"
  "Igr"   "| groff -s -p -t -e -Tlatin1 -mandoc"
  "Ip"    "| $PAGER"
  "Ih"    "| head"
  "Ik"    "| keep"
  "It"    "| tail"
  "Is"    "| sort"
  "Iv"    "| ${VISUAL:-${EDITOR}}"
  "Iw"    "| wc"
  "Ix"    "| xargs"
)

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert
}

no-magic-abbrev-expand() {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand
bindkey -M isearch " " self-insert
# -- End magic-abbrev -- }}}

# Globalias: Autoexpand on space {{{
globalias() {
   zle _expand_alias
   zle expand-word
   zle self-insert
}
zle -N globalias

# ctrl-space expands all aliases, including global
bindkey -M emacs "^ " globalias
bindkey -M viins "^ " globalias

# space to make a normal space
bindkey -M emacs " " magic-space
bindkey -M viins " " magic-space

# normal space during searches
bindkey -M isearch " " magic-space
# -- end of globalias -- }}}

# Only show past commands matching current line up to current cursor position {{{
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

# }}}

# zshrc
# vim:set ft=zsh et ts=4 sw=4:

# MAC Address spoofing: ifconfig bge0 link 03:a0:04:d3:00:11

export DFS="$HOME"/dotfiles
export KEYTIMEOUT=1

source "$DFS"/antigen/antigen.zsh
antigen use oh-my-zsh

cdpath=(. .. ~)          # This has to come after sourcing antigen and oh-my-zsh
[[ -f ~/.localrc.zsh ]] && source ~/.localrc.zsh

if [[ -x "${commands[dircolors]}" ]]; then
    if [[ -f "$DFS"/dircolors-solarized/dircolors.ansi-universal ]]; then
        eval `dircolors ~/dotfiles/dircolors-solarized/dircolors.ansi-universal`
    else
        antigen bundle huyz/dircolors-solarized
        eval `dircolors $ADOTDIR/repos/https-COLON--SLASH--SLASH-github.com-SLASH-huyz-SLASH-dircolors-solarized.git/dircolors.ansi-universal`
    fi
fi

antigen bundle colored-man
antigen bundle compleat
antigen bundle cp
antigen bundle dirhistory
antigen bundle extract
antigen bundle history
antigen bundle history-substring-search
antigen bundle vi-mode

if (( ! $+git )) then
    antigen bundle git
fi

(( ! $+tmux )) && antigen bundle tmux

if [[ `uname` == 'Darwin' ]] then
    if [[ -x "${commands[brew]}" ]] then
        antigen bundle brew
        antigen bundle brew-cask
    fi
    antigen bundle gnu-utils
    antigen bundle osx
fi

if [[ -f "$DFS"/custom/nicoulaj-solarized.zsh-theme ]] then
    antigen theme "$DFS"/custom/nicoulaj-solarized.zsh-theme
else
    antigen theme "$DFS" custom/nicoulaj-solarized
fi

antigen apply

source "$DFS"/aliases.zsh

source "$DFS"/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

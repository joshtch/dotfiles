# zshrc
# vim:set ft=zsh et ts=4 sw=4:

# MAC Address spoofing: ifconfig bge0 link 03:a0:04:d3:00:11

source ~/dotfiles/antigen/antigen.zsh
antigen use oh-my-zsh

cdpath=(. .. ~)          # This has to come after sourcing antigen and oh-my-zsh
source ~/.localrc.zsh

if [[ ! `which dircolors` =~ 'not found$' ]] then
        if [[ -f ~/dotfiles/dircolors-solarized/dircolors.ansi-universal ]] then
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
antigen bundle history
antigen bundle history-substring-search
antigen bundle extract
antigen bundle vi-mode

if (( ! $+git )) then
    antigen bundle git
    #antigen bundle github
    #antigen bundle git-remote-branch
    #antigen bundle git-extras
fi

(( ! $+tmux )) && antigen bundle tmux

if [[ `uname` == 'Darwin' ]] then
    if [[ ! `which brew` =~ 'not found$' ]] then
        antigen bundle brew
        antigen bundle brew-cask
    fi
    antigen bundle osx
fi

if [[ -f ~/dotfiles/custom/nicoulaj-solarized.zsh-theme ]] then
    antigen theme $HOME/dotfiles/custom/nicoulaj-solarized.zsh-theme --no-local-clone
else
    antigen theme joshtch/dotfiles custom/nicoulaj-solarized
fi

antigen apply

source ~/dotfiles/aliases.zsh

source $HOME/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zshrc
# vim:set ft=zsh et ts=4 sw=4:

# MAC Address spoofing: ifconfig bge0 link 03:a0:04:d3:00:11

cdpath=(. .. ~)

source ~/.localrc.zsh
source ~/dotfiles/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle colored-man
antigen bundle command-not-found
antigen bundle cp
antigen bundle history
antigen bundle vi-mode

(( ! $+git )) && antigen bundle git && antigen bundle github
(( ! $+tmux )) && antigen bundle tmux

if [[ `uname` == 'Darwin' ]] then
    antigen bundle osx
    antigen bundle brew
fi

antigen theme joshtch/dotfiles custom/nicoulaj-solarized
antigen apply

source ~/dotfiles/custom/aliases.zsh

source $HOME/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

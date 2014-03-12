# zshrc
# vim:set ft=zsh et ts=4 sw=4:

# MAC Address spoofing: ifconfig bge0 link 03:a0:04:d3:00:11

source ~/dotfiles/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle colored-man
antigen bundle command-not-found
antigen bundle cp
antigen bundle git
antigen bundle github
antigen bundle history
antigen bundle tmux
antigen bundle vi-mode

if [[ `uname` == 'Darwin' ]] then
    antigen bundle osx
    antigen bundle brew
fi

antigen theme joshtch/dotfiles custom/nicoulaj-solarized
antigen apply

cdpath=(. .. ~)

source ~/dotfiles/custom/aliases.zsh
source ~/.localrc.zsh

source $HOME/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

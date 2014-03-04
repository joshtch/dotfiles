# zshrc
# vim:set ft=zsh et ts=4 sw=4:

# MAC Address spoofing: ifconfig bge0 link 03:a0:04:d3:00:11
# Note to self: run 'chsh -s /bin/zsh' next time I'm at Halligan

source ~/dotfiles/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle brew
antigen bundle colored-man
antigen bundle cp
antigen bundle git
antigen bundle github
antigen bundle history
antigen bundle osx
antigen bundle tmux
antigen bundle vi-mode

antigen theme joshtch/dotfiles custom/nicoulaj-solarized
antigen apply

cdpath=(. .. ~)

source ~/dotfiles/custom/aliases.zsh
source ~/.localrc.zsh

source $HOME/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

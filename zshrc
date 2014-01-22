# zshrc
# vim:set ft=zsh et ts=4 sw=4:

# Note to self: run 'chsh -s /bin/zsh' next time I'm at Halligan

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="../../custom/nicoulaj-solarized"

# MAC Address spoofing: ifconfig bge0 link 03:a0:04:d3:00:11

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(vi-mode osx tmux)

#cdpath=(. .. ~ ~/Desktop)

source $ZSH/oh-my-zsh.sh
source ~/dotfiles/custom/aliases.zsh
source ~/localrc.zsh

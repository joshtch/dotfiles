# zshrc
# vim:set ft=zsh et ts=4 sw=4:

# MAC Address spoofing: ifconfig bge0 link 03:a0:04:d3:00:11

export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
export DFS="${DFS:-$HOME/dotfiles}"
export KEYTIMEOUT=1
export HOMEBREW_BREWFILE="$HOME/dotfiles/Brewfile"

if [[ -x "${commands[dircolors]}" ]]; then
    [[ -f "$DFS"/dircolors-solarized/dircolors.ansi-universal ]] || \
        git clone https://github.com/huyz/dircolors-solarized.git ~/.zsh/dircolors-solarized
    eval `dircolors $ADOTDIR/repos/https-COLON--SLASH--SLASH-github.com-SLASH-huyz-SLASH-dircolors-solarized.git/dircolors.ansi-universal`
fi

ZSH_THEME='nicoulaj'

plugins=(colored-man cp extract history pip safe-paste vi-mode z)
[[ -x "${commands[git]}" ]] && plugins+=git
[[ -x "${commands[tmux]}" ]] && plugins+=tmux

if [[ `uname` == 'Darwin' ]]; then
    if [[ -x "${commands[brew]}" ]]; then
        plugins+=brew
        plugins+=brew-cask
    fi
    plugins+=osx
fi

source "$ZSH/oh-my-zsh.sh"

source "$DFS"/aliases.zsh

[[ -f "$HOME/.localrc.zsh" ]] && source "$HOME/.localrc.zsh"

[[ -d "$HOME/.zsh/syntax-highlighting" ]] && \
    source "$HOME/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh"

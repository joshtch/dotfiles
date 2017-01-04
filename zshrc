# zshrc
# vim:set ft=zsh et ts=4 sw=4:

export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
export DFS="${DFS:-$HOME/dotfiles}"
export KEYTIMEOUT=1
export HOMEBREW_BREWFILE="$HOME/dotfiles/Brewfile"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

[[ -f "$HOME/.zshenv" ]] && source "$HOME/.zshenv" # Not sourced on login

[[ -d "$HOME/.zsh" ]] || mkdir "$HOME/.zsh"

[[ -d "$ZSH" ]] \
    || git clone https://github.com/robbyrussell/oh-my-zsh.git "$ZSH"

[[ -d "$HOME/.zsh/syntax-highlighting" ]] \
    || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/syntax-highlighting"

[[ -d "$HOME/.zsh/history-substring-search" ]] \
    || git clone https://github.com/zsh-users/zsh-history-substring-search.git "$HOME/.zsh/history-substring-search"

ZSH_THEME='nicoulaj'

plugins=(cp extract history pip safe-paste z)
[[ -x "${commands[git]}" ]] && plugins+=git
[[ -x "${commands[tmux]}" ]] && plugins+=tmux

if [[ `uname` == 'Darwin' ]]; then
    plugins+=osx
    source ~/.iterm2_shell_integration.`basename $SHELL`
    if [[ -x "${commands[brew]}" ]]; then
        plugins+=brew
        plugins+=brew-cask
    fi
fi

source "$ZSH/oh-my-zsh.sh"

[[ -f "$DFS/aliases.zsh" ]] && source "$DFS/aliases.zsh"

[[ -f "$HOME/.localrc.zsh" ]] && source "$HOME/.localrc.zsh"

[[ -d "$HOME/.zsh/syntax-highlighting" ]] && \
    source "$HOME/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -d "$HOME/.zsh/history-substring-search" ]] && \
    source "$HOME/.zsh/history-substring-search/zsh-history-substring-search.zsh"

# zshrc
# vim:set ft=zsh et ts=4 sw=4:

export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
export DFS="${DFS:-$HOME/dotfiles}"
export KEYTIMEOUT=1
export HOMEBREW_BREWFILE="$DFS/Brewfile"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

[[ -f "$HOME/.zshenv" ]] && source "$HOME/.zshenv" # Not sourced on login

mkdir -p "$HOME/.zsh"

if [[ -x "${commands[git]}" ]]; then
    plugins+=git

    typeset -AU github_repos
    github_repos=(
    # Local Destination                            # Github Page
    "$DFS"                                         'joshtch/dotfiles'
    "$HOME/.tmux/plugins/tpm"                      'tmux-plugins/tpm'
    "$HOME/.zsh/dircolors-solarized"               'seebi/dircolors-solarized'
    "$HOME/.zsh/history-substring-search"          'zsh-users/zsh-history-substring-search'
    "$HOME/.zsh/syntax-highlighting"               'zsh-users/zsh-syntax-highlighting'
    "$ZSH"                                         'robbyrussell/oh-my-zsh'
    "$ZSH/custom/plugins/alias-tips"               'djui/alias-tips'
    "$ZSH/custom/plugins/deer"                     'Vifon/deer'
    "$ZSH/custom/plugins/docker-aliases"           'webyneter/docker-aliases'
    "$ZSH/custom/plugins/zsh-completions"          'zsh-users/zsh-completions'
    #"$ZSH/custom/plugins/expand-ealias.plugin.zsh" 'zigius/expand-ealias.plugin.zsh'
    "$ZSH/custom/plugins/zsh-auto-virtualenv"      'tek/zsh-auto-virtualenv'
    )

    github_url="https://github.com"
    for plugin_dir in "${(@k)github_repos}"; do
        if ! [[ -d "$plugin_dir" ]]; then
            git clone --recursive "$github_url/${github_repos[$plugin_dir]}" "$plugin_dir"
        fi
    done

    function update_plugins() {
        for plugin_dir in "${(@k)git_plugins}"; do
            ( cd "$plugin_dir" && git pull --recurse-submodules=yes ) ||
                git clone --recursive "${github_repos[$plugin_dir]}" "$plugin_dir"
        done
    }
fi

ZSH_THEME='nicoulaj'

plugins+=(
    alias-tips #expand-ealias #globalias
    copybuffer
    deer
    extract
    history
    pip python
    safe-paste
    systemadmin
    urltools web-search
    zsh-navigation-tools zsh-completions
)
#plugins+=(adb nmap ruby singlechar sudo systemadmin xcode zsh-auto-virtualenv)
[[ -x "${commands[autoenv]}" ]] && plugins+=autoenv
[[ -x "${commands[git]}" ]] && plugins+=git
[[ -x "${commands[rustc]}" ]] && plugins+=rust \
    && [[ -f "$HOME/.cargo/env" ]] && path+="$HOME/.cargo/env"
[[ -x "${commands[tmux]}" ]] && plugins+=tmux
[[ -x "${commands[pass]}" ]] && plugins+=pass
[[ -x "${commands[yarn]}" ]] && plugins+=yarn
[[ -x "${commands[yarn]}" ]] && plugins+=docker && plugins+=docker-aliases

[[ -e "${/usr/local/opt/resty/share/resty/resty}" ]] && \
    source /usr/local/opt/resty/share/resty/resty

plugins+=ssh-agent
zstyle :omz:plugins:ssh-agent agent-forwarding on

if [[ `uname` == 'Darwin' ]]; then
    if [ "$TERM_PROGRAM" = 'iTerm.app' ]; then
        ITERM2_INTEGRATION="${HOME}/.iterm2_shell_integration.zsh"
        (
            [[ -f "$ITERM2_INTEGRATION" ]] || \
                curl -L https://iterm2.com/misc/zsh_startup.in -o "$ITERM2_INTEGRATION"
        ) && source "$ITERM2_INTEGRATION"
    fi

    plugins+=osx
    [[ -x "${commands[brew]}" ]] && plugins+=brew && \
        if brew command command-not-found-init > /dev/null 2>&1; then \
            eval "$(brew command-not-found-init)"; fi

fi

source "$ZSH/oh-my-zsh.sh"

[[ -f "$DFS/aliases.zsh" ]] && source "$DFS/aliases.zsh"

[[ -f "$HOME/.localrc.zsh" ]] && source "$HOME/.localrc.zsh"

[[ -d "$HOME/.zsh/syntax-highlighting" ]] && \
    source "$HOME/.zsh/syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -d "$HOME/.zsh/history-substring-search" ]] && \
    source "$HOME/.zsh/history-substring-search/zsh-history-substring-search.zsh"

# This freezes Zsh's terminal state, so flow control works as normal after
# terminal apps crash
ttyctl -f

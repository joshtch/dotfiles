setopt NO_GLOBAL_RCS

[ -f "$HOME/.localenv.zsh" ] && source "$HOME/.localenv.zsh"

export EDITOR="${commands[vim]}"
export PAGER="${commands[less]}"

export ZDOTDIR="${ZDOTDIR:-$HOME}"
export ZSH="$HOME/.oh-my-zsh"
export DFS="$HOME/dotfiles"
export HOMEBREW_BREWFILE="$DFS/Brewfile"
export KEYTIMEOUT=1
export VIM_APP_DIR="/Applications"

eval `/usr/libexec/path_helper -s`
typeset -U path
path=(
    "$HOME/bin"
    "$HOME/local/bin"
    "$DFS/bin"
    "/usr/local/opt/coreutils/libexec/gnubin"
    "/opt/X11/bin"
    "/usr/local/bin"
    "/usr/local/sbin"
    "${path[@]}"
)

fpath=(
    "$DFS/zsh/functions"
    "${fpath[@]}"
)

# Pipe2Eval custom tmp directory -- only necessary for macOS
export PIP2EVAL_TMP_FILE_PATH=/tmp/shms

# Colored manpages
export LESS_TERMCAP_mb=$(printf "\e[1;31m")
export LESS_TERMCAP_md=$(printf "\e[1;35m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[4;36m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[3;34m")
export _NROFF_U=1

# for lesspipe.sh
export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1

# Use less as pager if no pager set
export PAGER="${commands[less]:-$PAGER}"

# Location of UEFI BIOS kernel (OVMF) for QEMU
export OVMF_BIOS="$HOME/tools/OVMF.fd"

# Graphviz -- environment variable used by PlantUML
export GRAPHVIZ_DOT="${commands[dot]}"

# rlwrap: readline wrapper
export RLWRAP_HOME="$HOME/.rlwrap/"
[ -d "$RLWRAP_HOME" ] || mkdir -p "$RLWRAP_HOME"

# pyenv auto-activate virtualenvs
[[ -x "${command[pyenv]}" ]] && [[ -x "${command[pyenv-virtualenv-init}" ]] \
    && eval "$(pyenv init -)" \
    && eval "$(pyenv virtualenv-init -)"

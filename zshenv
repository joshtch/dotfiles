setopt NO_GLOBAL_RCS

[ -f "$HOME/.localenv.zsh" ] && source "$HOME/.localenv.zsh"

export EDITOR="${commands[vim]}"
export PAGER="${commands[less]}"

export ZDOTDIR="${ZDOTDIR:-$HOME}"
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
export DFS="${DFS:-$HOME/dotfiles}"
export HOMEBREW_BREWFILE="$DFS/Brewfile"
export KEYTIMEOUT=1
export VIM_APP_DIR="/Applications"
export GPG_TTY="$(tty)"
export GLIBC_VERSION="$(ldd --version | awk '{print $NF; exit}')"

eval `/usr/libexec/path_helper -s`
typeset -U path
if [ "x$(uname)" = "xDarwin" ]; then
    path=(
        "/usr/local/opt/python@2/bin"
        "/usr/local/opt/coreutils/libexec/gnubin"
        "/opt/X11/bin"
        "${path[@]}"
    )
elif [ "x$(uname)" = "xLinux" ]; then
    path=(
        "/usr/lib64/qt-3.3/bin"
        "/opt/puppetlabs/bin"
        "${path[@]}"
    )
fi
path=(
    "$HOME/bin"
    "$HOME/local/bin"
    "$HOME/.local/bin"
    "$DFS/bin"
    "${path[@]}"
    "/usr/local/bin"
    "/usr/local/sbin"
    "/usr/sup/bin"
    "/bin"
    "/usr/bin"
    "/usr/cots/bin"
)
export PATH

[ -x "/usr/local/opt/go/libexec/bin/go" ] && \
    path+=/usr/local/opt/go/libexec/bin
[ -x "/usr/local/opt/ctags-exuberant/bin/ctags" ] && \
    path+=/usr/local/opt/ctags-exuberant/bin
export PATH

typeset -U fpath
fpath=(
    "$DFS/zsh/functions"
    "${fpath[@]}"
)
export FPATH

typeset -U manpath
manpath=(
    "$HOME/.local/share/man"
    "/usr/sup/man"
    "/usr/sup/share/man"
    "/usr/sup/provide/man"
    "/usr/share/man"
    "${manpath[@]}"
)
export MANPATH

typeset -U infopath
infopath=(
    "$HOME/.local/share/info"
    "$HOME/share/info"
    "${infopath[@]}"
)
export INFOPATH

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

# Instructions for default builds with GNU Make
typeset -U makefiles
for file in "$DFS/Makefile_defaults/"*.mk; do
    makefiles+=("$file")
done
typeset -T MAKEFILES makefiles ' '
export MAKEFILES
unsetopt nullglob

[ -x "${commands[go]}" ] && \
    export GOPATH="${GOPATH:-$HOME/go}"

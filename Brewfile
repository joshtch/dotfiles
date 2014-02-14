# Make sure we’re using the latest Homebrew
update

# Upgrade any already-installed formulae
upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
install coreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
install findutils
# Install Bash 4
install bash
install zsh

# Install wget with IRI support
install wget --enable-iri

# Install more recent versions of some OS X tools
install vim --override-system-vi
tap homebrew/dupes
install homebrew/dupes/grep
#tap josegonzalez/homebrew-php
#install php55

# Install other useful binaries
install colordiff
install emacs
install ffmpeg
install findutils
install fontconfig
install git
install mplayer
install openssl
install pkg-config
install readline
install the_silver_searcher
install tmux
install trash
uninstall ctags
install ctags-exuberant

tap homebrew/versions
install lua52

# Remove outdated versions from the cellar
cleanup

# Make sure we’re using the latest Homebrew
update

# Upgrade any already-installed formulae
upgrade

tap 'phinze/cask'
brew 'brew-cask'

tapall 'rcmdnk/brewall'

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew 'coreutils'
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew 'findutils'
# Install Bash 4
brew 'bash'
brew 'zsh'

# Install wget with IRI support
brew 'wget --enable-iri'

# Install more recent versions of some OS X tools
brew 'vim --override-system-vi'
tap 'homebrew/dupes'
brew 'homebrew/dupes/grep'
#tap 'josegonzalez/homebrew-php'
#brew 'php55'

# Install other useful binaries
brew 'colordiff'
brew 'emacs'
brew 'ffmpeg'
brew 'findutils'
brew 'fontconfig'
brew 'git'
brew 'mplayer'
brew 'openssl'
brew 'pkg-config'
brew 'readline'
brew 'the_silver_searcher'
brew 'tmux'
brew 'trash'
uninstall 'ctags'
brew 'ctags-exuberant'

tap 'homebrew/versions'
brew 'lua52'

# Add Cask binaries
cask 'bettertouchtool'
cask 'caffeine'
cask 'disk-inventory-x'
cask 'evernote'
cask 'geektool'
cask 'gimp'
cask 'gitx'
cask 'firefox'
cask 'keyremap4macbook'
cask 'macvim --with-lua'
cask 'onyx'
cask 'the-unarchiver'
cask 'vlc'

# Remove outdated versions from the cellar
cleanup

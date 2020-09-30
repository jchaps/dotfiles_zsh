echo -e "\n\nRunning brew.sh"

# Install Homebrew
brew update
brew upgrade

# removed packages
old_apps=(
  bash-completion2
  bats
  battery
  httpie
  jq
  peco
  psgrep
  shellcheck
)

# Install packages
apps=(
  coreutils
  diff-so-fancy
  dockutil
  fasd
  gh
  gnu-sed
  grep
  tldr
  tree
  wget
  wifi-password
)

brew install "${apps[@]}"

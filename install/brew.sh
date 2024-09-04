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
  wifi-password
  dockutil 
)

# Brew version of dockutil out of date. 
# Obtain directly from https://github.com/kcrawford/dockutil/releases

# Install packages
apps=(
  coreutils
  diff-so-fancy
  fasd
  ffmpeg
  gh
  gnu-sed
  grep
  speedtest-cli
  tldr
  tree
  wget
)

brew install "${apps[@]}"

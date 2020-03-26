echo -e "\n\nRunning brew-cask.sh"

#brew tap caskroom/cask
#brew install brew-cask
brew cask ls

# Install packages

apps=(
  atom
  google-chrome
  flux
  github-desktop
  macdown
  slack
  spotify
  aerial
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)

qlplugins=(
  qlcolorcode
  qlstephen
  qlmarkdown
  quicklook-json
  jupyter-notebook-ql
  qlvideo
  quicklook-csv
  betterzipql
  qlimagesize
  suspicious-package
)
brew cask install "${qlplugins[@]}"

echo -e "\n\nRunning brew-cask.sh"

#brew tap caskroom/cask
#brew install brew-cask
brew list --cask

# Install packages

apps=(
  caffeine
  google-chrome
  aerial
  zoom
  tripmode
  hey
  visual-studio-code
)

brew install --force --cask "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)

qlplugins=(
  qlcolorcode
  qlstephen
  qlmarkdown
  quicklook-json
  jupyter-notebook-ql
  qlvideo
  quicklook-csv
  suspicious-package
)
brew install --force --cask "${qlplugins[@]}"

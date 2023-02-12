#!/bin/sh

# Set up the order of dock icons
dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Safari.app"
dockutil --no-restart --add "/System/Applications/Calendar.app"
dockutil --no-restart --add "/Applications/HEY.app"
#dockutil --no-restart --add "/Applications/Twitterrific.app"  REPLACE WITH IVORY
dockutil --no-restart --add "/System/Applications/Photos.app"
dockutil --no-restart --add "/System/Applications/Messages.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/System/Applications/Utilities/Terminal.app"
dockutil --no-restart --add "/System/Applications/System Preferences.app"
dockutil --no-restart --add '~/Documents' --view grid --display stack --sort datemodified
dockutil --no-restart --add '~/Downloads' --view grid --display stack --sort datemodified
killall Dock

#defaults write com.apple.dock persistent-others -array-add '{ "tile-data" = { "list-type" = 1; }; "tile-type" = "recents-tile"; }'

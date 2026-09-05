echo -e "\n\nRunning brew-cask.sh"

#brew tap caskroom/cask
#brew install brew-cask
brew list --cask

# Deprecated casks, no longer installed by this script (kept as a record;
# not auto-uninstalled since they may still be wanted on some machines):
#   caffeine, suspicious-package, tripmode

# Install packages

apps=()
while IFS= read -r item
do
    [ -n "$item" ] && apps+=("$item")
done <<EOF
$(select_items "Casks:" google-chrome zoom visual-studio-code)
EOF

[ "${#apps[@]}" -gt 0 ] && brew install --force --cask "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)

qlplugins=()
while IFS= read -r item
do
    [ -n "$item" ] && qlplugins+=("$item")
done <<EOF
$(select_items "Quick Look plugins:" qlcolorcode qlstephen qlmarkdown quicklook-json jupyter-notebook-ql qlvideo quicklook-csv)
EOF

[ "${#qlplugins[@]}" -gt 0 ] && brew install --force --cask "${qlplugins[@]}"

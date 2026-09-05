#!/bin/sh

echo -e "\n\nRunning brew.sh"

# Install Homebrew
brew update

# Upgrading every installed package is slow and can be disruptive, so it's
# opt-in: run with DOTFILES_UPGRADE=1 ./install.sh to also upgrade.
if [ "${DOTFILES_UPGRADE:-0}" = "1" ]
then
    brew upgrade
fi

# Deprecated packages, no longer installed by this script (kept as a record;
# not auto-uninstalled since they may still be wanted on some machines):
#   bash-completion2, bats, battery, fasd, httpie, jq, peco, psgrep,
#   shellcheck, wifi-password, dockutil, gcc, gnu-sed, speedtest-cli

# Brew version of dockutil out of date.
# Obtain directly from https://github.com/kcrawford/dockutil/releases

# Install packages
apps=()
while IFS= read -r item
do
    [ -n "$item" ] && apps+=("$item")
done <<EOF
$(select_items "Homebrew formulae:" coreutils diff-so-fancy ffmpeg gh grep tldr tree wget)
EOF

[ "${#apps[@]}" -gt 0 ] && brew install "${apps[@]}"

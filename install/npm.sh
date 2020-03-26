echo -e "\n\nRunning npm.sh"

# source nvm environment
. "${DOTFILES_DIR}/system/nvm"

nvm install node

# Globally install with npm

packages=(
  get-port-cli
  vtop
)

npm install -g "${packages[@]}"

# HomeBrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Miniconda
wget https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -u -p $HOME/miniconda
export PATH="$HOME/miniconda/bin:$PATH"
rm ~/miniconda.sh

# Conda completion
git clone https://github.com/esc/conda-zsh-completion "$DOTFILES_DIR/bin/conda-zsh-completion/"

# NVM
if [ ! -d "$HOME/.nvm/.git" ]
then
    echo "Installing NVM"
    git clone https://github.com/nvm-sh/nvm.git "$HOME/.nvm"
else
    echo "Upgrading NVM"
    git --git-dir="$HOME/.nvm/.git" --work-tree="$HOME/.nvm" fetch --tags origin
fi

export GIT_DIR="$HOME/.nvm/.git"
export GIT_WORK_TREE="$HOME/.nvm"
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
unset GIT_DIR
unset GIT_WORK_TREE


# NPM Completion
if [ ! -d "$DOTFILES_DIR/bin/zsh-better-npm-completion/.git" ]
then
    echo "Installing NPM Completion"
    git clone https://github.com/lukechilds/zsh-better-npm-completion.git "$DOTFILES_DIR/bin/zsh-better-npm-completion"
else
    echo "Upgrading NPM Completion"
    git --git-dir="$DOTFILES_DIR/bin/zsh-better-npm-completion/.git" --work-tree="$DOTFILES_DIR/bin/zsh-better-npm-completion" fetch --tags origin
fi

# Powerlevel10k terminal
if [ ! -d "$DOTFILES_DIR/bin/powerlevel10k/.git" ]
then
    echo "Installing Powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$DOTFILES_DIR/bin/powerlevel10k"
else
    echo "Upgrading Powerlevel10k"
    git --git-dir="$DOTFILES_DIR/bin/powerlevel10k/.git" --work-tree="$DOTFILES_DIR/bin/powerlevel10k" fetch --depth=1
fi


# Font installation
if [ "$(uname)" == "Darwin" ]
then
    curl -fLo "$HOME/Library/Fonts/MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    curl -fLo "$HOME/Library/Fonts/MesloLGS NF Bold.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    curl -fLo "$HOME/Library/Fonts/MesloLGS NF Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    curl -fLo "$HOME/Library/Fonts/MesloLGS NF Bold Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
else
    mkdir -p ~/.local/share/fonts
    curl -fLo "$HOME/.local/share/fonts/MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    curl -fLo "$HOME/.local/share/fonts/MesloLGS NF Bold.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    curl -fLo "$HOME/.local/share/fonts/MesloLGS NF Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    curl -fLo "$HOME/.local/share/fonts/MesloLGS NF Bold Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
fi

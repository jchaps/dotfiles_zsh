#!/bin/sh

echo -e "\n\nRunning conda.sh"

# Miniconda
if [ ! -x ~/miniconda/bin/conda ] && confirm_step "Install Miniconda?"
then
    mkdir -p ~/miniconda

    if [ "$(uname)" = "Darwin" ]
    then
        curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/miniconda/miniconda.sh
    elif [ "$(uname)" = "Linux" ]
    then
       wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda/miniconda.sh
    fi

    bash ~/miniconda/miniconda.sh -b -u -p ~/miniconda
    rm ~/miniconda/miniconda.sh

    ~/miniconda/bin/conda init zsh
fi

export PATH="$HOME/miniconda/bin:$PATH"

# Conda completion
if [ ! -d "$DOTFILES_DIR/bin/conda-zsh-completion/.git" ]
then
    echo "Installing Conda Completion"
    git clone https://github.com/esc/conda-zsh-completion.git "$DOTFILES_DIR/bin/conda-zsh-completion"
else
    echo "Upgrading Conda Completion"
    git --git-dir="$DOTFILES_DIR/bin/conda-zsh-completion/.git" --work-tree="$DOTFILES_DIR/bin/conda-zsh-completion" fetch --tags origin
fi

# Install default packages
packages=()
while IFS= read -r item
do
    [ -n "$item" ] && packages+=("$item")
done <<EOF
$(select_items "Conda packages:" jupyter matplotlib numpy pandas scikit-learn seaborn)
EOF

[ "${#packages[@]}" -gt 0 ] && conda install -y "${packages[@]}"


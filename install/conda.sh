#!/bin/sh

echo -e "\n\nRunning conda.sh"

# Miniconda
mkdir -p ~/miniconda

if [ "$(uname)" == "Darwin" ]
then
    curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/miniconda/miniconda.sh
elif [ "$(uname)" == "Linux" ]
then
   wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda/miniconda.sh
fi

bash ~/miniconda/miniconda.sh -b -u -p ~/miniconda
export PATH="$HOME/miniconda/bin:$PATH"
rm ~/miniconda/miniconda.sh

~/miniconda/bin/conda init zsh

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
packages=(
  jupyter
  matplotlib
  numpy
  pandas
  scikit-learn
  seaborn
  )   

 conda install -y "${packages[@]}"



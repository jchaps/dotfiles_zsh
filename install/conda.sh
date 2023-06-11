echo -e "\n\nRunning conda.sh"

# Miniconda
wget https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-arm64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -u -p $HOME/miniconda
export PATH="$HOME/miniconda/bin:$PATH"
rm ~/miniconda.sh

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
  scipy
  pandas
  pylint
  scikit-learn
  seaborn
  line_profiler
  memory_profiler
  numexpr
  pandas-datareader
  )

conda install -y "${packages[@]}"

#!/bin/sh

export DOTFILES_DIR

dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)

DOTFILES_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)

# Update dotfiles itself first
[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Bunch of symlinks
ln -sfv "$DOTFILES_DIR/runcom/.zshrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.vimrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.p10k.zsh" ~
ln -sfv "$DOTFILES_DIR/runcom/docker-compose.yml" ~
ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/git/.gitignore_global" ~
ln -sfv "$DOTFILES_DIR/vim/" ~/.vim

if [ "$(uname)" == "Darwin" ]
then
    # Package managers & packages
     . "$DOTFILES_DIR/install/git.sh"
     . "$DOTFILES_DIR/install/brew.sh"
     . "$DOTFILES_DIR/install/brew-cask.sh"
     . "$DOTFILES_DIR/install/conda.sh"
elif [ "$(echo $(echo $(uname -a) | cut -b 1-17))" == "Linux Diskstation" ]
then
    # Package managers & packages
     . "$DOTFILES_DIR/install/git.sh"
fi

mkdir -pv "$DOTFILES_DIR/vim/backups"
mkdir -pv "$DOTFILES_DIR/vim/swaps"
mkdir -pv "$DOTFILES_DIR/vim/undo"

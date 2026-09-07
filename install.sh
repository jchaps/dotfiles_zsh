#!/bin/sh

export DOTFILES_DIR

DOTFILES_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)

. "$DOTFILES_DIR/install/lib.sh"

# Batch vs interactive mode. DOTFILES_INTERACTIVE=0/1 skips the prompt (handy
# for scripting); with no TTY (e.g. curl | sh) there's no one to prompt, so
# fall back to batch rather than hang on a read that can never be answered.
export INTERACTIVE
if [ -n "$DOTFILES_INTERACTIVE" ]
then
    INTERACTIVE=$DOTFILES_INTERACTIVE
elif [ -t 0 ] && [ -t 1 ]
then
    printf 'Run install in (b)atch or (i)nteractive mode? [b] '
    read -r mode
    case "$mode" in
        i|I) INTERACTIVE=1 ;;
        *) INTERACTIVE=0 ;;
    esac
else
    INTERACTIVE=0
fi

# Update dotfiles itself first
if [ -d "$DOTFILES_DIR/.git" ] && confirm_step "Update dotfiles repo (git pull)?"
then
    git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin main
fi

# Bunch of symlinks
if confirm_step "Symlink dotfiles into \$HOME?"
then
    ln -sfv "$DOTFILES_DIR/runcom/.zshrc" ~
    ln -sfv "$DOTFILES_DIR/runcom/.vimrc" ~
    ln -sfv "$DOTFILES_DIR/runcom/.p10k.zsh" ~
    # docker-compose.yml is intentionally untracked (personal/local services);
    # only link it if you've dropped one in runcom/ yourself.
    [ -f "$DOTFILES_DIR/runcom/docker-compose.yml" ] && ln -sfv "$DOTFILES_DIR/runcom/docker-compose.yml" ~
    ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
    ln -sfv "$DOTFILES_DIR/git/.gitignore_global" ~
    ln -sfv "$DOTFILES_DIR/vim/" ~/.vim
fi

if [ "$(uname)" = "Darwin" ]
then
    # Package managers & packages
    confirm_step "Run Homebrew/fonts/dockutil setup (git.sh)?" && . "$DOTFILES_DIR/install/git.sh"
    confirm_step "Install Homebrew formulae (brew.sh)?" && . "$DOTFILES_DIR/install/brew.sh"
    confirm_step "Install Homebrew casks & QuickLook plugins (brew-cask.sh)?" && . "$DOTFILES_DIR/install/brew-cask.sh"
    confirm_step "Install Miniconda & conda packages (conda.sh)?" && . "$DOTFILES_DIR/install/conda.sh"
elif [ "$(uname -a | cut -b 1-17)" = "Linux Diskstation" ]
then
    # Package managers & packages
    confirm_step "Run Homebrew/fonts/dockutil setup (git.sh)?" && . "$DOTFILES_DIR/install/git.sh"
    confirm_step "Install Homebrew formulae (brew.sh)?" && . "$DOTFILES_DIR/install/brew.sh"
fi

mkdir -pv "$DOTFILES_DIR/vim/backups"
mkdir -pv "$DOTFILES_DIR/vim/swaps"
mkdir -pv "$DOTFILES_DIR/vim/undo"

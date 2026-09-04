# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi


# Resolve DOTFILES_DIR (assuming ~/projects/dotfiles_zsh on distros without readlink and/or $BASH_SOURCE/$0)

READLINK=$( echo "$(which greadlink || which readlink) " | tail -n1); 
CURRENT_SCRIPT=${(%):-%N}

if [[ -n $CURRENT_SCRIPT && -x "$READLINK" ]]; then
  SCRIPT_PATH=$($READLINK -f "$CURRENT_SCRIPT")
  DOTFILES_DIR=$(dirname "$(dirname "$SCRIPT_PATH")")
elif [ -d "$HOME/projects/dotfiles_zsh" ]; then
  DOTFILES_DIR="$HOME/projects/dotfiles_zsh"
else
  echo "Unable to find dotfiles, exiting."
  return # `exit 1` would quit the shell itself
fi

# Finally we can source the dotfiles (order matters)
# {function,path,opt,alias,completion,grep,prompt,nvm,custom}
for DOTFILE in "$DOTFILES_DIR"/system/{function,path,opt,alias,completion,prompt}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done

# Support local zprofile customization
[ -f ~/.zprofile ] && . ~/.zprofile

# >>> conda initialize >>>
# NOTE: deliberately NOT using `conda shell.zsh hook` here - it forks a full
# Python interpreter and costs 150ms-1s+ on every shell startup. Sourcing
# conda.sh directly gets the `conda` command/activation for a fraction of
# that. If you ever re-run `conda init`, it will overwrite this block with
# the slow hook version - undo it back to this if so.
if [ -f "$HOME/miniconda/etc/profile.d/conda.sh" ]; then
    . "$HOME/miniconda/etc/profile.d/conda.sh"
else
    export PATH="$HOME/miniconda/bin:$PATH"
fi
# <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

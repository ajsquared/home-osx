# User configuration
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME=""

ENABLE_CORRECTION="true"
unsetopt listbeep

plugins=(git brew git-extras macos sudo tmux gradle)

source $ZSH/oh-my-zsh.sh

autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:prompt:success color green

source $HOME/.env_vars
source "$HOME/.bash_aliases"


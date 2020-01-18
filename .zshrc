# User configuration
source $HOME/.env_vars

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME=""

ENABLE_CORRECTION="true"
unsetopt listbeep

plugins=(git brew git-extras osx sudo tmux gradle pyenv)

source $ZSH/oh-my-zsh.sh

autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:prompt:success color green

source "$HOME/.bash_aliases"


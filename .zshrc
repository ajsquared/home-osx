# User configuration
source $HOME/.env_vars

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="dst"

ENABLE_CORRECTION="true"
unsetopt listbeep

plugins=(git brew git-extras osx sudo tmux zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

source "$HOME/.bash_aliases"

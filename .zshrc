export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="dst"

ENABLE_CORRECTION="true"
unsetopt listbeep

plugins=(git brew git-extras osx sudo zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
export GOROOT="/usr/local/go"
export GOPATH="$HOME/Documents/projects/go"
export INPUTRC="~/.inputrc"
export CDPATH=.:~
export PATH="/usr/local/bin:$PATH:$HOME/.scripts:/usr/texbin:$GOROOT/bin:$GOPATH/bin"
export EDITOR="/usr/local/bin/emacsclient"
export TERM="xterm-256color"

source "$HOME/.bash_aliases"

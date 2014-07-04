# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Set that the terminal is capable of 256 colors
export TERM="xterm-256color"

# Alias definitions
source "$HOME/.bash_aliases"

# enable programmable completion features
export BREW_PREFIX=$(/usr/local/bin/brew --prefix)
if [ -f "$BREW_PREFIX/etc/bash_completion" ]; then
    . "$BREW_PREFIX/etc/bash_completion"
fi

export GOROOT="/usr/local/go"
export GOPATH="$HOME/Documents/projects/go"
export INPUTRC="~/.inputrc"
export CDPATH=.:~
export PATH="/usr/local/bin:$PATH:$HOME/.scripts:/usr/texbin:$GOROOT/bin:$GOPATH/bin"
export EDITOR="/usr/local/bin/emacsclient"

# Make man more useful for shell built-ins
man () {
    /usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less) 
}

# Enable liquidprompt
source "$HOME/.liquidprompt"

# Tmux session tab-completion
_tma() {
        TMUX_SESSIONS=$(tmux ls | awk '{print $1}' | sed 's/://g' | xargs)

            local cur=${COMP_WORDS[COMP_CWORD]}
                COMPREPLY=( $(compgen -W "$TMUX_SESSIONS" -- $cur) )
                }
complete -F _tma tma

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set that the terminal is capable of 256 colors
export TERM="xterm-256color"

# Alias definitions
source "$HOME/.bash_aliases"

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
export BREW_PREFIX=$(brew --prefix)
if [ -f "$BREW_PREFIX/etc/bash_completion" ]; then
    . "$BREW_PREFIX/etc/bash_completion"
fi

export PYTHONSTARTUP="$HOME/.pythonrc.py"
export INPUTRC="~/.inputrc"
export CDPATH=.:~
export PATH="/usr/local/bin:$PATH:$HOME/.scripts:/usr/texbin:"
export M2_HOME=/usr/share/maven
export MAVEN_OPTS=-Xmx1024m
export EDITOR="/usr/local/bin/emacsclient -c"

# Make man more useful for shell built-ins
man () {
    /usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less) 
}

# Enable liquidprompt
source "$HOME/.liquidprompt"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Tmux session tab-completion
_tma() {
        TMUX_SESSIONS=$(tmux ls | awk '{print $1}' | sed 's/://g' | xargs)

            local cur=${COMP_WORDS[COMP_CWORD]}
                COMPREPLY=( $(compgen -W "$TMUX_SESSIONS" -- $cur) )
                }
complete -F _tma tma

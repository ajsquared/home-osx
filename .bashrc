# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Alias definitions
source "$HOME/.bash_aliases"

# enable programmable completion features
export BREW_PREFIX=$(/usr/local/bin/brew --prefix)
if [ -f "$BREW_PREFIX/etc/bash_completion" ]; then
    . "$BREW_PREFIX/etc/bash_completion"
fi

source "$HOME/.env_vars"

# Make man more useful for shell built-ins
man () {
    /usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less) 
}

# Enable liquidprompt
source "$HOME/.liquidprompt"

# Tmux session tab-completion
alias tma='tmux attach -t $1'
_tma() {
        TMUX_SESSIONS=$(tmux ls | awk '{print $1}' | sed 's/://g' | xargs)

            local cur=${COMP_WORDS[COMP_CWORD]}
                COMPREPLY=( $(compgen -W "$TMUX_SESSIONS" -- $cur) )
                }
complete -F _tma tma

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

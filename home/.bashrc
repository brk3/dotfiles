# if not running interactively, don't do anything
[ -z "$PS1" ] && return

[[ -z "$TMUX" ]] && exec tmux

# don't put duplicate lines in the history
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f "/usr/local/etc/bash_completion.d/git-completion.bash" ]; then
  source "/usr/local/etc/bash_completion.d/git-completion.bash"
fi

source ~/.bash_colors
if [ -f "/usr/local/etc/bash_completion.d/git-prompt.sh" ]; then
  source "/usr/local/etc/bash_completion.d/git-prompt.sh"
  export GIT_PS1_SHOWDIRTYSTATE=1
  PS1="\u@\h:$BCyan\w$Yellow\$(__git_ps1)\\e[0m\n\$ "
fi

# alias definitions.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
        eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --exclude-dir=.git --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias gvim='gvim -geom 85x55'
alias pp='python -mjson.tool'
alias homeshick="$HOME/.homesick/repos/homeshick/home/.homeshick"

# bash completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

# disable tilde expansion
_expand() {
    return 0;
}
__expand_tilde_by_ref() {
    return 0;
}

# open all files recursively under a directory
function vimr() { vim -p $(find "$@" -type f | xargs) ;}

get_field () {
    while read data; do
        if [ "$1" -lt 0 ]; then
            field="(\$(NF$1))";
        else
            field="\$$(($1 + 1))";
        fi;
        echo "$data" | awk -F'[ \t]*\\|[ \t]*' "{print $field}";
    done
}

export EDITOR=vim
export BROWSER=firefox
export JAVA_HOME=$HOME/bin/jdk1.7.0_21
export ANDROID_HOME=$HOME/bin/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$HOME/bin:$HOME/.rvm/bin
export TERM="xterm-256color"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

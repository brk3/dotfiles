# if not running interactively, don't do anything
[ -z "$PS1" ] && return

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

# if this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
        eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --exclude-dir=.git --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias meteorsms='ssh bourke-desktop meteorsms $1'
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

export PATH=$HOME/bin/android-sdk-linux/platform-tools/:$HOME/bin/android-sdk-linux/tools:$PATH
export EDITOR=vim
export BROWSER=/usr/bin/firefox
export JAVA_HOME=/usr/lib/jvm/jdk1.6.0_43
export ANDROID_HOME=$HOME/bin/android-sdk-linux

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
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

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
        eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --exclude-dir=.git --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias meteorsms='ssh bourke-desktop meteorsms $1'
alias gvim='gvim -geom 85x55'
alias pp='python -mjson.tool'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export PATH=$HOME/bin/android-sdk-linux/platform-tools/:$HOME/bin/android-sdk-linux/tools:$PATH
export EDITOR=vim
export BROWSER=/usr/bin/firefox
export JAVA_HOME=/usr/lib/jvm/jdk1.6.0_43
export ANDROID_HOME=$HOME/bin/android-sdk-linux

export USE_CCACHE=1

# disable tilde expansion
_expand() {
    return 0;
}
__expand_tilde_by_ref() {
    return 0;
}

#PS1='\u@\h:\W$(__git_ps1 "[%s]")\$ '

# Open all files recursively under a directory
function vimr() { vim -p $(find "$@" -type f | xargs) ;}

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

alias homeshick="$HOME/.homesick/repos/homeshick/home/.homeshick"

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

### Functions ###
jobscount() {
  local stopped=$(jobs -sp | wc -l)
  if [[ $stopped > 0 ]]; then
    echo -n "[$stopped]"
  fi
}

vimr() { vim -p $(find "$@" -type f | xargs) ;}

_ssh_auth_save() {
  ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh-auth-sock.$HOSTNAME"
}

# disable tilde expansion
_expand() {
    return 0;
}
__expand_tilde_by_ref() {
    return 0;
}

### Env vars ###

# Custom bash prompt via kirsle.net/wizards/ps1.html
# Single quotes stop early subsitution so jobscount is executed every time
export PS1='\[$(tput bold)\]\[$(tput setaf 1)\]\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h:\[$(tput setaf 5)\]\W\[$(tput setaf 1)\]\[$(tput setaf 7)\]$(jobscount)$ \[$(tput sgr0)\]'
export EDITOR=vim
export JAVA_HOME=$HOME/bin/jdk1.7.0_21
export ANDROID_HOME=$HOME/bin/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$HOME/bin:$HOME/.rvm/bin:$JAVA_HOME/bin
export TERM="xterm-256color"
export GOPATH=$HOME/golang
export HISTSIZE=10000
export HISTCONTROL=ignoreboth  # don't put duplicate lines in the history

### shopts ###
# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

### Source ###
source ~/.bash_colors

if [ -f "/usr/local/etc/bash_completion.d/git-prompt.sh" ]; then
  source "/usr/local/etc/bash_completion.d/git-prompt.sh"
  export GIT_PS1_SHOWDIRTYSTATE=1
  PS1="\u@\h:$BCyan\w$Yellow\$(__git_ps1)\\e[0m\n\$ "
fi

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

if [[ -f "/usr/share/virtualenvwrapper/virtualenvwrapper.sh" ]]; then
    source "/usr/share/virtualenvwrapper/virtualenvwrapper.sh"
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    source /etc/bash_completion
fi

### Aliases ###
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
        eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --exclude-dir=.git --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='ls -G'
fi

alias gvim='gvim -geom 85x55'
alias pp='python -mjson.tool'
alias os='openstack'
alias screen='_ssh_auth_save ; export HOSTNAME=$(hostname) ; screen'
alias tmux='_ssh_auth_save ; export HOSTNAME=$(hostname) ; tmux'

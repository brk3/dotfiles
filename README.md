dotfiles
========
```
git clone git://github.com/andsens/homeshick.git \
    $HOME/.homesick/repos/homeshick
printf '\nalias homeshick="$HOME/.homesick/repos/homeshick/home/.homeshick"' \
    >> $HOME/.bashrc
source .bashrc
homeshick clone git@github.com:brk3/dotfiles.git
```

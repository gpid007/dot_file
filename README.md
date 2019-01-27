# INSTALL
Copy paste install

```bash
    git clone https://github.com/gpid007/dot_file.git $HOME
    ./dot_file/install_vim_tmux.sh
    ./dot_file/root_install.sh
```


## CONFIG

GUI settings for `PUTTY`
```bash
    Connection > Data > Terminal-type-string = xterm-256color
```

GUI settings for `gnome-terminal`
```bash
    Preferences > Colors
        Text and Background Color > Built-in schemes: Solarized dark
        Palette > Built-in schemes: Solarized
        DISABLE: Show bold text in bright colors
```


## ADDENDUM

Included `tmux` configuration
```bash
    cat <<EOF>> ~/.tmux.conf
    set -g default-terminal "screen-256color"
    EOF
```

Excluded `screen` config
```bash
    cat <<EOF>> ~/.screenrc
    term "screen-256color"
    EOF
```

Excluded `vim` config for `screen`
```bash
    cat <<EOF>>~/.vimrc
    if &term == "screen"
       set t_Co=256
    endif
    EOF
```

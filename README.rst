=======
INSTALL
=======

RUN
---
```bash
   git clone https://github.com/gpid007/dot_file.git $HOME
    ./dot_file/install_vim_tmux.sh
```

CONFIG
------
.. PUTTY::
    Connection > Data > Terminal-type-string = xterm-256color

.. GNOME-TERMINAL::
    Preferences > Colors
        Text and Background Color > Built-in schemes: Solarized dark
        Palette > Built-in schemes: Solarized
        DISABLE: Show bold text in bright colors

INFO
----
.. TMUX::
    cat <<EOF>> ~/.tmux.conf
    set -g default-terminal "screen-256color"
    EOF

.. SCREEN::
    cat <<EOF>> ~/.screenrc
    term "screen-256color"
    EOF

.. VIM::
    cat <<EOF>>~/.vimrc
    if &term == "screen"
       set t_Co=256
    endif
    EOF


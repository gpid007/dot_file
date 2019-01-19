============
INSTALLATION
============
.. code-block:: 
    git clone https://github.com/gpid007/dot_file.git $HOME
    ./dot_file/install_vim_tmux.sh

PUTTY
-----
.. code-block::
    Connection > Data > Terminal-type-string = xterm-256color

GNOME-TERMINAL
--------------
.. code-block::
    Preferences > Colors
        Text and Background Color > Built-in schemes: Solarized dark
        Palette > Built-in schemes: Solarized
        DISABLE: Show bold text in bright colors

INFO
----

TMUX
.. code-block::
    cat <<EOF>> ~/.tmux.conf
    set -g default-terminal "screen-256color"
    EOF

SCREEN
.. code-block::
    cat <<EOF>> ~/.screenrc
    term "screen-256color"
    EOF

VIM
.. code-block::
    cat <<EOF>>~/.vimrc
    if &term == "screen"
       set t_Co=256
    endif
    EOF


#!/bin/bash
set -e

echo Copying conf files!
cd ~/Dropbox/dot_file
cp -v ~/.vimrc vimrc
cp -v ~/.tmux.conf tmux.conf
cp -v ~/Dropbox/initial_install/Preferences.sublime-settings .
cp -v ~/Dropbox/initial_install/Monokai.sublime-color-scheme .
cp -v ~/Dropbox/initial_install/vim_tmux_install.sh .
cp -v ~/Dropbox/initial_install/colemak_us .

echo Doing git push!
if [ ! -f ~/.git-credentials ]; then
git config --global credential.hepler store 
git config --global user.email "heine.gregor@gmail.com"
git config --global user.name "gpid007"
fi

git add *
git commit -m "$(hostname) $(date)"
git push

echo Done.

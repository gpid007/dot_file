#!/bin/bash
set -e

echo -e "\n# ====================== INSTALL VIM TMUX ====================== #"
VIM=~/vim
VDOT=~/.vim
GIT_BASH=~/.bash-git-prompt
DIR_ARR=($VIM $VDOT $GIT_BASH)


echo -e "\n# ========== OS-RELEASE INSTALL ========== #"
if [ $(which yum) ]; then
    sudo yum install -y vim git tmux 
else
    sudo apt install -y vim git tmux 
fi


echo -e "\n# ========== GIT CLONE ========== #"
cd $HOME
for dir in ${DIR_ARR[@]}; do
    if [ -d "$dir" ]; then
        rm -rf $dir
    fi
done
git clone https://github.com/magicmonty/bash-git-prompt.git $GIT_BASH --depth=1


echo -e "\n# ========== VIM ========== #"
cp ~/dot_file/light-vimrc ~/.vimrc


echo -e "\n# ========== TMUX ========== #"
if [[ $(tmux -V | sed 's/[^0-9]*//g') -ge "21" ]]; then
cat <<EOF> ~/.tmux.conf
# ---------- MOUSE MODE ----------
set -g mouse on
# ---------- KEY REMAPPING ----------
bind m set -g mouse on \; display "Mouse ON"
bind M set -g mouse off \; display "Mouse OFF"
EOF
else
cat <<EOF> ~/.tmux.conf
# ---------- MOUSE MODE ----------
set -g mode-mouse on
set -g mouse-resize-pane on
set -g mouse-select-pane on
set -g mouse-select-window on
# ---------- KEY REMAPPING ----------
bind m set -g mode-mouse on \; set -g mouse-resize-pane on \; set -g mouse-select-pane on \; set -g mouse-select-window on \; display "Mouse ON"
bind M set -g mode-mouse off \; set -g mouse-resize-pane off \; set -g mouse-select-pane off \; set -g mouse-select-window off \; display "Mouse OFF"
EOF
fi
cat ~/dot_file/tmux.conf >> ~/.tmux.conf


echo -e "\n# ========== GIT BASH ========= #"
cat <<EOF>> ~/.bashrc
GIT_PROMPT_THEME=Solarized
GIT_PROMPT_ONLY_IN_REPO=1
source $GIT_BASH/gitprompt.sh
EOF

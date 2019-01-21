#!/bin/bash
set -e


sudo echo -e "\n# ====================== #\n#    INSTALL VIM TMUX    #\n# ====================== #"
VIM=~/vim
VDOT=~/.vim
GIT_BASH=~/.bash-git-prompt
DIR_ARR=($VIM $VDOT $GIT_BASH)
OWN_PATH=$(dirname "$relpath $0")
LOG=$OWN_PATH/log_install


echo -e "\n$(date +%Y-%m-%d' '%T) \n# ========== OS-RELEASE INSTALL ========== #" | tee -a $LOG
if [ $(which yum) ]; then
    sudo yum install -y vim git gcc gcc-c++ ctags cmake python3-devel golang ncurses-devel tmux
else
    sudo apt install -y vim git gcc g++ ctags cmake python3-dev golang-go ncurses-dev tmux
fi
echo "Success" | tee -a $LOG


echo -e "\n$(date +%Y-%m-%d' '%T) \n# ========== GIT CLONE ========== #" | tee -a $LOG
cd $HOME
for dir in ${DIR_ARR[@]}; do
    if [ -d "$dir" ]; then
        rm -rf $dir
    fi
done

git clone https://github.com/vim/vim.git $VIM
git clone https://github.com/magicmonty/bash-git-prompt.git $GIT_BASH --depth=1
git clone https://github.com/VundleVim/Vundle.vim.git $VDOT/bundle/Vundle.vim
git clone https://github.com/majutsushi/tagbar.git $VDOT/bundle/tagbar
git clone https://github.com/drmingdrmer/xptemplate.git $VDOT/xptemplate
git clone https://github.com/Valloric/YouCompleteMe.git $VDOT/bundle/YouCompleteMe
git clone https://github.com/lifepillar/vim-solarized8.git $VDOT/pack/themes/opt/solarized8
git clone https://github.com/itchyny/lightline.vim $VDOT/bundle/lightline.vim
# git clone https://github.com/Rip-Rip/clang_complete.git $VDOT/clang_complete

echo "Success" | tee -a $LOG


echo -e "\n$(date +%Y-%m-%d' '%T) \n# ========== VIM 8 ========== #" | tee -a $LOG

# ---------- VIM 8 INSTALL ---------- #
cd $VIM
./configure --with-features=huge --enable-multibyte --enable-python3interp
cd src
sudo make
sudo make install
sudo ln -sf /usr/local/bin/vim /usr/bin/vim
sudo rm -rf $VIM

# ---------- YOUCOMPLETEME ---------- #
cd $VDOT/bundle/YouCompleteMe
git submodule update --init --recursive
python3 install.py --go-completer --clang-completer
sudo pip3 install yapf pycodestyle

# ---------- VIMRC ---------- #
cp ~/dot_file/vimrc ~/.vimrc

# ---------- BUNDLE ---------- #
vim -c 'BundleInstall!' -c 'qa!'

echo "Success" | tee -a $LOG


echo -e "\n$(date +%Y-%m-%d' '%T) \n# ========== TMUX ========== #" | tee -a $LOG

# ---------- .TMUX.CONF  ----------
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
# ---------- .TMUX.CONF COPY  ----------
cat ~/dot_file/tmux.conf >> ~/.tmux.conf
echo "Success" | tee -a $LOG
echo -e "\n$(date +%Y-%m-%d' '%T) \n# ========== GIT BASH ========= #" | tee -a $LOG
cat <<EOF>> ~/.bashrc
GIT_PROMPT_THEME=Solarized
GIT_PROMPT_ONLY_IN_REPO=1
source $GIT_BASH/gitprompt.sh
EOF
echo "Success" | tee -a $LOG
# ========== DONE ========== #
echo "Done." | tee -a $LOG
cat $LOG
exit
# ========== DONE ========== #
echo -e "\n$(date +%Y-%m-%d' '%T) \n# ========== BASHRC PS1 ========== #" | tee -a $LOG
# ---------- INSTANCE_NAME ----------
cat <<EOF> ~/instance_name
micro1
EOF
# ---------- EC2-USER ----------
cat <<EOF> ~/.bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
alias ll='echo \$(ls -Ahl | wc -l)'
alias lu="ls -a"
PS1='\[\033[00;32m\]\u\[\033[00m\]@\[\033[00;32m\]$(cat ~/instance_name):\[\033[00m\]\w\[\033[00;32m\]\$\[\033[0m\]\n'
EOF
# ---------- ROOT  ----------
cat <<EOF | sudo tee /root/.bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
alias ll='echo \$(ls -Ahl | wc -l)'
alias lu="ls -a"
PS1='\[\033[00;31m\]\u\[\033[00m\]@\[\033[00;31m\]$(cat ~/instance_name):\[\033[00m\]\w\[\033[00;31m\]\$\[\033[0m\]\n'
EOF
echo "Success" | tee -a $LOG
echo "Done."
#!/bin/bash
set -e
echo -e "
# ====================== #
#    INSTALL VIM TMUX    #
# ====================== #
"
VIM=~/vim
VDOT=~/.vim
GIT_BASH=~/.bash-git-prompt
DIR_ARR=($VIM $VDOT $GIT_BASH)
SCRIPT_PATH=$(pwd -P)


echo -e "\n# ========== OS-RELEASE INSTALL ========== #"
if [ $(which yum) ]; then
    sudo yum install update -y
    sudo yum install -y vim git gcc gcc-c++ ctags cmake python3-devel golang ncurses-devel tmux
else
    sudo apt install update -y
    sudo apt install -y vim git gcc g++ ctags cmake python3-dev golang-go ncurses-dev tmux
fi


echo -e "\n# ========== GIT CLONE ========== #"
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


echo -e "\n# ========== VIM 8 ========== #"

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


echo -e "\n# ========== TMUX ========== #"

# ---------- .TMUX.CONF  ----------
if [[ $(tmux -V | sed 's/[^0-9]*//g') -ge "21" ]]
then
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


echo -e "\n# ========== GIT ========= #"

# ---------- .AWS/CONFIG ----------
mkdir -p ~/.aws
cat <<\EOF> ~/.aws/config
[default]
        region = eu-central-1
EOF

# ---------- .BASHRC  ----------
cat <<EOF>> ~/.bashrc
GIT_PROMPT_THEME=Solarized
GIT_PROMPT_ONLY_IN_REPO=1
source $GIT_BASH/gitprompt.sh
EOF

# ---------- .GITCONFIG  ----------
cat <<\EOF>> ~/.gitconfig
[credential]
        helper = !aws codecommit credential-helper $@
        UseHttpPath = true
        interactive = never
[pull]
        rebase = true
[alias]
        co = checkout
        br = branch
        cm = commit
        st = status
        sh = stash
        cof = checkout -f
        cob = checkout -b
        pushdev = push origin HEAD:refs/for/develop
        pushsys = push origin HEAD:refs/for/sys
        pullsys = pull origin sys
        pulldev = pull origin develop
EOF

# ---------- .GITIGNORE  ----------
cat <<\EOF> ~/.gitignore
*~
*.swp
*.swo
EOF

cat <<EOF>> ~/.gitconfig
[core]
        excludesfile = ~/.gitignore
EOF

# ---------- GIT CONFIG GLOBAL  ----------
git config --global core.excludesfile ~/.gitignore
git config --global user.name
git config --global user.email


# echo -e "\n# ========== ROOT ========== #"
# bash $SCRIPT_PATH/root_install.sh

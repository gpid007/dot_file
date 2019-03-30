#!/bin/bash

set -e

# ========== VIMRC ========== #

cat <<EOF | sudo tee /root/.vimrc
" ========== VIM NATIVE ==========

" --------- Interaction ----------
set encoding=utf-8
set mouse=a
set clipboard=unnamed
set pastetoggle=<F2>
set showcmd
set showmode
set wildmode=longest,list,full 
set timeoutlen=300
" set statusline+=%F

" ---------- Tab ---------- 
set nowrap
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4 expandtab
set backspace=indent,eol,start

" ---------- Color ----------
syntax on
set number
set ignorecase
set hlsearch
set ruler
set colorcolumn=80
highlight ColorColumn ctermbg=black guibg=black
highlight LineNr ctermfg=darkgray

" ---------- Alternate Escape ----------
imap ,, <C-c>
inoremap ,, <C-c>

" ---------- Alternate Arrows ----------
" <Up> k; <Down> j; <Left> h; <Right> l
noremap h k
noremap k j
noremap j h

" ---------- Alternate Yank Put ----------
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" ---------- Tab Commands ----------
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> :<C-c>:tabnew<CR>
nnoremap <C-x> :tabnext<CR>
inoremap <C-x> :<C-c>:tabnext<CR>
nnoremap <C-z> :tabprevious<CR>
inoremap <C-z> :<C-c>:tabprevious<CR>

" ---------- Complete Brackets ----------
" inoremap ( ()<left>
" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
EOF


# ========== TMUX ========== #

# ---------- .TMUX.CONF  ----------
if [[ $(tmux -V | sed 's/[^0-9]*//g') -ge "21" ]]; then
cat <<EOF | sudo tee /root/.tmux.conf
# ---------- MOUSE MODE ----------
set -g mouse on
# ---------- KEY REMAPPING ----------
bind m set -g mouse on \; display "Mouse ON"
bind M set -g mouse off \; display "Mouse OFF"
EOF
else
cat <<EOF | sudo tee /root/.tmux.conf
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
cat /root/dot_file/tmux.conf | sudo tee -a ~/.tmux.conf

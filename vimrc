" ========== INSTALL PLUGIN ==========

" --------- VUNDLE ---------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-surround'
Plugin 'w0rp/ale'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'majutsushi/tagbar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'lifepillar/vim-solarized8'
" Plugin 'terryma/vim-multiple-cursors'
call vundle#end()
filetype plugin indent on


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


" ========== PLUGIN ==========

" ---------- Colorscheme Solarized ----------
" let g:solarized_termcolors=256
let g:solarized_use16=1
set background=dark
colorscheme solarized8_high "_flat

" ---------- Lightline ----------
set laststatus=2
let g:lightline = {
    \ 'component_function': {
    \ 'filename': 'LightlineFilename',
    \ },
\ }
function! LightlineFilename()
    return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" ---------- Indent Guides ----------
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black

" ---------- Function Keys ----------
map <F7> :NERDTreeToggle<CR>
map <F8> :TagbarToggle<CR>
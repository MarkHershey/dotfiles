"""""""""""""""""""" Vundle Section """"""""""""""""""""""""""""""""""""""""""""

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
" https://github.com/VundleVim/Vundle.vim
Plugin 'VundleVim/Vundle.vim'

" ########## Vundle Plugin Section START ##########

" status line at the bottom of each vim window
" https://github.com/vim-airline/vim-airline
Plugin 'vim-airline/vim-airline'

" file tree explorer
" https://github.com/preservim/nerdtree
Plugin 'preservim/nerdtree'

" https://github.com/preservim/nerdcommenter
Plugin 'preservim/nerdcommenter'

" https://github.com/ycm-core/YouCompleteMe
Plugin 'ycm-core/YouCompleteMe'

" https://github.com/python-mode/python-mode
Plugin 'python-mode/python-mode'


" ########## Vundle Plugin Section END ##########

call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""" General """""""""""""""""""""""""""""""""""""""""""""""""""

" Disable startup message
set shortmess+=I

" Set text encoding 
set encoding=utf-8

" Show line numbers
set nu

" Show relative line numbers
set rnu

" Sets how many lines of history VIM has to remember
set history=1000

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Incremental search (as string is being typed)
set incsearch

" Highlight search
set hls


"""""""""""""""""""" Key Mapping """""""""""""""""""""""""""""""""""""""""""""""

" map ctrl n to toggle nerd tree
map <C-n> :NERDTreeToggle<CR>

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Switch vim tab with ctrl left/right arrow
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

"""""""""""""""""""" Shortcuts """""""""""""""""""""""""""""""""""""""""""""""""

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

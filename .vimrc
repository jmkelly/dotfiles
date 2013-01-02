call pathogen#infect()
syntax on
filetype plugin indent on
inoremap kj <Esc>
"don't automatically switch to insert mode when conque is opened
set nocompatible
"allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set number
"set tabstop=2
"set shiftwidth=4
"set softtabstop=4
set autoindent
set laststatus=2
set showmatch
set incsearch
"set hlsearch
let tabsize = 2
execute "set tabstop=".tabsize
execute "set shiftwidth=".tabsize
execute "set softtabstop=".tabsize


" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
"set cursorline
set cmdheight=2
set switchbuf=useopen
set numberwidth=5
set showtabline=2
set winwidth=79
set shell=bash
"Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
"set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set t_Co=256 " 256 colors
:set background=dark
:color grb256

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" Rspec specific setting for running tests"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
function! RSpecFile()
    :execute "ConqueTermSplit rspec " . expand("%")  
endfunction

map <leader>R :call RSpecFile() <ESC>


command! RSpecFile call RSpecFile()

function! RSpecCurrent()
    :execute "ConqueTermSplit rspec " . expand("%") . ":" .line(".") 
endfunction

map <leader>r :call RSpecCurrent() <ESC>
command! RSpecCurrent call RSpecCurrent()
 

" General

set nocompatible
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set laststatus=2                "Always display the status line
set hidden                      "Hide buffer instead of closing it
set pastetoggle=<F2>            "Paste without being smart

" Key mappings

let mapleader=","
nnoremap ; :                        " Use ; over : for commands
nnoremap <leader><space> :noh<cr>   " Clear search highlighting with ,<space>
nnoremap <tab> :bnext<cr>           " Tab to next buffer
nnoremap <s-tab> :bprevious<cr>     " Shift-tab to previous buffer
nnoremap <leader><leader> <C-^>     " Switch between last two buffers

" Swap file and backups
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
    set undofile
endif

" Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Enable loading the plugin/indent files for specific file types

filetype plugin indent on

" Wrapping

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" Search

set hlsearch
set incsearch
set ignorecase
set showmatch
set smartcase

" Colors

syntax enable
set background=light
let g:solarized_termcolors=256
colorscheme solarized

" Scrolling

set scrolloff=4
set sidescrolloff=15
set sidescroll=1

" Completion

set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildmode=list:longest
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.svg
set wildignore+=*.swp,*.pyc,*.bak,*.class,*.orig
set wildignore+=.git,.hg,.bzr,.svn

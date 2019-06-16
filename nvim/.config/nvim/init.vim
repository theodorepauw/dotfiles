call plug#begin('~/.local/share/nvim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'dylanaraps/wal.vim'
Plug 'lilydjwg/colorizer'
"Plug '~/.fzf'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install' }
"Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'rust-lang/rust.vim'

call plug#end()

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >

let g:palenight_terminal_italics = 1

set ignorecase
set smartcase
set number relativenumber

let g:onedark_termcolors=256
let g:onedark_terminal_italics=1

let g:lightline = {
      \ 'colorscheme': 'wal',
      \ }
set noshowmode

syntax enable

set background=dark

set autoindent

" No swapfiles
set noswapfile

" Show search results as you type
set incsearch

" Change window title to filename
set title
set titlestring=%t
" #2f2 DICTIONARY #2f2
"

"if has('unix')
"	set dictionary+=/usr/share/dict/words
"else
"	set dictionary+=~/AppData/Local/nvim/words
"endif

"set complete+=k

if has('vim_starting')
	set nocompatible               " Be iMproved
endif

nnoremap <F9> :!%:p<Enter>

"Paste
noremap <M-v> "+p
noremap <M-S-v> "*p

"Copy
vnoremap <M-c> "+y
vnoremap <M-S-c> "*y

"Toggling relativenumber
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter 	 * set norelativenumber
augroup end

colorscheme wal

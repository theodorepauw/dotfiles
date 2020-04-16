map <Space> <Leader>
if has('vim_starting')
	set nocompatible               " Be iMproved
endif

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load Plugins with junegunn's Vim-Plug
call plug#begin('~/.local/share/nvim/plugged')

" GUI enhancments
Plug 'itchyny/lightline.vim'
Plug 'dylanaraps/wal.vim'
Plug 'lilydjwg/colorizer'
Plug 'andymass/vim-matchup'
""
""" Fuzzy Finder + Integration
""Plug '~/.fzf'
""Plug 'junegunn/fzf.vim'
""
" VIM improvements
Plug 'tpope/vim-commentary'
""
call plug#end()

if has('nvim')
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
  set inccommand=nosplit
  noremap <C-q> :confirm qall<CR>
end

" deal with colors
if !has('gui_running')
	set t_Co=256
endif

" Colors
set background=dark
hi Normal ctermbg=NONE
syntax on
let g:lightline = { 'colorscheme': 'wal' }
colorscheme wal

if executable('rg')
	set grepprg=rg\ --vimgrep
endif

" =============================================================================
" # Editor settings
" =============================================================================
filetype plugin indent on
set autoindent 
set smartindent
set timeoutlen=300 " https://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8 " only display files as utf-8
set fileencoding=utf-8 " re-encode file as utf-8 if not already the case
set scrolloff=3
set noshowmode
set hidden
set nowrap
set nojoinspaces
set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter
" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" No swapfiles
set noswapfile

" Sane splits
set splitbelow
set splitright

" Save undo history so that you can undo even when file saved & closed
set undodir=~/.vimdid
set undofile

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Use wide tabs
set shiftwidth=8
set softtabstop=8
set tabstop=8
set noexpandtab

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines<Paste>

" Better search
set incsearch
set ignorecase
set smartcase
set hlsearch

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very  by default
"nnoremap ? ?\v
"nnoremap / /\v
"cnoremap %s/ %sm/

" =============================================================================
" # GUI settings
" =============================================================================
set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set backspace=2 " Backspace over newlines
set nofoldenable
set ruler " Where am I?
set ttyfast
set regexpengine=1
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
"set lazyredraw
set synmaxcol=300
set laststatus=2
set relativenumber " Relative line numbers
"Toggling relativenumber
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter 	 * set norelativenumber
augroup end
set number " Also show current absolute line
"set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals
set shortmess+=c " don't give |ins-completion-menu| messages.

" Change window title to filename
set title
set titlestring=%t

" backspace over anything but EOL
"set backspace=indent,start

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set nolist
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
" ; as : -> don't need to hold in shift
nnoremap ; :

" autoindent
map <tab> =

" Ctrl+c and Ctrl+j as Esc
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

" Suspend with Ctrl+f
inoremap <C-f> :sus<cr>
vnoremap <C-f> :sus<cr>
nnoremap <C-f> :sus<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" COPY & PASTE W/ X Clipboard Integration

"Copy
vnoremap <M-c> "+y
vnoremap <M-S-c> "*y

"Paste
noremap <M-v> "+p
noremap <M-S-v> "*p

" <leader>s for Rg search
noremap <leader>s :Rg
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" Open hotkeys
map <C-p> :Files<CR>

" Quick-save
nmap <leader>w :w<CR>

" Quit
nmap <leader>q :q<CR>

" Quick-save & Quit
nmap <leader>wq :wq<CR>

" Quick-save & Quit
nmap <leader>x :x<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" I can type :help on my own, thanks.
map <F1> <Esc>
imap <F1> <Esc>

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],

" trying out a work-around for better parentheses
inoremap " ""<left>
inoremap ' ''<left>
"inoremap ( ()<left>
inoremap [ []<left>
" inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O


" =============================================================================
" # Autocommands
" =============================================================================

" Prevent accidental writes to buffers that shouldn't be edited
autocmd BufRead *.orig set readonly
autocmd BufRead *.pacnew set readonly

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Auto-make less files on save
autocmd BufWritePost *.less if filereadable("Makefile") | make | endif

" Follow Rust code style rules
au Filetype rust source ~/.config/nvim/scripts/spacetab.vim
au Filetype rust set colorcolumn=100

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

"python run current file
autocmd BufWinEnter *.py nnoremap <F4> :w !python %<CR>
"bash run current file
autocmd BufWinEnter *.sh nnoremap <F4> :w !. %<CR>

" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c
autocmd BufRead *.xlsx.axlsx set filetype=ruby

" Script plugins
autocmd Filetype html,xml,xsl,php source ~/.config/nvim/scripts/closetag.vim

" nvim
if has('nvim')
	runtime! plugin/python_setup.vim
endif

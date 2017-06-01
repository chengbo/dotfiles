set nocompatible
filetype off

set clipboard=unnamed

" Plugins {{{
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'joshdick/onedark.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'mileszs/ack.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'octref/RootIgnore'
Plugin 'tpope/vim-surround'
Plugin 'easymotion/vim-easymotion'
Plugin 'airblade/vim-gitgutter'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'terryma/vim-expand-region'
Plugin 'ap/vim-buftabline'
call vundle#end()
filetype plugin indent on
" }}}

filetype plugin on

set omnifunc=syntaxcomplete#Complete

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable per-project configuration file
set exrc

set hlsearch
set incsearch

syntax on
let python_highlight_all=1
" let g:syntastic_check_on_open = 2 " Slow on opening file
set laststatus=2

let mapleader=","

" Theme {{{
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:airline_theme='onedark'
colorscheme onedark

" Custom BufTabLine Color
hi! link BufTabLineCurrent String
hi! link BufTabLineActive Comment
hi! link BufTabLineHidden Comment
hi! link BufTabLineFill Comment
" }}}

set encoding=utf8

set number
set cursorline
set colorcolumn=80

set nobackup
set noswapfile

set lazyredraw

" Use spaces instead of tabs
set expandtab

set smarttab

set shiftwidth=4
set tabstop=4

set ai " Auto indent
set si " Smart indent

set backspace=indent,eol,start

set foldmethod=indent

filetype indent on " Load filetype-specific indent files

set wildmenu " Visual autocomplete for command menu

set showmatch " Highlight matching [{()}]

" Switch buffer by numbers
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <leader><space> :nohlsearch<CR>
nnoremap <space> za " Space open/closes folds
nnoremap <D-S> :w<CR>

nnoremap <leader>s :mksession<CR>

noremap <C-K><C-B> :NERDTreeToggle<CR>
nmap <C-_> <leader>c<space>
vmap <C-_> <leader>c<space>

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

inoremap <C-A> <Esc>I
inoremap <C-E> <Esc>A
inoremap <C-B> <Esc>i
inoremap <C-F> <Esc>la

noremap <F3> :Autoformat<CR>

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif


let NERDTreeIgnore = ['\.pyc$', '^\.git$', '^\.DS_Store$', '^__pycache__$']
let NERDTreeRespectWildIgnore = 1
let NERDTreeShowHidden = 1
let g:RootIgnoreAgignore = 1

let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
            \ }
if executable('ag')
    let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
else
    let s:ctrlp_fallback = 'find %s -type f'
endif
let g:ctrlp_user_command = {
            \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': s:ctrlp_fallback
            \ }
" let g:ctrlp_match_window = 'top,order:ttb'

let g:neocomplete#enable_at_startup = 1

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

" Folding {{{
set foldenable " Enable folding
set foldlevelstart=10 " Open most folds by default
set foldnestmax=10 " 10 nested fold max
" }}}


set autoread
set secure

set modelines=1
" vim:foldmethod=marker:foldlevel=0

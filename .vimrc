set nocompatible
filetype off

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
Plugin 'tpope/vim-surround'
Plugin 'easymotion/vim-easymotion'
Plugin 'airblade/vim-gitgutter'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'terryma/vim-multiple-cursors'
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

colorscheme onedark

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

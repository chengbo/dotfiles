" vim:foldmethod=marker:foldlevel=0

"   ██████╗██╗  ██╗███████╗███╗   ██╗ ██████╗ ██████╗  ██████╗
"  ██╔════╝██║  ██║██╔════╝████╗  ██║██╔════╝ ██╔══██╗██╔═══██╗
"  ██║     ███████║█████╗  ██╔██╗ ██║██║  ███╗██████╔╝██║   ██║
"  ██║     ██╔══██║██╔══╝  ██║╚██╗██║██║   ██║██╔══██╗██║   ██║
"  ╚██████╗██║  ██║███████╗██║ ╚████║╚██████╔╝██████╔╝╚██████╔╝
"   ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝  ╚═════╝

" General {{{

set nocompatible
set autoread

set nobackup
set noswapfile

set clipboard=unnamed

" Eliminate delays on terminal VIM
set timeout timeoutlen=1000 ttimeoutlen=10

" }}}

" Plugin List {{{
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'arcticicestudio/nord-vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'w0rp/ale'
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
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'terryma/vim-expand-region'
Plugin 'ap/vim-buftabline'
Plugin 'davidhalter/jedi-vim'
Plugin 'vim-python/python-syntax'
Plugin 'vim-scripts/sessionman.vim'
Plugin 'luochen1990/rainbow'
Plugin 'mhinz/vim-startify'
Plugin 'kshenoy/vim-signature'
Plugin 'Yggdroot/indentLine'
call vundle#end()
filetype plugin indent on
" }}}

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
let g:airline_theme='nord'
let g:airline_powerline_fonts = 1
colorscheme nord

" }}}

" Formatting {{{

set encoding=utf8
set nowrap                       " Do not wrap long lines

set shiftwidth=4
set tabstop=4
set smarttab
set expandtab                    " Use spaces instead of tabs
set ai                           " Auto indent
set si                           " Smart indent

set foldenable                   " Enable folding
set foldlevelstart=10            " Open most folds by default
set foldnestmax=10               " 10 nested fold max

" }}}

" GUI {{{

set background=dark

set guifont=Monaco\ for\ Powerline:h16
set guioptions= " Remove menu bar/ toolbar / scrollbars on macvim

set splitright                   " Put new vsplit windows to the right
set splitbelow                   " Put new split windows to the bottom
set so=5                         " Set 5 lines to the cursor - when moving vertically using j/k
set backspace=indent,eol,start
set foldmethod=indent
set showmatch                    " Highlight matching [{()}]
set number
set cursorline
set colorcolumn=80

set wildmenu                     " Visual autocomplete for command menu
set lazyredraw

set hlsearch
set incsearch

syntax on
let python_highlight_all=1
set laststatus=2

" Do not popup python docstring window during completion
autocmd FileType python setlocal completeopt-=preview

" }}}

" Key mappings {{{

let mapleader = ","
let maplocalleader = "_"

" Move cursor by display lines when wrapping
noremap j gj
noremap k gk
noremap 0 g0
noremap $ g$

" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

noremap <F3> :Autoformat<CR>

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Maximize window and return to previous split structure
nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>

function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

" Delete current buffer without losing the split window
nnoremap <leader>q :bp\|bd #<CR>

nnoremap <leader><space> :nohlsearch<CR>
nnoremap <space> za " Space open/closes folds
nnoremap <D-S> :w<CR>

nmap <C-_> <leader>c<space>
vmap <C-_> <leader>c<space>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

inoremap <C-A> <C-O>^
inoremap <C-E> <C-O>$
inoremap <C-B> <Left>
inoremap <C-F> <Right>
inoremap <C-N> <Down>
inoremap <C-P> <Up>
inoremap <C-D> <Del>
inoremap <C-K> <C-O>D
inoremap <D-Enter> <C-O>o
inoremap <D-S-Enter> <C-O>O
inoremap <D-]> <C-T> " indent
inoremap <D-[> <C-D> " unindent

" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" }}}

" Plugin Settings {{{

" Sessions {{{

set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
nmap <leader>sl :SessionList<CR>
nmap <leader>ss :SessionSave<CR>
nmap <leader>sc :SessionClose<CR>

" }}}

" Asynchronous Lint Engine {{{

let g:ale_sign_error = '•'
let g:ale_sign_warning = '○'
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'

hi Error   guifg=#ff0000 guibg=NONE
hi Warning guifg=#dc752f guibg=NONE
hi link ALEErrorSign   Error
hi link ALEWarningSign Warning

" }}}

" BufTabLine {{{

" Show ordinal number in tabline
let g:buftabline_numbers = 2

" Only show tabline only if there are at least two buffers
let g:buftabline_show = 1

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

nmap <D-1> <Plug>BufTabLine.Go(1)
nmap <D-2> <Plug>BufTabLine.Go(2)
nmap <D-3> <Plug>BufTabLine.Go(3)
nmap <D-4> <Plug>BufTabLine.Go(4)
nmap <D-5> <Plug>BufTabLine.Go(5)
nmap <D-6> <Plug>BufTabLine.Go(6)
nmap <D-7> <Plug>BufTabLine.Go(7)
nmap <D-8> <Plug>BufTabLine.Go(8)
nmap <D-9> <Plug>BufTabLine.Go(9)
nmap <D-0> <Plug>BufTabLine.Go(10)

" Custom BufTabLine Color
hi! link BufTabLineCurrent String
hi! link BufTabLineActive Comment
hi! link BufTabLineHidden Comment
hi! link BufTabLineFill Comment

" }}}

" Ack {{{

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" }}}

" Polyglot {{{

" Disable Python syntax from polyglot, use python-syntax instead
let g:polyglot_disabled = ['python']

" }}}

" NERD Tree {{{

let NERDTreeIgnore = ['\.pyc$', '^\.git$', '^\.DS_Store$', '^__pycache__$', 'venv']
let NERDTreeRespectWildIgnore = 1
let NERDTreeShowHidden = 1

noremap <C-K><C-B> :NERDTreeToggle<CR>

" }}}

let g:RootIgnoreAgignore = 1

" CtrlP {{{

nnoremap <silent> <D-t> :CtrlP<CR>
nnoremap <silent> <D-r> :CtrlPMRU<CR>

let g:ctrlp_prompt_mappings = {
            \ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
            \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
            \ 'PrtHistory(-1)':       ['<c-j>'],
            \ 'PrtHistory(1)':        ['<c-k>'],
            \ }

let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](venv|node_modules)|(\.(git|hg|svn))$',
            \ 'file': '\v\.(exe|so|dll|pyc)$',
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

" }}}

" Rainbow {{{

let g:rainbow_active = 1

" }}}

" NeoComplete {{{

let g:neocomplete#enable_at_startup = 1

set omnifunc=syntaxcomplete#Complete

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

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

" }}}

" Startify {{{

let g:startify_custom_header =
  \ [ '           ___            __           __   __        __'
  \ , '     |__| |__  |    |    /  \    |  | /  \ |__) |    |  \'
  \ , '     |  | |___ |___ |___ \__/    |/\| \__/ |  \ |___ |__/'
  \ ]
" }}}

" indentLine {{{

let g:indentLine_char = '⎸'

" }}}

" }}}

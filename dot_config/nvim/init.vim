"=======================================================
"======================= VimPlug =======================
"=======================================================

if has('vim_starting')
	set nocompatible               " Be iMproved
endif


let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = "c,go,html,javascript,python"
let g:vim_bootstrap_editor = "nvim"       " nvim or vim

if !filereadable(vimplug_exists)
	if !executable("curl")
		echoerr "You have to install curl or first install vim-plug yourself!"
		execute "q!"
	endif
	echo "Installing Vim-Plug..."
	echo ""
	silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	let g:not_finish_vimplug = "yes"

	autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'terryma/vim-expand-region'
Plug 'udalov/kotlin-vim'
Plug 'christoomey/vim-tmux-navigator'

if has('nvim-0.5')
	Plug 'neovim/nvim-lspconfig'
endif

if isdirectory('/usr/local/opt/fzf')
	Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
	Plug 'junegunn/fzf.vim'
endif

Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
let g:go_bin_path= $HOME . "/go/bin"

Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Raimondi/delimitMate'
Plug 'machakann/vim-highlightedyank'
Plug 'Yggdroot/indentLine'
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = 'hard'

" Include user's extra bundle
if filereadable(expand("~/.config/nvim/local_bundles.vim"))
	source ~/.config/nvim/local_bundles.vim
endif

call plug#end()

" Required:
filetype plugin indent on


"=======================================================
"======================= General =======================
"=======================================================

let mapleader=','
let maplocalleader = "\\"


set relativenumber number " Line numbers
syntax on

set cmdheight=2 " Better display for messages
set updatetime=500 " Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c
set signcolumn=yes  " always show signcolumns

set autoread
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set autoindent                  " Sets autoindent
set colorcolumn=80      " Turn on the colored column at column 80
set cursorline
set nowrap              " Turn off line wraps
set showcmd             " Show commands in the bottom right corner
set spelllang=en_us
" set t_ut=
set textwidth=80

set mat=1               " How many seconds to blink on a matched paren
set backspace=indent,eol,start " Backspace for insert mode
set ruler

set inccommand=split " Interactive substitute

set shell=/bin/sh

"set list
set listchars=tab:▸\ ,eol:¬

set noshowmode   " Gets rid of the original showing of modes in vim
set laststatus=2 " Shows the status bar even if there is only one file

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary

set fileformats=unix,dos,mac

" Enable hidden buffers
set hidden

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

" Copy/Paste/Cut
if has('unnamedplus')
	set clipboard=unnamed,unnamedplus
endif

" Directories for swp files
set nobackup
set noswapfile
set nowritebackup

" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

" Status bar
set laststatus=2

" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

if (has("termguicolors"))
	set termguicolors
endif

augroup vimrc-remember-cursor-position
	autocmd!
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" Auto apply dotfile changes
autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path "%"

colorscheme gruvbox


"=======================================================
"====================== Mappings =======================
"=======================================================

noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Map colon to semicolon and the reverse
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

" Switching windows
"noremap <C-j> <C-w>j
"noremap <C-k> <C-w>k
"noremap <C-l> <C-w>l
"noremap <C-h> <C-w>h

" Create Splits
noremap <leader>h :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)


if has('nvim')
	" Use escape to enter normal mode in a terminal buffer
	tnoremap <Esc> <C-\><C-n>
	tnoremap <M-[> <Esc>
	tnoremap <C-v><Esc> <Esc>
endif


"=======================================================
"==================== Abbreviations ====================
"=======================================================

iabbrev teh the
iabbrev Teh The
iabbrev THe The

iabbrev Im I'm
iabbrev im I'm

iabbrev yuo you
iabbrev Yuo You

iabbrev taht that
iabbrev Taht That

iabbrev waht what
iabbrev Waht What

iabbrev tehn then
iabbrev Tehn Then

cnoreabbr evim e $MYVIMRC
cnoreabbr bad colorscheme badwolf


"=================================================
"==================== Plugins ====================
"=================================================

" Airline
let g:airline_theme = 'badwolf'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
	let g:airline#extensions#tabline#left_sep = ' '
	let g:airline#extensions#tabline#left_alt_sep = '|'
	" let g:airline_left_sep          = '▶'
	let g:airline_left_alt_sep      = '»'
	" let g:airline_right_sep         = '◀'
	let g:airline_right_alt_sep     = '«'
	let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
	let g:airline#extensions#readonly#symbol   = '⊘'
	let g:airline#extensions#linecolumn#prefix = '¶'
	let g:airline#extensions#paste#symbol      = 'ρ'
	let g:airline_symbols.linenr    = '␊'
	let g:airline_symbols.branch    = '⎇'
	let g:airline_symbols.paste     = 'ρ'
	let g:airline_symbols.paste     = 'Þ'
	let g:airline_symbols.paste     = '∥'
	let g:airline_symbols.whitespace = 'Ξ'
else
	let g:airline#extensions#tabline#left_sep = ''
	let g:airline#extensions#tabline#left_alt_sep = ''

	" powerline symbols
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_symbols.branch = ''
	let g:airline_symbols.readonly = ''
	let g:airline_symbols.linenr = ''
endif

" Fzf
set wildmode=list:longest,list:full
let $FZF_DEFAULT_COMMAND =  "fd ."
nnoremap <silent> <leader>a :Rg<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :call fzf#vim#gitfiles('', fzf#vim#with_preview('right'))<CR>
nnoremap <silent> <leader>m :History -m<CR>
nnoremap <silent> <leader>c :Commands<CR>
nnoremap <silent> <leader>q :BLines<CR>
nnoremap <silent> <leader>w :Windows<CR>

" Autoclean fugitive buffers
autocmd! BufReadPost fugitive://* set bufhidden=delete

" Vim Go
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:echodoc#highlight_trailing = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_types = 1
let g:go_def_mapping_enabled = 0
let g:go_metalinter_disabled = []

" MISC
let g:highlightedyank_highlight_duration = 200
let g:airline#extensions#virtualenv#enabled = 1
" Default highlight is better than polyglot
let g:polyglot_disabled = ['python', 'go']
let g:python_highlight_all = 1

let g:python3_host_prog = '/Users/brian/.pyenv/versions/neovim3/bin/python'

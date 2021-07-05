" Vim Plug {{{
" ====================
" Init {{{
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
" }}}

" NERDTree {{{
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
" "}}}

" Tpope {{{
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
" }}}

" Shougo {{{
Plug 'Shougo/denite.nvim'
" }}}

Plug 'kristijanhusak/vim-carbon-now-sh'

" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'udalov/kotlin-vim'
Plug 'christoomey/vim-tmux-navigator'

if has('nvim-0.5')
	Plug 'neovim/nvim-lspconfig'
endif

let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-emmet',
      \ 'coc-emoji',
      \ 'coc-eslint',
      \ 'coc-git',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-python',
      \ 'coc-snippets',
      \ 'coc-tslint',
      \ 'coc-tslint-plugin',
      \ 'coc-tsserver',
      \ 'coc-ultisnips',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ ]

" Junegunn {{{
Plug 'junegunn/goyo.vim'
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
" }}}

" Go Lang Bundle {{{
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
let g:go_bin_path= $HOME . "/go/bin"
" }}}

" Python Bundle {{{
" Plug 'davidhalter/jedi-vim'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
" }}}

" Other {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/CSApprox'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Raimondi/delimitMate'
Plug 'machakann/vim-highlightedyank'
Plug 'Yggdroot/indentLine'
let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif
Plug 'Shougo/vimproc.vim', {'do': g:make}

if v:version >= 703
  Plug 'Shougo/vimshell.vim'
endif

if v:version >= 704
  " Snippets
  Plug 'SirVer/ultisnips'
endif

Plug 'honza/vim-snippets'

" Color
Plug 'tomasr/molokai'
Plug 'flazz/vim-colorschemes'
" Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = 'hard'

" c
"Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
" }}}


" Include user's extra bundle
if filereadable(expand("~/.config/nvim/local_bundles.vim"))
  source ~/.config/nvim/local_bundles.vim
endif

call plug#end()

" Required:
filetype plugin indent on
" }}}

" General {{{
" ====================
" CursorShape Block
" let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
let mapleader=','
let maplocalleader = "\\"

" To allow \":Man cmd"
runtime! ftplugin/man.vim

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

set foldlevelstart=10   " most folds should be open on start
set foldmethod=indent

set lazyredraw          " Don't redraw the screen during a macro
set mat=1               " How many seconds to blink on a matched paren
set backspace=indent,eol,start " Backspace for insert mode
set ruler

set inccommand=split " Interactive substitute

" set shell=bash\ --login " make the sh command source the bash_profile
set backupcopy=yes      " For webpack hot reloading
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

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

" }}}

" Mappings {{{
" ====================
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

nnoremap <space> zt

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

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <leader>te :tabe %<CR>
nnoremap <leader>tc :tabc<CR>

" See the full file path
" nnoremap <leader>p :echo expand("%:p")<cr>

" Open and close the quickfix list
nnoremap <leader>co :copen<cr>
nnoremap <leader>cc :cclose<cr>
"
" Open and close the location list
nnoremap <leader>lc :lclose<cr>
nnoremap <leader>lo :lopen<cr>

" Change CWD for the window to the dir of the current file
nnoremap <leader>cd :lcd %:p:h<cr>:pwd<cr>

" Eval till = char
nnoremap <leader>= vt="zyf=a <C-r>=<C-r>z<cr><esc>

" Run the current line as a command and read in the output
" nnoremap <leader>q !!sh<cr>

nnoremap <leader>ue :UltiSnipsEdit<cr>

" Edit Bash Profile
nnoremap <leader>eb :call EditDot("shell/bash_profile.sh")<cr>

" Edit vimrc
nnoremap <leader>ev :call EditDot("nvim/init.vim")<cr>

" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Edit tmux config
nnoremap <leader>et :call EditDot("tmux/tmux.conf")<cr>

" Launch Terminal
nnoremap <silent> <leader>sh :terminal<CR>

if has('nvim')
  " Use escape to enter normal mode in a terminal buffer
  tnoremap <Esc> <C-\><C-n>
  tnoremap <M-[> <Esc>
  tnoremap <C-v><Esc> <Esc>
endif

vnoremap <leader>s :sort<cr>

" }}}

" Autocommands {{{
" ====================
" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
" augroup vimrc-sync-fromstart
"   autocmd!
"   autocmd BufEnter * :syntax sync maxlines=200
" augroup END

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

augroup text
  autocmd!
  autocmd FileType text,unix :setlocal wrap spell foldmethod=indent
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

augroup yaml
  autocmd!
  autocmd FileType yaml :call ShortTab()
augroup END

augroup cpp
  autocmd!
  autocmd FileType cpp :call LongTab()
augroup END


let g:markdown_syntax_conceal = 0
augroup markdown
  autocmd!
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  autocmd FileType markdown, :setlocal wrap spell foldmethod=indent
  autocmd FileType markdown, :colorscheme badwolf
augroup END

augroup python
  autocmd!
  autocmd FileType python :setlocal list foldmethod=indent
  autocmd FileType python :setlocal commentstring=#\ %s
  autocmd FileType python :call PyTab()
augroup END

augroup javascript
  autocmd!
  autocmd FileType javascript :call ShortTab()
  autocmd FileType javascript setlocal foldmethod=syntax
augroup END

augroup bash
  autocmd!
  autocmd FileType sh :setlocal commentstring=#\ %s
  autocmd FileType sh :nnoremap <buffer> <leader>t :!%<cr>
augroup END

augroup html
  autocmd!
  autocmd FileType html :setlocal nowrap
  autocmd Filetype html setlocal ts=2 sw=2 expandtab
augroup END

augroup C
  autocmd!
  autocmd FileType c :setlocal list foldmethod=syntax
augroup END

augroup vim
  autocmd!
  autocmd FileType vim :setlocal foldmethod=marker
  autocmd FileType vim :setlocal foldlevelstart=0
augroup END
" }}}

" Color Scheme {{{
" ====================
" hi clear
" colorscheme monokai-phoenix
" colorscheme badwolf
" colorscheme onedark
colorscheme gruvbox
" colorscheme papercolor
" colorscheme brogrammer
" colorscheme turtles
" colorscheme molokai_dark
" }}}

" Abbreviations {{{
" ====================
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

iabbrev xdatef <c-r>=strftime("%m/%d/%y %H:%M:%S")<cr><cr><c-r>a
iabbrev xdate <c-r>=strftime("%H:%M:%S")<cr><cr><c-r>a

iabbrev xbash #!/bin/bash
iabbrev xpython #!/usr/bin/python

" Turn sleep on and off (OSX)
cnoreabbr caf !caffeinate -d&
cnoreabbr kcaf !killall caffeinate

cnoreabbr evim e $MYVIMRC
cnoreabbr bad colorscheme badwolf

" Quotes
cnoreabbr double %s/'/"/g
cnoreabbr single %s/"/'/g

" Env to JSON
cnoreabbr etj s/\(\w*\)=\(.*$\)/"\1": "\2",/
" JSON to Env
cnoreabbr jte s/"\(\w*\)": "\(.*\)"/export \1="\2"/

"JSON to graphql
cnoreabbr jtg s/:.*[ {}]\@<!//

cnoreabbr evim e $MYVIMRC
" }}}

" Functions {{{
" ===================
function! ShortTab()
  let &l:tabstop = 2
  let &l:shiftwidth = 2
  let &l:softtabstop = 2
  let &l:expandtab = 1
  exe "retab"
endfunction

function! LongTab()
  let &l:tabstop = 4
  let &l:shiftwidth = 4
  let &l:softtabstop = 4
  let &l:expandtab = 1
  exe "retab"
endfunction

function! PyTab()
  let &l:tabstop = 4
  let &l:shiftwidth = 4
  let &l:softtabstop = 4
  let &l:expandtab = 0
  exe "retab"
endfunction

function! TabCd(dir)
  if !isdirectory(a:dir)
    echoerr a:dir . " is not a directory"
    return
  endif

  execute "tabe " . a:dir
  execute "lcd " . a:dir
endfunction


command! -nargs=1 -complete=dir Tabcd call TabCd(<f-args>)

" remap tabcd to Tabcd
cnoreabbr tabcd Tabcd

function! ScratchFn(fileExt)
  let curdate=system('date +%s')[:-2]
  let buffName="scratch-" . curdate . "." . a:fileExt
  execute "new " . l:buffName

  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
endfunction

" remap scratch to Scratch
cnoreabbr scratch Scratch

command! -nargs=1 Scratch call ScratchFn(<f-args>)

if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

function! EditDot(file)
  let path = $HOME . '/dotfiles/' . a:file
  execute "tabe " . fnameescape(l:path)
  execute "Glcd"
endfunction

" }}}

" Plugins {{{
" ===================

" Airline {{{
" ======================

" badwolf
" dark
" durant
" luna
" murmur
" sky
" wombat
" powerlineish

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
" }}}

" Bufferline {{{
" ======================
let g:bufferline_echo = 0
" }}}

" Coc.nvim {{{
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup mygroup
  autocmd!
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `lp` and `ln` for navigate diagnostics
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

vmap <localleader>p  <Plug>(coc-format-selected)
nmap <localleader>p  <Plug>(coc-format-selected)


" Remap for rename current word
nmap <localleader>R <Plug>(coc-rename)

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
         \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-l>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-j>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" }}}
let g:coc_disable_startup_warning = 1

" Fzf {{{
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"


let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" The Silver Searcher
if executable('ag')
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore node_modules -g ""'
set grepprg=ag\ --nogroup\ --nocolor
endif

nnoremap <silent> <leader>a :Rg<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :call fzf#vim#gitfiles('', fzf#vim#with_preview('right'))<CR>
nnoremap <silent> <leader>y :call fzf#vim#gitfiles('?', fzf#vim#with_preview('right'))<CR>
nnoremap <silent> <leader>m :History -m<CR>
nnoremap <silent> <leader>c :Commands<CR>
nnoremap <silent> <leader>q :BLines<CR>
nnoremap <silent> <leader>w :Windows<CR>
" }}}

" Fugitive {{{
" ======================
" Autoclean fugitive buffers
autocmd! BufReadPost fugitive://* set bufhidden=delete

" Mappings
noremap <leader>ga  :Gwrite<CR>
noremap <leader>gb  :Gblame<CR>
noremap <leader>gc  :Gcommit<CR>
noremap <leader>gd  :Gvdiff<CR>
noremap <leader>gh  :!gh-launch<CR>
noremap <leader>glc :Glcd<CR>
noremap <leader>gll :Gpull<CR>
noremap <leader>gr  :Gremove<CR>
noremap <leader>gs  :Gstatus<CR>
noremap <leader>gu  :Gpush -u<CR>
" Open current line on github
nnoremap <leader>go :.Gbrowse<CR>

cnoreabbr Gco Git co
cnoreabbr Gbranch Git branch
cnoreabbr Gca Gcommit --amend --no-edit
cnoreabbr Gcb Git co -b
cnoreabbr Gstash Git stash
cnoreabbr Gapply Git stash apply

cnoreabbr cheat tabe ~/dotfiles/cheatsheets/

" let g:github_enterprise_urls = ['https://github.ibm.com']
" " }}}

" Goyo {{{
function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" }}}

" NERDTree {{{
" ======================
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <leader>P :NERDTreeFind<CR>

" setlet g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
" }}}

" UltiSnips {{{
" ======================
" set rtp^=$HOME
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-j>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="/Users/sidneywijngaarde/.config/nvim/UltiSnips/"
" }}}

" Vim Go {{{
" ===================
" run :GoBuild or :GoTestCompile based on the go file
" let g:go_def_mode = 'gopls'
let g:go_list_type = "quickfix"
" let g:go_fmt_fail_silently = 1

let g:go_auto_type_info = 0
" Uncomment to highlight variable references
" let g:go_auto_sameids = 1
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:echodoc#highlight_trailing = 1
" let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_types = 1

" let g:go_fmt_experimental = 1
let g:go_def_mapping_enabled = 0
let g:go_metalinter_disabled = []
" let g:go_metalinter_autosave = 1
" let g:go_metalinter_autosave_enabled = ['vet', 'golint']
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.kt setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

augroup completion_preview_close
  autocmd!
  if v:version > 703 || v:version == 703 && has('patch598')
    autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
  endif
augroup END

augroup go
  au!
  au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

  au Filetype go nmap <localleader>ae <Plug>(go-alternate-edit)
  au Filetype go nmap <localleader>ah <Plug>(go-alternate-split)
  au Filetype go nmap <localleader>a  <Plug>(go-alternate-vertical)

  " gd = :GoDef
  " <C-t> :GoDefPop
  " K :GoDoc press enter to quit
  " :GoDescribe shows all information about a type
  " :GoChannelPeers shows all sends and recvs from a channel
  " :GoCallers :Gocallees show where functions are used
  " :GoWhichErrs shows what type an error might be
  au Filetype go nnoremap <localleader>p :GoImport<space>

  au FileType go nmap <localleader>g  <Plug>(go-def)
  au FileType go nmap <localleader>dd <Plug>(go-def-vertical)
  au FileType go nmap <localleader>dv <Plug>(go-doc-vertical)
  au FileType go nmap <localleader>db <Plug>(go-doc-browser)

  au FileType go nmap <localleader>r  <Plug>(go-run)
  " au FileType go nmap <localleader>n :GoReferrers<cr>
  au FileType go nmap <localleader>t  <Plug>(go-test)
  au FileType go nmap <localleader>c  <Plug>(go-coverage-toggle)
  au FileType go nmap <localleader>i  <Plug>(go-implements)
  au FileType go nnoremap <silent> <localleader>l <Plug>(go-metalinter)

  au FileType go nnoremap <localleader>gd :GoDeclsDir<cr>

  au FileType go nnoremap <localleader>b :GoDebugBreakpoint<cr>

augroup END
" }}}

" Vim Highlighted Yank {{{
" ===================
let g:highlightedyank_highlight_duration = 200
" }}}

" Vim Python {{{
" ===================
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1

" Syntax highlight
" Default highlight is better than polyglot
let g:polyglot_disabled = ['python', 'go']
let g:python_highlight_all = 1
" }}}


let g:python3_host_prog = '/Users/brian/.pyenv/versions/neovim3/bin/python'

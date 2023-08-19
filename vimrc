" MATT'S VIM RUNCOM

" CONFIG  ---------------------------------------------------------------- {{{

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file is use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Allow hidden buffers
set hidden

" Add numbers to the file.
set number
set relativenumber

" Highlight cursor line underneath the cursor horizontally.
" set cursorline

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set softtabstop=4
set tabstop=4

" Use indent from previous line
set autoindent
set smartindent

" Allow backspacing over autoindent, line breaks, and start of insert
set backspace=indent,eol,start

" Use space characters instead of tabs (except Makefile)
set expandtab
autocmd FileType make setlocal noexpandtab

" Do not save backup files.
set nobackup

" Enable using mouse (bad form)
set mouse=a

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Remove annoying error bell sound and visual
set noerrorbells visualbell t_vb=

" }}}

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

" Plug 'sainnhe/everforest' "Colors
Plug 'catppuccin/vim', { 'as': 'catppuccin' } "Colors
Plug 'sheerun/vim-polyglot' "Better syntax highlighting
Plug 'jdhao/better-escape.vim' "For better remapping esc key to jj
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' "Fuzzy find plugin
Plug 'junegunn/goyo.vim' "Removes Line numbers for focusing
Plug 'preservim/nerdtree' "File browser inside vim
Plug 'prabirshrestha/asyncomplete.vim' "Autocompletion inside vim
Plug 'prabirshrestha/vim-lsp' "Language servers inside vim
Plug 'prabirshrestha/asyncomplete-lsp.vim' "Add autocompletion to lsp
Plug 'mattn/vim-lsp-settings' "Configuring lsp servers
Plug 'fatih/vim-go' "Lots of useful Go additions
Plug 'github/copilot.vim' "Github Copilot

call plug#end()

" NERDTree config
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

" LSP configs

" python-language-server
" note: must install python-lsp-black in lsp virtualenv
let g:lsp_settings = {
\   'pylsp-all': {
\     'workspace_config': {
\       'pylsp': {
\         'configurationSources': ['flake8'],
\         'plugins': {
\           'black': {
\             'enabled': 1,
\             'line_length': 88
\           },
\           'flake8': {
\             'enabled': 1
\           },
\           'mccabe': {
\             'enabled': 0
\           },
\           'pycodestyle': {
\             'enabled': 0
\           },
\           'pyflakes': {
\             'enabled': 0
\           }
\         }
\       }
\     }
\   },
\}

" }}}

" MAPPINGS --------------------------------------------------------------- {{{

" Set apostrophe as the leader key.
let mapleader="'"

" Press \\ to jump back to the last cursor position.
nnoremap <leader>\ ``

" Press \p to print the current file to the default printer from a Linux operating system.
" View available printers:   lpstat -v
" Set default printer:       lpoptions -d <printer_name>
" <silent> means do not display output.
nnoremap <silent> <leader>p :%w !lp<CR>

" Press the space bar to type the : character in command mode.
nnoremap <space> :

" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$

" Map the F5 key to run a Python script inside Vim.
" We map F5 to a chain of commands here.
" :w saves the file.
" <CR> (carriage return) is like pressing the enter key.
" !clear runs the external clear screen command.
" !python3 % executes the current file with Python.
nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" Stabilize vertical splitting
nnoremap <C-W>s Hmx`` \|:split<CR>`xzt``

" 'Q' in normal mode enters Ex mode. You almost never want this.
nmap Q <Nop>

" Plugin mappings

" Type jj to exit insert mode quickly with better escape
let g:better_escape_shortcut = 'jj'
let g:better_escape_interval = 250

" Launch fzf file searching
nnoremap <leader>f :Files!<CR>

" Launch Goyo
map <C-\> :Goyo<CR>

" Map the F3 key to toggle NERDTree open and close.
map <Leader>t :NERDTreeToggle<CR>

" Tab completion with asyncomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" LSP shortcuts
nnoremap <leader>gd :LspDefinition<cr>
nnoremap <leader>nd :LspNextDiagnostic<cr>
nnoremap <leader>pd :LspPreviousDiagnostic<cr>
nnoremap <leader>gr :LspReferences<cr>
nnoremap <leader>re :LspRename<cr>
" handled by LSP
" nnoremap <leader>ft :LspDocumentFormat<cr> 
nnoremap <leader>er :LspDocumentDiagnostics<cr>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
nnoremap <leader>k :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" Enable the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" You can split a window into sections by typing `:split` or `:vsplit`.
" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline
augroup END

" Format specified filetypes to match lsp pre-write
autocmd! BufWritePre *.py call execute('LspDocumentFormatSync')
autocmd! BufWritePre *.go call execute('GoFmt')

" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
"set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2

" }}}

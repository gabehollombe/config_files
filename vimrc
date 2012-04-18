" Load Pathogen bundles
call pathogen#runtime_append_all_bundles()

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set nowritebackup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

set cursorline " highlight current line
set hidden " allow unsaved buffers

" Smart indent options
set smartindent
set autoindent

" Use Q to format lines to 'textwidth' length
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

" Folding
if has("folding")
  set foldenable
  set foldmethod=indent
  set foldlevel=1
  set foldnestmax=10
  set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
endif

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Always display the status line
set laststatus=2

" \ is the leader character
let mapleader = "\\"

" Edit the README_FOR_APP (makes :R commands work)
map <Leader>R :e doc/README_FOR_APP<CR>

" Leader shortcuts for Rails commands
map <Leader>m :Rmodel 
map <Leader>c :Rcontroller 
map <Leader>v :Rview 
map <Leader>u :Runittest 
map <Leader>f :Rfunctionaltest 
map <Leader>sm :RSmodel 
map <Leader>sc :RScontroller 
map <Leader>sv :RSview 
map <Leader>su :RSunittest 
map <Leader>sf :RSfunctionaltest 
" Edit routes
command! Rroutes :e config/routes.rb
command! RTroutes :tabe config/routes.rb

" Toggle search highlighting 
map <Leader>h :set invhls <CR>

" Maps autocomplete to Control-Space
imap <c-space> <C-N>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" For Haml
au! BufRead,BufNewFile *.haml         setfiletype haml

" No Help, please
nmap <F1> <Esc>

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif

" Color scheme
colorscheme vividchalk
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set number
set numberwidth=5

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

" Case only matters with mixed case expressions
set ignorecase
set smartcase

" Set gui font
set guifont=Anonymous\ Pro:h14

let g:browser = 'open'     
" Open the Ruby ApiDock page for the word under cursor, in a new Browser tab
function! OpenRubyDoc(keyword)
  let url = 'http://apidock.com/ruby/'.a:keyword
  exec '!'.g:browser.' '.url.''
endfunction           
noremap RB :call OpenRubyDoc(expand('<cword>'))<CR>
 
" Open the Rails ApiDock page for the word under cursos, in a Browser tab
function! OpenRailsDoc(keyword)
  let url = 'http://apidock.com/rails/'.a:keyword
  exec '!'.g:browser.' '.url.''
endfunction
noremap RR :call OpenRailsDoc(expand('<cword>'))<CR>

" CtrlP bindings
let g:ctrlp_map = '<Leader>t'
map <Leader>b :CtrlPBuffer<CR>
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_switch_buffer = 0 " Don't jump to existing buffer/tab instances of file matches
let g:ctrlp_jump_to_buffer = 0 " Don't jump to existing buffer/tab instances of file matches


" Ignore some dirs
set wildignore+=*/.git/*,*/.hg/*,*/.svn/* 


" Make Control+V do a system clipboard paste in normal and insert modes
" nmap <C-V> "+gP
" imap <C-V> <ESC><C-V>i

" Nerd Tree shortcut
map <leader>n :NERDTreeToggle<CR>

" Make jj take us out of insert mode
imap jj <esc>

if (has("gui_running"))
  " Make fullscreen mode window size take up the full screen
  set fuoptions=maxvert,maxhorz
  "
  " Remove the vim toolbar from Win/GTK versions
  set guioptions-=T
endif

" Turn off the arrow keys for learning cardinal hjkl directions.
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>


" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" use w!! to sudo :w  a file that we opened without su privs
cmap w!! w !sudo tee % >/dev/null


" add in matchit.vim built in plugin
runtime macros/matchit.vim


" How to run current ruby file as ruby script and show result in new window:
" :w !ruby | mvim -c "set nomodified" -

" Turn off K (defaults to search for word under cursor, but I always typo it
" when I mean to type J to join lines.
  nmap K <nop>


" Keep search result in center of screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

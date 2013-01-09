" Environment {
  set nocompatible        " must be first line

  " Setup Bundle Support {
  " The next three lines ensure that the ~/.vim/bundle/ system works
    filetype on
    filetype off
    set rtp+=~/.vim/bundle/vundle
    call vundle#rc()
  " }
" }

" Bundles {
    " Deps
        Bundle 'gmarik/vundle'
        Bundle 'MarcWeber/vim-addon-mw-utils'
        Bundle 'tomtom/tlib_vim'
        if executable('ack-grep')
            let g:ackprg="ack-grep -H --nocolor --nogroup --column"
            Bundle 'mileszs/ack.vim'
        elseif executable('ack')
            Bundle 'mileszs/ack.vim'
        endif

    " General
        Bundle 'scrooloose/nerdtree'
        " Bundle 'jistr/vim-nerdtree-tabs'
        Bundle 'altercation/vim-colors-solarized'
        Bundle 'spf13/vim-colors'
        Bundle 'tpope/vim-surround'
        " Bundle 'AutoClose'
        Bundle 'kien/ctrlp.vim'
        " Bundle 'vim-scripts/sessionman.vim'
        Bundle 'matchit.zip'
        Bundle 'Lokaltog/vim-powerline'
        Bundle 'Lokaltog/vim-easymotion'

        "Make gvim color schemes work in terminal
        Bundle 'godlygeek/csapprox'
        Bundle 'flazz/vim-colorschemes'

        Bundle 'mbbill/undotree'
        Bundle 'nathanaelkane/vim-indent-guides'
        " Bundle 'vim-scripts/restore_view.vim'
        " Bundle 'tpope/vim-abolish.git'

    " General Programming
        " Pick one of the checksyntax, jslint, or syntastic
        Bundle 'scrooloose/syntastic'

        Bundle 'tpope/vim-fugitive'
        Bundle 'scrooloose/nerdcommenter'

        "For aligning ='s, :'s, etc
        Bundle 'godlygeek/tabular'

        if executable('ctags')
            Bundle 'majutsushi/tagbar'
        endif

    " Snippets & AutoComplete
        " Bundle 'Shougo/neocomplcache'
        " Bundle 'Shougo/neosnippet'
        " Bundle 'honza/snipmate-snippets'

    " Python
        " Pick either python-mode or pyflakes & pydoc
        " Bundle 'klen/python-mode'
        " Bundle 'python.vim'
        " Bundle 'python_match.vim'
        " Bundle 'pythoncomplete'

    " Javascript
        Bundle 'leshill/vim-json'
        Bundle 'groenewege/vim-less'
        Bundle 'pangloss/vim-javascript'
        Bundle 'briancollins/vim-jst'
        Bundle 'vim-coffee-script'
        


    " HTML
        Bundle 'amirh/HTML-AutoCloseTag'
        Bundle 'hail2u/vim-css3-syntax'

    " Ruby
        Bundle 'tpope/vim-rails'
        let g:rubycomplete_buffer_loading = 1
        "let g:rubycomplete_classes_in_global = 1
        "let g:rubycomplete_rails = 1

    " Misc
        Bundle 'tpope/vim-markdown'
        Bundle 'spf13/vim-preview'
" }

set backspace=indent,eol,start " allow backspacing over everything in insert mode

" Store swap files in fixed location, not current directory.
set dir=~/.vimswap//,/var/tmp//,/tmp//,.
set nobackup
set nowritebackup

set history=500		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching


set cursorline " highlight current line
set hidden " allow unsaved buffers

" Smart indent options
set smartindent
set autoindent

" Auto change working directory to current file
autocmd BufEnter * silent! lcd %:p:h


filetype plugin indent on   " Automatically detect file types.
syntax on                   " syntax highlighting
set mouse=a                 " automatically enable mouse usage
set mousehide               " hide the mouse cursor while typing
scriptencoding utf-8
set hlsearch

set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit=onemore         " allow for cursor beyond last character

set background=dark         " Assume a dark background

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

set guifont=Source\ Code\ Pro\ Light:h14,Andale\ Mono\ Regular:h16,Menlo\ Regular:h15,Consolas\ Regular:h16,Courier\ New\ Regular:h18
set noantialias

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
"
" Adjust viewports to the same size
map <Leader>= <C-w>=

" map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Make Leader+8 (think * but with leader instead of shift) Ack for word
" under cursor
nmap <Leader>8 :Ack! <cword><cr>



" add in matchit.vim built in plugin
runtime macros/matchit.vim


" How to run current ruby file as ruby script and show result in new window:
" :w !ruby | mvim -c "set nomodified" -

" Turn off K (defaults to search for word under cursor, but I always typo it
" when I mean to type J to join lines.
  nmap K <nop>

" I always fat-finger :W when I mean :w, so bind it
cmap W w

" use | and - for splits faster
nmap <bar> <C-w>v
nmap - <C-w>s


" Keep search result in center of screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz

" vim-slime settings
let g:slime_target = "tmux"

" Vim UI {
    if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
      let g:solarized_termcolors=256
      let g:solarized_termtrans=1
      let g:solarized_contrast="high"
      let g:solarized_visibility="high"
      color solarized                 " load a colorscheme
    endif
    set tabpagemax=15               " only show 15 tabs
    set showmode                    " display the current mode

    set cursorline                  " highlight current line

    if has('cmdline_info')
        set ruler                   " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                 " show partial commands in status line and
                                    " selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\    " Filename
        set statusline+=%w%h%m%r " Options
        set statusline+=%{fugitive#statusline()} "  Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=\ [%{getcwd()}]          " current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " backspace over everything in insert mode
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " show matching brackets/parenthesis
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap too
    set scrolljump=5                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set foldenable                  " auto fold code
    set list
    " set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
    set listchars=tab:»·,trail:·,extends:#,nbsp:. " Highlight problematic whitespace
    " set list listchars=tab:»·,trail:·
" }

""" Code folding options
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


" Plugins {
    " Ctags {
        set tags=./tags;/,~/.vimtags
    " }
    " NerdTree {
       "  map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
       "  map <leader>e :NERDTreeFind<CR>
       "  nmap <leader>nt :NERDTreeFind<CR>

       "  " let NERDTreeShowBookmarks=1
       "  let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
       "  " let NERDTreeChDirMode=0
       "  let NERDTreeQuitOnOpen=1
       "  let NERDTreeMouseMode=2
       "  let NERDTreeShowHidden=1
       "  let NERDTreeKeepTreeInNewTab=1
        " let g:nerdtree_tabs_open_on_gui_startup=0
    " }

    " Tabularize {
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
     " }

     " Buffer explorer {
      " nmap <leader>b :BufExplorer<CR>
     " }

     " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
     " }

     " ctrlp {
        " nnoremap <silent> <D-t> :CtrlP<CR>
        " nnoremap <silent> <D-r> :CtrlPMRU<CR>
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$' }
        let g:ctrlp_match_window_bottom = 0 "Put the match window on top
        let g:ctrlp_match_window_reversed = 0 "Put best match on top of match window
        let g:ctrlp_switch_buffer = 0 " Don't jump to existing buffer/tab instances of file matches
        let g:ctrlp_jump_to_buffer = 0 " Don't jump to existing buffer/tab instances of file matches
        let g:ctrlp_working_path_mode = 'ra'
        let g:ctrlp_map = '<Leader>t'
        map <Leader>b :CtrlPBuffer<CR>
     "}

     " TagBar {
        nnoremap <silent> <leader>tt :TagbarToggle<CR>
     "}

     " PythonMode {
     " Disable if python support not present
        if !has('python')
           let g:pymode = 1
        endif
     " }

     " Fugitive {
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
     "}
     " UndoTree {
        nnoremap <Leader>u :UndotreeToggle<CR>
        let g:undotree_SetFocusWhenToggle=1 " if undotree is opened, it is likely one wants to interact with it.
     " }

     " indent_guides {
        if !exists('g:spf13_no_indent_guides_autocolor')
            let g:indent_guides_auto_colors = 1
        else
            " for some colorscheme ,autocolor will not work,like 'desert','ir_black'.
            autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121   ctermbg=3
            autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=4
        endif
        set ts=2 sw=2 et
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 0
     " }
" }


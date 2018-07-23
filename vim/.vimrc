set nocompatible              " be iMproved, required
filetype off                  " required

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --tern-completer
  endif
endfunction

" key defs
" Leader  = \
" C       = Ctrl
" S       = Shift

call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'myusuf3/numbers.vim'
Plug 'fholgado/minibufexpl.vim'
Plug 'kien/ctrlp.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'kien/rainbow_parentheses.vim'
Plug 'mileszs/ack.vim'
Plug 'jaxbot/browserlink.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'jceb/vim-orgmode'
Plug 'vim-scripts/utl.vim'
"Plun 'vim-scripts/taglist.vim'
Plug 'chrisbra/NrrwRgn'
Plug 'vim-scripts/calendar.vim'
"Plug 'vim-scripts/SyntaxRange'
"Plug 'vim-scripts/paredit.vim'
Plug 'mtth/scratch.vim'
Plug 'leafgarland/typescript-vim'
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'
Plug 'OmniSharp/omnisharp-vim'
"Plug 'scrooloose/syntastic'
"Plug 'unblevable/quick-scope'
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar'
Plug 'vim-php/phpctags'
"Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'
Plug 'guns/vim-sexp'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
"Plug 'bhurlow/vim-parinfer'

"tpope
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise' "screws up paredit electric return

"js
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'

"colorschemes
Plug 'ajh17/Spacegray.vim'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'

call plug#end()

syntax enable
filetype plugin indent on    " required

"nerd tree
map <Leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1 " show hidden files
map <leader>m :NERDTreeFind<CR> " find the current file in NerdTree
let NERDTreeIgnore = ['\.pyc$']

"colors
set t_Co=256
"solarized
"set background=dark
"colorscheme solarized
"molokai
colorscheme molokai
"let g:molokai_original = 1
"colorscheme dracula
"spacegray
"let g:spacegray_underline_search = 1
"let g:spacegray_use_italics = 1
"colorscheme spacegray

"numbers
let g:numbers_exclude = ['tagbar', 'gundo', 'minibufexpl', 'nerdtree']
set number

"minibufexplorer
noremap <C-TAB>   :MBEbn<CR>
noremap <C-S-TAB> :MBEbp<CR>
" MiniBufExpl Colors
let g:did_minibufexplorer_syntax_inits = 1
hi MBENormal               guifg=#808080 guibg=#272822
hi MBEChanged              guifg=#CD5907 guibg=#272822
hi MBEVisibleNormal        guifg=#5DC2D6 guibg=#272822
hi MBEVisibleChanged       guifg=#F1266F guibg=#272822
hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=#272822
hi MBEVisibleActiveChanged guifg=#F1266F guibg=#272822
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplBRSplit = 1

"youcompleteme
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"backups
set backupdir=~/.vim/backup
set directory=~/.vim/backup

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif

"formatting
set expandtab
set tabstop=2
set nowrap
set shiftwidth=2
set softtabstop=2
set autoindent
set encoding=utf-8
set smarttab

"rainbow parentheses
let g:rbpt_colorpairs = [
                        \ ['brown',       'RoyalBlue3'],
                        \ ['Darkblue',    'SeaGreen3'],
                        \ ['darkgray',    'DarkOrchid3'],
                        \ ['darkgreen',   'firebrick3'],
                        \ ['darkcyan',    'RoyalBlue3'],
                        \ ['darkred',     'SeaGreen3'],
                        \ ['darkmagenta', 'DarkOrchid3'],
                        \ ['brown',       'firebrick3'],
                        \ ['gray',        'RoyalBlue3'],
                        \ ['black',       'SeaGreen3'],
                        \ ['darkmagenta', 'DarkOrchid3'],
                        \ ['Darkblue',    'firebrick3'],
                        \ ['darkgreen',   'RoyalBlue3'],
                        \ ['darkcyan',    'SeaGreen3'],
                        \ ['darkred',     'DarkOrchid3'],
                        \ ['red',         'firebrick3'],
                        \ ]

"fileload
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
autocmd BufNewFile,BufRead *.edn  set filetype=clojure
autocmd BufNewFile,BufRead *.hl   set filetype=clojure
autocmd BufNewFile,BufRead *.boot set filetype=clojure
autocmd BufNewFile,BufRead *.cljs set filetype=clojure
autocmd BufNewFile,BufRead *.md   set filetype=markdown
autocmd BufRead,BufNewFile *.es6  set filetype=javascript

"tabs
au FileType php setlocal noexpandtab
au FileType coffee set expandtab
au FileType ruby set expandtab
au FileType clojure set expandtab
au FileType javascript set expandtab

"indent-guide
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_space_guides = 1

"ctrlp
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 30
let g:ctrlp_regexp = 1 " default to regexp search
let g:ctrlp_custom_ignore = '.*bower_components\|node_modules\|DS_Store\|git'
let g:ctrlp_working_path_mode = '' "disable CWD switching
"let g:ctrlp_user_command = 'if [ -e ".ctrlpignore" ] ; then find %s -type f | grep -v "`cat .ctrlpignore`" ; else find %s -type f ; fi ;'
"let g:ctrlp_user_command = 'echo $SHELL'
"let g:ctrlp_user_command = 'find %s -type f'

"paredit
let g:paredit_leader = '\'
let g:paredit_mode = 1

"GUIOptions
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
if has("gui_gtk2") " Running on Linux
    set guifont=Inconsolata\ 10
elseif has("gui_win32") " Running on Windows
    set guifont=Inconsolata:h12:cANSI
    au GUIEnter * simalt ~x " starts gvim in maximized mode
endif

" react
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

"tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_phpctags_bin='~/.vim/bundle/phpctags/bin/phpctags'

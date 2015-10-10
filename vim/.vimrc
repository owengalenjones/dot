set nocompatible              " be iMproved, required
filetype off                  " required

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'myusuf3/numbers.vim'
Plug 'fholgado/minibufexpl.vim'
Plug 'kien/ctrlp.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-fugitive'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-leiningen'
Plug 'mileszs/ack.vim'
Plug 'tomasr/molokai'
Plug 'jaxbot/browserlink.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'jceb/vim-orgmode'
Plug 'vim-scripts/utl.vim'
"Plun 'vim-scripts/taglist.vim'
Plug 'chrisbra/NrrwRgn'
Plug 'vim-scripts/calendar.vim'
Plug 'vim-scripts/SyntaxRange'
Plug 'tpope/vim-speeddating'
"Plun 'tpope/vim-endwise' screws up paredit electric return
Plug 'vim-scripts/paredit.vim'
Plug 'mtth/scratch.vim'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'sheerun/vim-polyglot'
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'
Plug 'OmniSharp/omnisharp-vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-dispatch'
Plug 'mxw/vim-jsx'
"Plug 'unblevable/quick-scope'
Plug 'pangloss/vim-javascript'
Plug 'zenorocha/dracula-theme', {'rtp': 'vim/'}
Plug 'majutsushi/tagbar'
Plug 'vim-php/phpctags'
Plug 'vim-scripts/tagbar-phpctags'
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
call plug#end()

syntax enable
filetype plugin indent on    " required

"polyglot
let g:polyglot_disabled =['javascript']

"nerd tree
map <Leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1 " show hidden files
map <leader>m :NERDTreeFind<CR> " find the current file in NerdTree

"colors
"solarized
"set background=dark
"colorscheme solarized
"molokai
"colorscheme molokai
"let g:molokai_original = 1
set t_Co=256
colorscheme dracula

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
autocmd BufNewFile,BufRead *.edn set filetype=clojure
autocmd BufNewFile,BufRead *.cljs set filetype=clojure
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

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

"syntastic
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']

let NERDTreeIgnore = ['\.pyc$']

" key defs
" Leader  = \
" C       = Ctrl
" S       = Shift


" OmniSharp won't work without this setting
filetype plugin on

"This is the default value, setting it isn't actually necessary
let g:OmniSharp_host = "http://localhost:2000"

"Set the type lookup function to use the preview window instead of the status line
"let g:OmniSharp_typeLookupInPreview = 1

"Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 1

"Showmatch significantly slows down omnicomplete
"when the first match contains parentheses.
set noshowmatch

"Super tab settings - uncomment the next 4 lines
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
"let g:SuperTabClosePreviewOnPopupClose = 1

"don't autoselect first item in omnicomplete, show if only one item (for preview)
"remove preview if you don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview
" Fetch full documentation during omnicomplete requests.
" There is a performance penalty with this (especially on Mono)
" By default, only Type/Method signatures are fetched. Full documentation can still be fetched when
" you need it with the :OmniSharpDocumentation command.
" let g:omnicomplete_fetch_documentation=1

"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
"You might also want to look at the echodoc plugin
set splitbelow

" Get Code Issues and syntax errors
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
" If you are using the omnisharp-roslyn backend, use the following
" let g:syntastic_cs_checkers = ['code_checker']

au FileType cs let NERDTreeIgnore = ['\.meta$']
augroup omnisharp_commands
    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    " autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END


" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

" react
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
let g:syntastic_javascript_checkers = ['eslint']

"tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_phpctags_bin='~/.vim/bundle/phpctags/bin/phpctags'

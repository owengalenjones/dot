" MacVim "{{{
if has("gui_macvim")
  set fuoptions=maxhorz,maxvert
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

  macmenu &File.New\ Tab key=<D-T>
  map <D-t> :CommandT<CR>
  imap <D-t> <Esc>:CommandT<CR>

  map <D-F> :Ack<space>

  vmap <D-]> >gv
  vmap <D-[> <gv
endif

" Visual "{{{
set guioptions-=T
set guioptions=aAce
set guifont=Monaco:h14
set lines=55
set columns=130
" "}}}

" Local Configuration "{{{
if filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif
" "}}}

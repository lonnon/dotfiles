set nocompatible
set viminfo=%,'1000,<50,!,/50,:100,n~/.vim/cache/.viminfo
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set tags=./TAGS;

execute pathogen#infect()
execute pathogen#helptags()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=1000        " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set hidden              " don't freak out over hidden buffers
set encoding=utf-8 fileencodings=    " force utf-8 for all files
set autoread
set sessionoptions-=options
set ttimeout
set ttimeoutlen=50

" Behave like vi if invoked via crontab
if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

" Add shortcut mapping for ESC
inoremap kj <Esc>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Use Solarized color schme
set t_Co=256
let g:solarized_termcolors=16
set background=dark
colorscheme solarized

" Highlight current line
set cursorline

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Tab settings for various languages
  autocmd FileType make       setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType yaml       setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType lsl        setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).  Also don't do it when the mark
    " is in the first line, that is the default position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

  augroup END

else

  set autoindent                " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.  Only define it when not
" defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" Set my own mapleader
let mapleader = ","

" Toggle spell checking with `,s`
nmap <silent> <leader>s :set spell!<CR>

" Turn off the damn bell
set vb t_vb=

" Toggle display of tabs and newlines
nmap <leader><tab> :set list!<CR>

" Set up display of non-printing characters
set listchars=tab:→·,eol:¶,trail:·
set showbreak=…

function! ToggleShowbreak()
  if &showbreak == '…'
    set showbreak=
  else
    set showbreak=…
  endif
endfunction

nmap <leader>8 :call ToggleShowbreak()<CR>

" Customize tab settings
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

function! Preserve(command)
  " Save last search and cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")

  execute a:command

  " Restore search history and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Strip trailing whitespace
nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>

" Indent entire buffer
nmap <leader>= :call Preserve("normal gg=G")<CR>

" Delete comment character when joining commented lines
set formatoptions+=j

" Toggle paste mode for pasting from terminal without autoindent
" From http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Shortcuts for editing files in the same directory as the current file
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
map <leader>cd :lcd %:p:h<CR>

" Make a command for turning on soft word wrap with line breaks between words
command! -nargs=* Wrap set wrap linebreak nolist
nmap <leader>w :Wrap<CR>

" Use par for formatting paragraphs
set formatprg=par\ rq

" Clear last search and its highlighting
nmap <leader>h :let @/ = ""<CR>:echo 'Highlight cleared'<CR>

" Shortcut for inserting date stamp
nmap <leader>d :r ! date +\%F<CR>

" Display and toggle YankRing
let g:yankring_history_file = '.yankring_history'
map <leader>y :YRShow<CR>
map <leader>Y :YRToggle<CR>

" Toggle quickfix and location lists
function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

" Make location and quickfix list navigation friendlier
function! <SID>LocationPrevious()
  try
    lprev
  catch /^Vim\%((\a\+)\)\=:E553/
    llast
  endtry
endfunction

function! <SID>LocationNext()
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  endtry
endfunction

nnoremap <silent> <Plug>LocationPrevious :<C-u>exe 'call <SID>LocationPrevious()'<CR>
nnoremap <silent> <Plug>LocationNext :<C-u>exe 'call <SID>LocationNext()'<CR>

function! <SID>QuickfixPrevious()
  try
    cprev
  catch /^Vim\%((\a\+)\)\=:E553/
    clast
  endtry
endfunction

function! <SID>QuickfixNext()
  try
    cnext
  catch /^Vim\%((\a\+)\)\=:E553/
    cfirst
  endtry
endfunction

nnoremap <silent> <Plug>QuickfixPrevious :<C-u>exe 'call <SID>QuickfixPrevious()'<CR>
nnoremap <silent> <Plug>QuickfixNext :<C-u>exe 'call <SID>QuickfixNext()'<CR>

nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>e :call ToggleList("Quickfix List", 'c')<CR>
nmap <silent> ]l <Plug>LocationNext
nmap <silent> [l <Plug>LocationPrevious
nmap <silent> ]q <Plug>QuickfixNext
nmap <silent> [q <Plug>QuickfixPrevious

" Syntastic
let g:syntastic_stl_format = "[%E{ %e}%B{ / }%W{ %w}]"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_flake8_args = '--ignore=E123,E126,E127,E128 --max-line-length 120'
let g:syntastic_mode_map = { "mode": "active" }

" python-mode
let g:pymode_options = 0
let g:pymode_options_colorcolumn = 1
let g:pymode_folding = 0
let g:pymode_breakpoint_bind = '<leader>t'
let g:pymode_lint = 0
let g:pymode_rope = 0
let g:pymode_lint_ignore = 'E123,E126,E127,E128'
let g:pymode_lint_options_pep8 = { 'max_line_length': 120 }
let g:pymode_rope_lookup_project = 0

autocmd Syntax python setlocal complete+=t
autocmd Syntax python setlocal formatoptions-=t
autocmd Syntax python setlocal commentstring=#%s
autocmd Syntax python setlocal define=^\s*\\(def\s\\|class\s\\)
autocmd Syntax python normal zR

" Unite
map <leader>f :Unite -no-split -buffer-name=files  -prompt=    file_rec/async<CR>
map <leader>F :Unite -no-split -buffer-name=files  -prompt=    file<CR>
map <leader>b :Unite -no-split -buffer-name=buffer -quick-match buffer<CR>
map <leader>B :Unite -no-split -buffer-name=buffer -prompt=    buffer<CR>
map <leader>a :Unite -no-split -buffer-name=ack    -prompt=    grep:.<CR>

let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts =
      \ '-i --vimgrep --hidden --ignore ' .
      \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt = ''

call unite#filters#matcher_default#use(['matcher_fuzzy'])

" airline
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#wordcount#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''

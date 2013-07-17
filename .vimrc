" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif
set history=50      " keep 50 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

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
  syntax enable
  set background=dark
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
  autocmd FileType text setlocal textwidth=79

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent
  set copyindent

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Use :diffoff to turn the diff off, :bd instead of :q
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

" Quality of life
set number
set smartcase
set hidden
set title

" Folding options
set foldmethod=syntax
set foldlevelstart=20
" let c_no_comment_fold=1

" source code formatting
set tabstop=2         " Tabs are two spaces
set shiftwidth=2      " Indents are 2 spaces
set expandtab         " Spaces instead of tabs
set tw=79             " Can use gq to wrap a visual block

" Highlight actual tabs <Ctrl-V + Tab> to insert
" an actual tab (in insertion mode)
highlight SpecialKey ctermfg=1
set list
set listchars=tab:T>

" Copy paste to a local file
vmap <C-y> :w! ~/.vbuf<CR>
nmap <C-y> :.w! ~/.vbuf<CR>
nmap <C-p> :r ~/.vbuf<CR>

" Switch between cpp/h files
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Switch between windows
map <F5> <C-W>w

" mapping for cycling through buffers
map <F6> :bp<cr>
map <F7> :bn<cr>

" persistent Copy & Paste (word)
map <F9> viwy
map <F10> viw"0p

" Tags
set tags=./tags;

" Color schemes
if has('gui_running')
  colorscheme solarized
  set lines=999 columns=999
endif

" Better statusline
set statusline=%F       " Full path
set statusline+=\ %m    " Modified flag
set statusline+=\ %r    " Read only flag
set statusline+=%=      " Left/right separator
set statusline+=%l/%L   " Cursor line/total lines
set statusline+=\ %c\   " Cursor column
set laststatus=2

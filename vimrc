" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Vundle setup
if isdirectory(expand("~/.vim/bundle/Vundle.vim"))
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  Plugin 'gmarik/Vundle.vim'

  " Vundle Plugins
  Plugin 'Lokaltog/vim-easymotion'
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'ctrlpvim/ctrlp.vim'
  Plugin 'junegunn/vim-easy-align'
  "Plugin 'Valloric/YouCompleteMe'
  "Plugin 'rhysd/vim-clang-format'

  " End Vundle (also required)
  call vundle#end()
  filetype plugin indent on
endif

" Temporary, delete me
map <Leader> <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-s)

" Vundle Plugin Configuration
if isdirectory(expand("~/.vim/bundle/Vundle.vim"))
  if isdirectory(expand("~/.vim/bundle/YouCompleteMe"))
    "let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
    "let g:ycm_extra_conf_globlist = ['~/.vim/*']
    "let g:ycm_extra_conf_globlist = ['~/work/*']
    let g:ycm_complete_in_strings = 0
    let g:ycm_autoclose_preview_window_after_insertion = 1
    "let g:ycm_collect_identifiers_from_tags_files = 1 "Might result in slowdown

    " To disable clang stuff in YCM
    "let g:ycm_show_diagnostics_ui = 1
    "let g:ycm_enable_diagnostic_signs = 0
    "let g:ycm_echo_current_diagnostic = 0
    "let g:ycm_enable_diagnostic_highlighting = 0
  endif
  if isdirectory(expand("~/.vim/bundle/vim-airline"))
    let g:airline#extensions#whitespace#checks = [ 'trailing', 'mixed-indent-file', 'indent' ]
  endif
  if isdirectory(expand("~/.vim/bundle/ctrlp"))
    let g:ctrlp_regexp = 1 "Regex search by default, since we're limited to 10 lines
  endif
  if isdirectory(expand("~/.vim/bundle/vim-easymotion"))
    map <Leader> <Plug>(easymotion-prefix)
    nmap s <Plug>(easymotion-s)
  endif
  if isdirectory(expand("~/.vim/bundle/vim-easy-align"))
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)
  endif
  if isdirectory(expand("~/.vim/bundle/vim-clang-format"))
    let g:clang_format#detect_style_file=1
    let g:clang_format#auto_format=1
  endif
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup          " keep a backup file
set backupdir=~/.vim/backupdir
set undofile        " Global undo!
set undodir=~/.vim/undodir
set history=50      " keep 50 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax enable
set background=dark
if has("gui_running")
  colorscheme solarized
  if has("macunix")
    set guifont=Monaco:h14
  endif
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
    \   exe "normal! g`\" zz" |
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

" Appearance
set number
set title

" Searching
set ignorecase smartcase
set incsearch
set showmatch
set hlsearch

" Auto indent
set ai
set smartindent
set cinoptions +=(0

" Allow buffer changes despite unwritten changes
set hidden

" Folding options
set foldmethod=syntax
set foldlevelstart=20
" let c_no_comment_fold=1

" Source code formatting
set tabstop=2         " Tabs are two spaces
set softtabstop=2
set shiftwidth=2      " Indents are 2 spaces
set expandtab         " Spaces instead of tabs
set tw=79             " Can use gq to wrap a visual block

" Highlight actual tabs <Ctrl-V + Tab> to insert
" an actual tab (in insertion mode)
highlight SpecialKey ctermfg=1
set list
set listchars=tab:T>


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
set tags=tags;

" Stop pressing Shift so much!
nmap ; :

" Remap Ctl-] to g-Ctrl-] to get the list of matches on conflicts
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>

" Better statusline
set statusline=%F       " Full path
set statusline+=\ %m    " Modified flag
set statusline+=\ %r    " Read only flag
set statusline+=%=      " Left/right separator
set statusline+=%l/%L   " Cursor line/total lines
set statusline+=\ %c\   " Cursor column
set laststatus=2        " Always show the status line


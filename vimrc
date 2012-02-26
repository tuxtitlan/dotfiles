set encoding=utf-8
set fileencodings=
set nocompatible    " use vim defaults
set ls=2            " allways show status line
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
set expandtab       " tabs are converted to spaces
set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
set visualbell t_vb=    " turn off error beep/flash
set novisualbell    " turn off visual bell
set nobackup        " do not keep a backup file
set directory=~/.tmp
set number          " show line numbers
set ignorecase      " ignore case when searching 
"set noignorecase   " don't ignore case
"set title           " show title in console title bar
"set ttyfast         " smoother changes
"set ttyscroll=0        " turn off scrolling, didn't work well with PuTTY
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines
set shortmess=atI   " Abbreviate messages
set nostartofline   " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]   " move freely between files
"set viminfo='20,<50,s10,h
"
"set autoindent     " always set autoindenting on
"set smartindent        " smart indent
""set cindent            " cindent
set noautoindent
set nosmartindent
set nocindent   

"set autowrite      " auto saves changes when quitting and swiching buffer
"set sm             " show matching braces, somewhat annoying...
"set nowrap         " don't wrap lines

setlocal spelllang=en_us

call pathogen#runtime_append_all_bundles()

map <c-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '.pyc', '.egg-info', '.class']

if has('gui_running')
    set guifont=Inconsolata:h14
    set background=light
else
    set background=dark
    let g:solarized_termcolors=256
endif

filetype plugin indent on
highlight SpellBad term=underline gui=undercurl guisp=Orange
syntax enable
colorscheme solarized

augroup myfiletypes
    " Clear old autocmds in group
    autocmd!
    " autoindent with two spaces, always expand tabs
    autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END

" Toggle pyflakes quickfix
let g:pyflakes_use_quickfix=1
function! TogglePyflakesQf()
    if (g:pyflakes_use_quickfix==0)
    let g:pyflakes_use_quickfix=1
else
    let g:pyflakes_use_quickfix=0
endif
endfunction
command! PyflakesQf call TogglePyflakesQf()


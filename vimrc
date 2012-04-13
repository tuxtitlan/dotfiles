set directory=~/.tmp
set encoding=utf-8
set fileencodings=
set hidden          "Remember undo after quitting
set ls=2            "Alway show status line
set modeline        "Last lines in document sets vim mode
set modelines=3     "Number lines checked for modelines
set nobackup        "Do not keep a backup file
set nocompatible    "Use vim defaults
set nostartofline   "Don't jump to first character when paging
set novisualbell    "Turn off visual bell
set number          "Show line numbers
set ruler           "Show the cursor position all the time
set scrolloff=3     "Keep 3 lines when scrolling
set shortmess=atI   "Abbreviate messages
set showcmd         "Display incomplete commands
set sidescroll=1    "Better horizontal scrolling
set sidescrolloff=5 "Horizontal scroll offset
set visualbell t_vb=    "Turn off error beep/flash
set whichwrap=b,s,h,l,<,>,[,]   "Move freely between files

setlocal spelllang=en_us

syntax enable

try
    call pathogen#infect()
    call pathogen#helptags()
catch
endtry

"SEARCH OPTIONS
set ignorecase      "Case insensitive search
set incsearch       "Incremental search
set hlsearch        "Highlight search
set smartcase       "Case sensitive search if upper case chars are used

"INDENTATION OPTIONS
set autoindent      "Auto-indent new lines
set nocindent       "Use smartindent instead
set expandtab       "Tabs are converted to spaces
set shiftwidth=4    "Tab width for indentation
set smartindent     "Smart indentation
set tabstop=4       "Tab width

filetype plugin indent on

highlight SpellBad term=underline gui=undercurl guisp=Orange

# Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=1

# NerdTree
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']

if has('gui_running')
    set guifont=Inconsolata:h14
    set background=light
else
    set background=dark
    let g:solarized_termcolors=256
endif

try
    colorscheme solarized
catch
endtry

if has("autocmd")
    " autoindent with two spaces, always expand tabs
    autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et

    autocmd VimEnter * call Plugins()
endif


function! Plugins()

    if exists(":NERDTree")
        map <c-n> :NERDTreeToggle<CR>
        let NERDTreeIgnore=['\~$', '.pyc', '.egg-info', '.class']
    endif

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

endfunction


set directory=~/.tmp
set encoding=utf-8
set fileencodings=
set hidden          "Remember undo after quitting
set ls=2            " allways show status line
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines
set nobackup        " do not keep a backup file
set nocompatible    " use vim defaults
set nosmartindent
set nostartofline   " don't jump to first character when paging
set novisualbell    " turn off visual bell
set number          " show line numbers
set ruler           " show the cursor position all the time
set scrolloff=3     " keep 3 lines when scrolling
set shortmess=atI   " Abbreviate messages
set showcmd         " display incomplete commands
set showmatch       "Show matching bracket
set sidescroll=1    "Better horizontal scrolling
set sidescrolloff=5 "Horizontal scroll offset
set visualbell t_vb=    " turn off error beep/flash
set whichwrap=b,s,h,l,<,>,[,]   " move freely between files

setlocal spelllang=en_us

syntax enable

call pathogen#runtime_append_all_bundles()

"SEARCH OPTIONS
set ignorecase      "Case insensitive search
set incsearch       "Incremental search
set hlsearch        "Highlight search
set smartcase       "Case sensitive search if upper case chars are used

"INDENTATION OPTIONS
set autoindent      "Auto-indent new lines
set nocindent       "Use smartindent instead
set expandtab       " tabs are converted to spaces
set shiftwidth=4    "Tab width for indentation
set smartindent     "Smart indentation
set tabstop=4       "Tab width

filetype plugin indent on

highlight SpellBad term=underline gui=undercurl guisp=Orange

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


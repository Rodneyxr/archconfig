" Setup Shougo/dein.vim plugin manager
if (!isdirectory(expand('$HOME/.config/nvim/repos/github.com/Shougo/dein.vim')))
    call system(expand('mkdir -p $HOME/.config/nvim/repos/github.com'))
    call system(expand('git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim'))
endif

" Set the runtime path to include dein and initialize
set runtimepath^=~/.config/nvim/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.cache/dein'))
call dein#add('Shougo/dein.vim')
" END SETUP

"
" Plugins
" ------------------------------------------------------------------------------

" Theme
call dein#add('fatih/molokai') " colorscheme

" Tools
call dein#add('scrooloose/nerdtree') " side mounted file explorer
call dein#add('tomtom/tcomment_vim') " easy code commenting
call dein#add('vim-airline/vim-airline') " better status bar
call dein#add('christoomey/vim-tmux-navigator')

" Syntax
call dein#add('neomake/neomake') " linter
call dein#add('Valloric/MatchTagAlways', {'on_ft': 'html'}) " highlight enclosing html tags
call dein#add('fatih/vim-go') " better support for go
call dein#add('Chiel92/vim-autoformat') " format documents

" Autocomplete
call dein#add('Shougo/deoplete.nvim')
call dein#add('zchee/deoplete-clang')
call dein#add('zchee/deoplete-go', {'build': 'make'})
call dein#add('zchee/deoplete-jedi')
call dein#add('vim-scripts/Auto-Pairs')

" END PLUGINS
if dein#check_install()
    call dein#install()
    let g:pluginsExists=1
endif
call dein#end()
filetype plugin indent on
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

"
" My Config
" ------------------------------------------------------------------------------

" Settings
syntax on
set relativenumber number
set tabstop=4 shiftwidth=4 softtabstop=4 smarttab expandtab
set encoding=utf-8

" Theme
colorscheme molokai

" vim-airline
set hidden
let g:airline#extentions#tabline#enabled = 1
let g:airline#extentions#tabline#show_tab_nr = 1

" Neomake
augroup NeomakeGroup
    autocmd! BufWritePost * Neomake " run neomake when writing to file
augroup END
let g:neomake_open_list = 2 " auto open/close error list
let g:neomake_vim_enabled_makers = ['vint'] " pip3 install vint
let g:neomake_c_enabled_makers = ['gcc'] " clang avail
let g:neomake_cpp_enabled_makers = ['gcc'] " clang aval
let g:neomake_python_enabled_makers = ['python']
let g:neomake_html_enabled_makers = ['tidy'] " apt install tidy
let g:neomake_javascript_enabled_makers = ['jshint'] " npm install jshint -g
let g:neomake_css_enabled_makers = ['csslint'] " npm install csslint -g
let g:neomake_json_enabled_makers = ['jsonlint'] " npm install jsonlint -g
let g:neomake_go_enabled_makers = ['go']

let g:neomake_warning_sign = {
            \ 'text': 'W',
            \ 'texthl': 'WarningMsg',
            \ }
let g:neomake_error_sign = {
            \ 'text': '>>',
            \ 'texthl': 'ErrorMsg',
            \ }

" deoplete
let g:deoplete#enable_at_startup = 1
" tab completion
inoremap <silent><expr> <Tab> pumvisible() ? "<C-n>" : "<Tab>"
" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" deoplete-clang
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-3.8/lib/clang'

" deoplete-jedi
let g:deoplete#sources#jedi#python_path = '/usr/bin/python3'
let g:deoplete#sources#jedi#enable_cache = 1
let g:deoplete#auto_completion_start_length = 1

" deoplete-go
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:go_fmt_command = 'goimports'
let g:deoplete#sources#go = 'vim-go'

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_doc_keywordprg_enabled = 0
augroup VimGoGroup
    au FileType go nmap <leader>rt <Plug>(go-run-tab)
    au FileType go nmap <Leader>rs <Plug>(go-run-split)
    au FileType go nmap <Leader>rv <Plug>(go-run-vertical)
augroup END

" NERDTree
augroup NerdTreeGroup
    " open NERDTree if no file was specified when starting vim
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END
let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=45
let g:NERDTreeAutoDeleteBuffer=1

" save vim sessions
augroup VimSessionsGroup
    " remember cursor position between vim sessions
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                \   exe "normal! g'\"" |
                \ endif
    " center buffer around cursor when opening files
    autocmd BufRead * normal zz
augroup END

"
" Mappings
" ------------------------------------------------------------------------------

" leader is ,
let g:mapleader = ','

" just press q to quit
map q :q!<cr>
map <esc> :noh<cr>

" delete selection or current line
map <C-d> dd

" ,f to format code, requires formatters: read the docs
noremap <leader>f :Autoformat<CR>

" shortcuts for fast navigation
noremap H ^
noremap L g_
noremap J 5j
noremap K 5k
nnoremap ; :

" Ctrl-up/Ctrl-down to move lines
nnoremap <C-Down> :m .+1<CR>==
nnoremap <C-Up> :m .-2<CR>==
inoremap <C-Down> <Esc>:m .+1<CR>==gi
inoremap <C-Up> <Esc>:m .-2<CR>==gi
vnoremap <C-Down> :m '>+1<CR>gv=gv
vnoremap <C-Up> :m '<-2<CR>gv=gv

" align blocks of text and keep them selected
vmap < <gv
vmap > >gv

" comment shortcut
map <leader>c :TComment<cr>

" toggle NERDTree
map <C-\> :NERDTreeToggle<CR>

" split vertical
map <leader>l <C-w>v

" split horizontal
map <leader>j <C-w>s

tmap <leader>x <c-\><c-n>:bp! <BAR> bd! #<CR>
nmap <leader>t :term<cr>
nmap <leader>, :bnext<CR>
tmap <leader>, <C-\><C-n>:bnext<CR>
nmap <leader>. :bprevious<CR>
tmap <leader>. <C-\><C-n>:bprevious<CR>

" Navigate between vim buffers and tmux panels
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-;> :TmuxNavigatePrevious<cr>
tmap <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
tmap <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
tmap <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
tmap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
tmap <C-;> <C-\><C-n>:TmuxNavigatePrevious<cr>

" keep my term window open when I navigate away
autocmd TermOpen * set bufhidden=hide
" set terminal mode when returning to terminal buffer
autocmd BufWinEnter,WinEnter term://* startinsert
" set normal mode when leaving terminal buffer
autocmd BufLeave term://* stopinsert

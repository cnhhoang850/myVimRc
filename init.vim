set shell=/bin/bash
set filetype
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set scrolloff=3
set number
set relativenumber 
syntax enable
set cursorline
set foldcolumn=0
set linespace=8
set encoding=utf-8
set hidden
set cmdheight=2
set updatetime=300
set number

set laststatus=2
set ruler
set wildmenu
set cursorline
set noerrorbells 
set title
filetype plugin on 
filetype indent on

set so=7
syntax on

if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

"Plugin here.
call plug#begin()

"Declare list plugins.

Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'junegunn/limelight.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'mattn/emmet-vim' 
Plug 'lifepillar/gruvbox8' 
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'untitled-ai/jupyter_ascending.vim'
Plug 'szymonmaszke/vimpyter'
Plug 'bfredl/nvim-ipy'
Plug 'airblade/vim-gitgutter'
Plug 'KKPMW/vim-sendtowindow'


"List ends here. Plugins become visible.
call plug#end()

" COC
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

set updatetime=100
set shortmess+=c



" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"GruvBox
colorscheme gruvbox8
set background=dark 
let g:gruvbox_italic=1
let g:gruvbox_underline=1
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_italicize_strings=1
let g:gruvbox_improved_strings=1

" COC integration
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '=>'
let g:ale_fixers = ['eslint']
"Fix all files on save
let g:ale_fix_on_save = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
autocmd VimEnter * Limelight

"Nerd tree

nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

"Lightline
let g:lightline = {
      \ 'colorscheme': 'gruvbox8',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*FugitiveHead")?FugitiveHead():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*FugitiveHead") && ""!=FugitiveHead())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

"VIMPYTER Keymap

"autocmd Filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
"autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>
" init.vim

  
"let g:ipy_celldef = '^##' " regex for cell start and end

"nmap <silent> <leader>jqt :call jobstart("jupyter qtconsole --JupyterWidget.include_other_output=True")<Enter>
"nmap <silent> <leader>jk :IPython<Space>--existing<Space>--no-window<Enter>
"nmap <silent> <leader>jc <Plug>(IPy-RunCell)
"nmap <silent> <leader>ja <Plug>(IPy-RunAll)

" Window splits 
set splitbelow splitright 
" Remap splits navigation to just CTRL + hjkl 
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Make adjusting split size 
nnoremap <silent> <C-Left> :vertical resize +3<CR>
nnoremap <silent> <C-Right> :vertical resize -3<CR>
nnoremap <silent> <C-Up> :resize -3<CR>
nnoremap <silent> <C-Down> :resize +3<CR>
" Change dimension
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K
" Start terminals for R and Python sess
map <Leader>tr :new term://bash<CR>iR<CR><C-\><C-n><C-w>k
map <Leader>tp :new term://bash<CR>ipython3<CR><C-\><C-n><C-w>k


"-----Vim Plug auto install-----"
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"-----Plugin-----"
call plug#begin(stdpath('data') . '/plugged')

Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons', { 'on': 'NERDTreeToggle' }
Plug 'cohama/lexima.vim'
Plug 'octol/vim-cpp-enhanced-highlight'

call plug#end()


"-----Plugin Setting-----"
colorscheme gruvbox
let g:lightline = {
\ 'colorscheme': 'gruvbox',
\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
\ 'active': { 'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ] }
\ }
let g:indentLine_color_term = 238
let g:indentLine_char = '│' "use ¦, ┆ or │
map <C-n> :NERDTreeToggle<CR>

if executable('clangd')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'allowlist': ['cpp'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


"--------Vim Setting--------"
"Search
set ignorecase "検索するときに大文字小文字を区別しない
set smartcase "小文字で検索すると大文字と小文字を無視して検索
set incsearch "インクリメンタル検索 (検索ワードの最初の文字を入力した時点で検索が開始)
set hlsearch "検索結果をハイライト表示
set nofoldenable "検索にマッチした行以外を折りたたむ(フォールドする)機能

"Hightlight and Colors
syntax on "シンタックスハイライト
set background=dark "背景を暗くする
set cursorline "カーソルのある行を強調表示
set showmatch matchtime=1 "対応する括弧やブレースを表示

"View
set title "タイトルを表示
set number "行番号の表示
set relativenumber "行番号を動的表示
set showcmd "ウィンドウの右下にまだ実行していない入力中のコマンドを表示
set display=lastline "省略されずに表示
set list "タブ文字を CTRL-I で表示し、行末に $ で表示する
set listchars=tab:»\ ,trail:~,space:･,eol:↲,extends:»,precedes:«,nbsp:% "行末のスペースを可視化
augroup HighlightTrailingSpaces "行末のスペースを可視化
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END
augroup TransparentBG "背景透過
  autocmd!
  autocmd Colorscheme * highlight Normal ctermbg=NONE guibg=NONE
augroup END

"Edit
set expandtab "入力モードでTabキー押下時に半角スペースを挿入
set shiftwidth=2 "インデント幅
set softtabstop=2 "タブキー押下時に挿入される文字幅を指定
set tabstop=2 "ファイル内にあるタブ文字の表示幅
set autoindent "インデントを揃える
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
function! s:clang_format() "Cpp/Hppファイルをclang-formatで自動整形
  let now_line = line(".")
  exec ":%! clang-format"
  exec ":" . now_line
endfunction
if executable('clang-format')
  augroup cpp_clang_format
    autocmd!
    autocmd BufWrite,FileWritePre,FileAppendPre *.[ch]pp call s:clang_format()
  augroup END
endif

"File
set noswapfile "スワップファイルを作成しない
set nowritebackup "ファイルを上書きする前にバックアップを作ることを無効化
set nobackup

"Complete
set completeopt=menuone,noinsert "補完

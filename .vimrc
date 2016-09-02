scriptencoding utf-8

"諸々の設定
filetype plugin indent on
set number
" set relativenumber
set title
set showmatch
set tabstop=4
set smartindent
set shiftwidth=4
set noexpandtab
syntax on
set fileformats=unix,dos,mac
set ignorecase
set smartcase
set wrapscan
set nrformats-=octal
set nrformats+=alpha
augroup vimrcEx
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
augroup END
set whichwrap=b,s,<,>,[,]
" colorscheme darkblue


"他の設定
set mouse=a                        " 全モードでマウスを有効化
set formatoptions+=mM              " 整形オプションにマルチバイト系を追加
set clipboard=unnamedplus,unnamed  " クリップボードを使用
set clipboard+=unnamedplus,unnamed " クリップボードを使用
" set ambiwidth=double               " □とか○の文字があってもカーソル位置がずれないようにする？
set autoindent                     " オートインデント
set cindent                        " C プログラムの自動インデン
set expandtab                      "ソフトタブ(タブ文字の代わりにスペースをいれる)ソフトタブを有効にする
au FileType ruby setlocal expandtab "Ruby用


set backspace=indent,eol,start
" オートインデント、改行、インサートモード開始直後にバックスペースキーで削除できるようにする
set tabstop=4                       " タブ幅
set shiftwidth=4                    " インデントの幅
set softtabstop=4                   " Tab キー押下時に挿入される空白の量
au FileType ruby setlocal ts=2 sw=2 " Rubyスクリプトではインデントをスペース2個にする
filetype indent on                  " ファイルタイプに合わせたインデントを利用する
set undofile                        " Undo履歴をファイルに保存する
set undodir=$HOME/.vim/undodir

set showmatch                       " 括弧の対応をハイライト
" set hlsearch                        " 検索結果をハイライト
set title                           " ウィンドウのタイトルを書き換える
set showmode                        " 現在のモードを表示
set showcmd
set laststatus=2                    " ステータスラインを常に表示する
set encoding=utf-8
set t_ut=                           " tmux環境での背景描画の対策

set list
" set listchars=tab:»\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set listchars=tab:»\ ,trail:\ ,eol:↲,extends:»,precedes:«,nbsp:%
hi SpecialKey guibg=NONE guifg=Gray40
hi NonText guibg=NONE guifg=DarkGreen

set cursorline
" set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y%{fugitive#statusline()}\ %f%=%l,%c%V%8P

" 全角スペースのハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=grey gui=reverse guifg=DarkMagenta
endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

" 最後のカーソル位置を復元する
if has("autocmd")
     autocmd BufReadPost *
         \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif


"コピペ時に自動コメント挿入をさせない
"auto comment off
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END



" 補完
"--------------------------------------------------------
set wildmenu          " コマンドラインモードでの補完を有効に
set wildchar=<tab>    " コマンド補完を開始するキー
set history=1000      " コマンド・検索パターンの履歴数
set wildmode=list:longest,full
set completeopt=menu,preview,menuone
set completeopt=menuone
" set tags=~/.vim/systags,./tags,../tags,./*/tags,~/.tags/*/tags
set tags=./tags;~/.vim/systags,./*/tags,~/.tags/*/tags


"<TAB>で補完(Tabを押した時に、空行ならTab、違ければ補完)
" {{{ Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<TAB>"
    else
        return "\<C-N>"
    endif
endfunction
" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" }}} Autocompletion using the TAB key


" キーバインド変更
"--------------------------------------------------------

nmap j gj
nmap k gk
map  <c-h> <Left>
imap <c-h> <Left>
map  <c-j> <Down>
imap <c-j> <Down>
map  <c-k> <Up>
imap <c-k> <Up>
map  <c-l> <Right>
imap <c-l> <Right>
map  <c-f> f
imap <c-f> <Esc>f
map  <C-a>  ^
imap <C-a> <esc>^i
map  <C-e> <End>
imap <C-e> <End>
map  <C-s> <Esc>:w<CR>
imap <C-s> <Esc>:w<CR>a
map  <C-q> <Esc>:q<CR>
imap <C-q> <Esc>:q<CR>a
" imap <C-X> <Esc>dda
map  <C-z> g-
imap <C-z> <Esc>g-i
imap <C-r> <Esc><C-r>i
nnoremap <C-]> g<C-]>
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>

" 範囲指定 Shift左右で範囲指定開始、Shift上下で行指定開始
nmap <S-Up>    V
nmap <S-Down>  V
nmap <S-Left>  v<Left>
nmap <S-Right> v<Right>

imap <S-Up>    <Esc>V
imap <S-Down>  <Esc>V
imap <S-Left>  <Esc>v<Left>
imap <S-Right> <Esc>v<Right>

vmap <S-Up>    <Up>
vmap <S-Down>  <Down>
vmap <S-Left>  <Left>
vmap <S-Right> <Right>

" 空行のインデントを維持
nnoremap o oX<C-h>
nnoremap O OX<C-h>
inoremap <CR> <CR>X<C-h>

" 分割画面の移動
nnoremap s <Nop>
nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap s<Left> <C-w>h
nnoremap s<Down> <C-w>j
nnoremap s<Up> <C-w>k
nnoremap s<Right> <C-w>l
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap s- :<C-u>sp<CR>
nnoremap s\| :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>


" NeoBundle
"--------------------------------------------------------
" インストール方法
" curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
" sh ./install.sh
" rm -rf install.sh

" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'
" 今後このあたりに追加のプラグインをどんどん書いて行きます！！"


NeoBundle 'tomtom/tcomment_vim'   " コメントON/OFFをCtrl+- x2で実行
NeoBundle 'tpope/vim-endwise'     " Rubyでendを自動補完
NeoBundle 'Yggdroot/indentLine'     "インデント自動色分け
    let g:indentLine_color_term = 239
    " let g:indentLine_char = '￤'

" NeoBundle 'tpope/vim-surround'    " 囲み文字を対象にするテキストオブジェクト(s)を追加するプラグイン
    " ys[範囲][記号] -> 記号で範囲を囲む cs[記号] -> 記号を置換  ds[記号] -> 記号を削除   S[記号] -> 選択範囲を記号で囲む

NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-fugitive'    " ステータスラインにブランチ名を入れるために入れる

NeoBundle 'alpaca-tc/alpaca_powertabline'
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
NeoBundle 'Lokaltog/powerline-fontpatcher'
NeoBundle 'Lokaltog/vim-powerline'
" NeoBundle 'itchyny/lightline.vim'
" let g:lightline = {
"       \ 'colorscheme': 'wombat',
"       \ 'component': { 'readonly': '%{&readonly?"":""}',},
"       \ 'separator': { 'left': '', 'right': '' },
"       \ 'subseparator': { 'left': '', 'right': '' }
"       \ }

NeoBundle "osyo-manga/vim-brightest"
    let g:brightest#highlight = {"group" : "BrightestUnderline"}
    let g:brightest#highlight_in_cursorline = {"group" : "BrightestNONE"}
    let g:brightest#pattern = '\k\+'

" NeoBundle 'Lokaltog/vim-easymotion'  "2キーで移動
"     nmap s <Plug>(easymotion-s2)
"     xmap s <Plug>(easymotion-s2)

NeoBundle 'LeafCage/yankround.vim'
    nmap p <Plug>(yankround-p)
    nmap P <Plug>(yankround-P)
    nmap gp <Plug>(yankround-gp)
    nmap gP <Plug>(yankround-gP)
    nmap <C-p> <Plug>(yankround-prev)
    nmap <C-n> <Plug>(yankround-next)
    let g:yankround_use_region_hl = 0     " 貼り付けた時にハイライトするか
    autocmd ColorScheme *   call s:define_region_hl()
    function! s:define_region_hl()
        highlight default YankRoundRegion   guibg=Brown ctermbg=Brown term=reverse
    endfunction

NeoBundle 'sjl/gundo.vim'
    nnoremap u g-
    nnoremap <C-r> g+
    nmap U :GundoToggle<CR>


" " sudo apt-get install clang-3.5
" " sudo apt-get install clang-format-3.5
" NeoBundle 'Shougo/neocomplete.vim'
"     " 'Shougo/neocomplete.vim' {{{
"     let g:neocomplete#enable_at_startup = 1
"     if !exists('g:neocomplete#force_omni_input_patterns')
"             let g:neocomplete#force_omni_input_patterns = {}
"     endif
"     let g:neocomplete#force_overwrite_completefunc = 1
"     let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"     let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"     "}}}
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \ 'windows' : 'make -f make_mingw32.mak',
            \ 'cygwin' : 'make -f make_cygwin.mak',
            \ 'mac' : 'make -f make_mac.mak',
            \ 'unix' : 'make -f make_unix.mak',
            \ },
            \ }
NeoBundle 'Shougo/neoinclude.vim'
NeoBundle 'justmao945/vim-clang'
    " 'justmao945/vim-clang' {{{
    " disable auto completion for vim-clanG
    let g:clang_auto = 0
    let g:clang_complete_auto = 0
    let g:clang_auto_select = 0
    let g:clang_use_library = 1
    " default 'longest' can not work with neocomplete
    let g:clang_c_completeopt   = 'menuone'
    let g:clang_cpp_completeopt = 'menuone'
    if executable('clang-3.6')
        let g:clang_exec = 'clang-3.6'
    elseif executable('clang-3.5')
        let g:clang_exec = 'clang-3.5'
    elseif executable('clang-3.4')
        let g:clang_exec = 'clang-3.4'
    else
        let g:clang_exec = 'clang'
    endif
    if executable('clang-format-3.6')
        let g:clang_format_exec = 'clang-format-3.6'
    elseif executable('clang-format-3.5')
        let g:clang_format_exec = 'clang-format-3.5'
    elseif executable('clang-format-3.4')
        let g:clang_format_exec = 'clang-format-3.4'
    else
        let g:clang_exec = 'clang-format'
    endif

    let g:clang_c_options = '-std=c1y'
    let g:clang_cpp_options = '-std=c++1y -stdlib=libc++'
    " }}}



call neobundle#end()
" 未インストールのプラグインのインストール確認
NeoBundleCheck
" End Neobundle Settings.
"-------------------------


filetype plugin indent on


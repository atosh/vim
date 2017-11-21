set encoding=utf-8
scriptencoding utf-8
" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

"" 文字コードの設定

" 保存時の文字コード
set fileencoding=utf-8
" 読み込み時の文字コードを自動判別する. 左側が優先される.
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
" 改行コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac
" 特定の全角文字(○とか□とか)が崩れる問題を解決する.
set ambiwidth=double

"" 不可視文字の設定

" タブ入力を半角空白に置き換える.
set expandtab
" 画面上でタブ文字が占める幅
set tabstop=4
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4
" 改行時に前の行のインデントを継続する.
set autoindent
" 改行時に前の行の公文をチェックし次の行のインデントを増減する.
set smartindent
" smartindent で増減する幅
set shiftwidth=4
" 不可視文字を表示する.
set list
" 不可視文字を何で表示するか設定する.
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
" 全角スペースをハイライト表示する.
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

"" 構文

" シンタックスハイライトを有効化する.
syntax on
" C のインデントスタイル
set cindent
"c++のアクセス指定子はインデントしない
set cinoptions+=g0,N-s

"" 文字列検索
" インクリメンタルサーチ. 1文字入力ごとに検索を行う.
set incsearch
" 検索パターンに大文字小文字を区別しない
"set ignorecase
" 検索パターンに大文字を含んでいたら大文字小文字を区別する.
"set smartcase
" 検索結果をハイライトする.
set hlsearch
" エスケープキー連打でハイライトを消す.
"nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

"" カーソル
" カーソルの左右移動で行末から次の行の行頭へ移動する.~
"set whichwrap=b,s,h,l,<,>,[,,]
" 行番号を表示
set number
" カーソルラインをハイライト
" set cursorline

" 行が折り返し表示されていた場合,
" 行単位ではなく表示行単位でカーソルを移動する.
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" 折り返しを表示する.
set showbreak=↪

" バックスペースを有効化する.
set backspace=indent,eol,start

"" カッコ, タグジャンプ
" カッコの対応関係を一瞬表示する.
set showmatch
" Vim の '%' を拡張する.
source $VIMRUNTIME/macros/matchit.vim

"" コマンド補完
" コマンドモードでコマンドを補完する.
set wildmenu
" 保存するコマンド履歴の数
set history=5000
" クリップボードの内容を無名レジスタに関連付ける.
set clipboard+=unnamed
" バックアップファイルを無効化する
set nowritebackup
set nobackup
" swap ファイルを無効化する
set noswapfile
" set directory=~/.vim/tmp
" buffer切替時に保存する? => NO
set hidden

"" NeoBundle の設定

if has('vim_starting')
    " 初回起動時のみruntimepathにNeoBundleのパスを指定する
    set runtimepath+=~/.vim/bundle/neobundle.vim/

    " NeoBundleが未インストールであればgit cloneする
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install NeoBundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" add plugins here --------

" plantUML プラグイン
NeoBundle 'aklt/plantuml-syntax'

" 末尾の全角と半角の空白文字を赤くハイライト
NeoBundle 'bronson/vim-trailing-whitespace'
" インデントの可視化
"NeoBundle 'Yggdroot/indentLine'
NeoBundle 'nathanaelkane/vim-indent-guides'

" GUI カラースキームを使えるようにする
" NeoBundle 'thinca/vim-guicolorscheme'
" カラースキームmolokai
NeoBundle 'tomasr/molokai'
" カラースキーム Dusk
NeoBundle 'jaapie/vim-colours-dusk'
" カラースキーム badwolf
NeoBundle 'sjl/badwolf'

" ステータスラインの表示内容強化
NeoBundle 'itchyny/lightline.vim'
set laststatus=2  " ステータスラインを常に表示
set showmode  " 現在のモードを表示
set showcmd  " 打ったコマンドをステータスラインの下に表示
set ruler  " ステータスラインの右側にカーソルの現在位置を表示する

" 自動で { や ' を閉じる
NeoBundle 'cohama/lexima.vim'

" キャメルケース/スネークケース変換
NeoBundle 'tpope/vim-abolish'

" ファイルテンプレート
NeoBundle "thinca/vim-template"

" 変更行にマーク
if !has('gui_running') && has('unix') && !has('win32unix')
    NeoBundle 'leftouterjoin/changed'
endif

if has('lua')
    " コードの自動補完
    NeoBundle 'Shougo/neocomplete.vim'
    " スニペットの補完機能
    NeoBundle 'Shougo/neosnippet'
    " スニペット集
    NeoBundle 'Shougo/neosnippet-snippets'
endif

" gtags
NeoBundle 'vim-scripts/gtags.vim'

" vim-submode
NeoBundle 'kana/vim-submode'

" -------- end add plugins

call neobundle#end()

" ファイルタイプ別の Vim プラグイン/インデントを有効にする.
filetype plugin indent on

" 未インストールの Vim プラグインがある場合, インストールするか確認する.
NeoBundleCheck

"" indent-guides の設定
" 起動時に有効化する.
let g:indent_guides_enable_on_vim_startup = 1
" 1列目だけハイライトする.
let g:indent_guides_guide_size = 1
" opacity を調整する.
"let g:indent_guides_color_change_percent = 30
" 2段目からガイドする.
let g:indent_guides_start_level = 2
if !has('win32unix')
    "" neocomplete/neosnippet の設定
    " Vim起動時にneocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 3
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " ユーザー定義スニペット置き場
    let g:neosnippet#snippets_directory = '~/.vim/snippets'
    " キーマッピング定義
    imap <C-k><C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k><C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k><C-k> <Plug>(neosnippet_expand_target)
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"
    " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#expandable_or_jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif

"" clang-format の設定
" 現在行または選択範囲をフォーマットする.
map <C-k><C-f> :pyf ~/bin/clang-format.py<CR>
" バッファ全体をフォーマットする.
nmap <C-k><C-d> mZggVG<C-k><C-f>`Z
" フォーマットファイルを指定
if $CLANG_FORMAT_FILE != ""
  let g:clang_format_path_to_config_file = $CLANG_FORMAT_FILE
endif

" :GuiColorScheme Dusk
colorscheme molokai
set t_Co=256  " iTerm2など既に256色環境なら無くても良い

let s:dir = getcwd()
let s:ans = findfile(".private.vim", fnameescape(s:dir) . ";")

if len(s:ans) > 1
    let s:rc = fnamemodify(s:ans, ":p:h") . "/.vimrc"
    call feedkeys(":source " . s:rc . "\<cr>")
endif

" テンプレート中に含まれる特定文字列を置き換える
autocmd MyAutoCmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
    silent! %s#<+DATE+>#\=strftime('%Y/%m/%d')#g
    silent! %s#<+YEAR+>#\=strftime('%Y')#g
    silent! %s/<+FILENAME+>/\=expand('%:t')/g
    silent! %s/<+AUTHOR+>/\=expand($AUTHOR)/g
    silent! %s/<+ORGANIZATION+>/\=expand($ORGANIZATION)/g
    silent! %s/<+INCLUDEGUARD+>/\=toupper(expand($NAMESPACE).'_'.expand('%:gs?[\/\.\\]?_?').'_')/g
endfunction
" テンプレート中に含まれる'<+CURSOR+>'にカーソルを移動
autocmd MyAutoCmd User plugin-template-loaded
    \   if search('<+CURSOR+>')
    \ |   silent! execute 'normal! "_da>'
    \ | endif

" gtags の設定
map <C-h> :Gtags -f %<CR>
map <C-j> :GtagsCursor<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>

" 画面分割の設定
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

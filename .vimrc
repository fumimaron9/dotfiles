let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME




if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'junegunn/fzf.vim'
call plug#end()

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }



"""""""""""""""""""""""""""""""""""""""""""""""""
" configuration
"""""""""""""""""""""""""""""""""""""""""""""""""

" viminfo change location
set viminfo+=n~/.viminfo

""""" filetype
filetype plugin indent on

" 使用するshellを設定
set shell=$SHELL

" インサートモード時にバックスペースを使う
set backspace=indent,eol,start

""""" encode & line
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,default,latin
set ffs=unix,dos,mac

""""" タブとインデント
set noexpandtab
set tabstop=4
set softtabstop=4 "equal tabstop
set shiftwidth=4 "equal tabstop

""""" タブとインデント
set expandtab
set tabstop=2
set softtabstop=2 "equal tabstop
set shiftwidth=2 "equal tabstop

""""" 単語
set iskeyword+=-,@-@





"set noautoindent
set autoindent
"set nosmartindent
set smartindent
"set nocindent
"set cindent
"set indentexpr=''


""""" ステータス行
"set laststatus=1
set laststatus=2


""""" colorscheme
set termguicolors
set background=light
colorscheme solarized8



""""" 構文ハイライト
syntax enable

"set cursorline
"highlight CursorLine ctermbg=Black
"highlight CursorLine ctermfg=Blue
"set cursorcolumn
"highlight CursorColumn ctermbg=Blue
"highlight CursorColumn ctermfg=Green

" 重いときに括弧のハイライトを削除
"let loaded_matchparen = 1


""""" 折りたたみの設定
if (v:version > 703)
  set nofoldenable
endif
"set foldmethod=manual
"set foldlevel=1
"set foldnestmax=2


""""" 見えない文字を視覚化
set list
set nolist



""""" 行番号＆行線
set number
"set nonumber
set ruler

set textwidth=120
set formatoptions=q
set colorcolumn=+1

""""" 行の折り返し
"set wrap
set nowrap
"set guioptions+=b



""""" bom
set nobomb


""""" 文字コードと改行コード
"set encoding=utf-8
set fileencodings=utf-8,cp932,shift-jis,euc-jp,iso-2022-jp
set fileformats=unix,dos


""""" clipbord
set clipboard=unnamed


""""" search
set hlsearch " 検索結果強調-:nohで解除
set incsearch " インクリメンタルサーチを有効


" screenでvimホイール有効化
" マウス有効化
if has('mouse')
  set mouse=a
  set ttymouse=xterm2
endif


" スワップを作らない
"set noswapfile


" バックアップを取らない
set nobackup


" カーソルを行頭、行末でとまらないようにする
set whichwrap=b,s,h,s,<,>,[,]


" escの反応を素早くする
set timeout timeoutlen=1000 ttimeoutlen=75


" vimコマンド補完の強化
set wildmenu
set wildmode=list:full


"""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd
"""""""""""""""""""""""""""""""""""""""""""""""""

""""" session
augroup SessionManage
  if argc() == 0 && !&readonly
    let s:last_session = s:cache_home . '/session.vim'

    autocmd VimLeave *
    \ if &ft != 'git' && &ft != 'gitcommit' |
    \   exe 'mksession! ' . s:last_session |
    \ endif

    if filereadable(s:last_session)
      autocmd VimEnter * nested
      \ if &ft != 'git' && &ft != 'gitcommit' |
      \   exe 'source ' . s:last_session |
      \ endif
    endif
  endif
augroup END

" help
"set keywordprg=:help " Open Vim internal help by K command

" 貼り付け時のコメントでるのを改善
autocmd FileType * set formatoptions-=ro

" insetモードから抜けるときにnopaste
autocmd InsertLeave * set nopaste

" for webpack --watch
autocmd BufNewFile,BufReadPre *.js set backupcopy=yes


"""""""""""""""""""""""""""""""""""""""""""""""""
" key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""
" check filetype
" :verbose :setlocal filetype?

" default mapping check
" :help index.txt

" user mapping check
" :map or :nmap or :vap :vervose nmap ...

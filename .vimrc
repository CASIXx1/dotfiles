" IMEを自然にオフ
if has('mac')
  set ttimeoutlen=1
  let g:imeoff = 'osascript -e "tell application \"System Events\" to key code 102"'
  augroup MyIMEGroup
    autocmd!
    autocmd InsertLeave * :call system(g:imeoff)
  augroup END
  noremap <silent> <ESC> <ESC>:call system(g:imeoff)<CR>
  inoremap <silent> <C-j> <ESC>:call system(g:imeoff)<CR>
endif

" Undo履歴をファイルに保存
set undodir=$HOME/.vim/undodir
set undofile

" 文字列を折り返す
"set nowrap

" 検索結果をハイライト
set hlsearch

" 小文字大文字無視で検索
set ignorecase
set smartcase

" インデント設定
set autoindent

" カーソルが何行目の何列目に置かれているかを表示
set ruler
" 行番号表示
set number
"不可視文字を可視化
set listchars=tab:»-,trail:-,nbsp:%,eol:↲
cnoremap l :set list

" 保管機能
set wildmode=list:longest,full
" コマンド可視化
set showcmd

" Tab設定
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
"set smarttab

"set clipboard=unnamed
set clipboard=unnamed
"filetype plugin indent on
"syntax enable

"if &compatible
"  set nocompatible               " Be iMproved
"endif

" Required:
set runtimepath+=/Users/horikawayouyuu/.cache/dein/repos/github.com/Shougo/dein.vim
  
" Required:
if dein#load_state('/Users/horikawayouyuu/.cache/dein')
  call dein#begin('/Users/horikawayouyuu/.cache/dein')
  
  " Let dein manage dein
  " Required:
  call dein#add('/Users/horikawayouyuu/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('mattn/emmet-vim')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " PHP "
"  call dein#add('Shougo/neocomplete.vim')
"  call dein#add('violetyk/neocomplete-php.vim')
  call dein#add('Shougo/neocomplcache')

  " nerdTree "
  call dein#add('scrooloose/nerdtree')

  " Vim-rails "
  call dein#add('tpope/vim-rails')

  " rubocop
  call dein#add('scrooloose/syntastic.git')

  " git
  call dein#add('tpope/vim-fugitive')

  " 日本語ヘルプ
  call dein#add('vim-jp/vimdoc-ja')

  " IDE化
  call dein#add('Shougo/unite.vim')
  call dein#add('vim-scripts/taglist.vim')

  " 日本語入力系
  " call dein#add('tyru/eskk.vim')
  " call dein#add('fuenor/im_control.vim')

  " コメント系
  call dein#add('tomtom/tcomment_vim')

  " 検索系
  " :Unite file_mruを使えるように
  call dein#add('Shougo/neomru.vim')
  call dein#add('rking/ag.vim')
  call dein#add('vim-scripts/vimgrep.vim')
  "call dein#add('ngmy/vim-rubocop')
  
  " Shell
  " call dein#add('Shougo/vimshell')
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})
  call dein#add('thinca/vim-quickrun')

  " Markdown
  call dein#add('AtsushiSakai/myvim')
  call dein#add('kannokanno/previm')

  " Required:
  call dein#end()
  call dein#save_state()
endif
  
" Required:
filetype plugin indent on
syntax enable
 
" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

let g:user_emmet_leader_key = '<C-E>'

"neocompleteの設定
"autocmd FileType php,ctp :set dictionary=~/.vim/dictionaries/php.dict


" autocmd FileType php,ctp :set dictionary=~/.vim/dict/php.dict

" 引数なしで実行したとき、NERDTreeを実行する
let file_name = expand("%:p")
if has('vim_starting') &&  file_name == ""
  autocmd VimEnter * call ExecuteNERDTree()
endif

" カーソルが外れているときは自動的にnerdtreeを隠す
function! ExecuteNERDTree()
  "b:nerdstatus = 1 : NERDTree 表示中
  "b:nerdstatus = 2 : NERDTree 非表示中

  if !exists('g:nerdstatus')
    execute 'NERDTree ./'
      let g:windowWidth = winwidth(winnr())
      let g:nerdtreebuf = bufnr('')
      let g:nerdstatus = 1

    elseif g:nerdstatus == 1
      execute 'wincmd t'
      execute 'vertical resize' 0
      execute 'wincmd p'
      let g:nerdstatus = 2
    elseif g:nerdstatus == 2
      execute 'wincmd t'
      execute 'vertical resize' g:windowWidth
      let g:nerdstatus = 1

    endif
endfunction
noremap <c-e> :<c-u>:call ExecuteNERDTree()<cr>
"</cr></c-u></c-e>

"ハイライト解除のmapping
nnoremap <F3> :noh<CR>

autocmd BufRead *.php\|*.ctp\|*.tpl :set dictionary=~/.vim/dictionary/php.dict filetype=php
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_manual_completion_start_length = 0
let g:neocomplcache_caching_percent_in_statusline = 1
let g:neocomplcache_enable_skip_completion = 1
let g:neocomplcache_skip_input_time = '0.5'

" rubocop
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

"execute pathogen#infect()
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" ruby
let g:neocomplete#sources#dictionary#dictionaries = {
\   'ruby': $HOME . '/dicts/ruby.dict',
\ }

"------------------------------------
" vim-rails
"------------------------------------
""{{{
"有効化
let g:rails_default_file='config/database.yml'
let g:rails_level = 4
let g:rails_mappings=1
let g:rails_modelines=0
" let g:rails_some_option = 1
" let g:rails_statusline = 1
" let g:rails_subversion=0
" let g:rails_syntax = 1
" let g:rails_url='http://localhost:3000'
" let g:rails_ctags_arguments='--languages=-javascript'
" let g:rails_ctags_arguments = ''
function! SetUpRailsSetting()
  nnoremap <buffer><Space>r :R<CR>
  nnoremap <buffer><Space>a :A<CR>
  nnoremap <buffer><Space>m :Rmodel<Space>
  nnoremap <buffer><Space>c :Rcontroller<Space>
  nnoremap <buffer><Space>v :Rview<Space>
  nnoremap <buffer><Space>p :Rpreview<CR>
endfunction

aug MyAutoCmd
  au User Rails call SetUpRailsSetting()
aug END

aug RailsDictSetting
  au!
aug END
"}}}

let g:eskk#large_dictionary = {
  \ 'path': $HOME . "/SKK-JISYO.L",
  \ 'sorted': 1,
  \ 'encoding': 'euc-jp',
  \}

let g:eskk#enable_completion = 1
let g:eskk#egg_like_newline = 1

"------------------------------------
" Tab機能
"------------------------------------
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>

" Unite
" let mapleader = "\<Space>"
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> ,uk :<C-u>Unite bookmark<CR>

" Taglist
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_Show_One_File = 1                
let Tlist_Use_Right_Window = 1            
let Tlist_Exit_OnlyWindow = 1            
map <silent> <leader>l :TlistToggle<CR>      
" \lでtaglistウインドウを開いたり閉じたり出来るショートカット

" fugitive
" Statuslineの設定
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ \[ENC=%{&fileencoding}]%P

" VimShell
" ,is: シェルを起動
nnoremap <silent> ,vs :VimShell<CR>
" ,ipy: pythonを非同期で起動
nnoremap <silent> ,ipy :VimShellInteractive python<CR>
" ,irb: irbを非同期で起動
nnoremap <silent> ,irb :VimShellInteractive irb<CR>
" ,ss: 非同期で開いたインタプリタに現在の行を評価させる
vmap <silent> ,ss :VimShellSendString<CR>
" 選択中に,ss: 非同期で開いたインタプリタに選択行を評価させる
nnoremap <silent> ,ss <S-v>:VimShellSendString<CR>

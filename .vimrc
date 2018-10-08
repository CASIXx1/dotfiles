" dein読み込み
:source ~/.vimrc.dein_load

" 基本設定読み込み
:source ~/.vimrc.basic

" nerdtree設定読み込み
:source ~/.vimrc.nerdtree

let g:user_emmet_leader_key = '<C-E>'
"neocompleteの設定
"autocmd FileType php,ctp :set dictionary=~/.vim/dictionaries/php.dict
"autocmd FileType php,ctp :set dictionary=~/.vim/dict/php.dict

"ハイライト解除のmapping
nnoremap <F3> :noh<CR>

" autocmd BufRead *.php\|*.ctp\|*.tpl :set dictionary=~/.vim/dictionary/php.dict filetype=php
" let g:neocomplcache_enable_at_startup = 1
" let g:neocomplcache_enable_camel_case_completion = 1
" let g:neocomplcache_enable_underbar_completion = 1
" let g:neocomplcache_smart_case = 1
" let g:neocomplcache_min_syntax_length = 3
" let g:neocomplcache_manual_completion_start_length = 0
" let g:neocomplcache_caching_percent_in_statusline = 1
" let g:neocomplcache_enable_skip_completion = 1
" let g:neocomplcache_skip_input_time = '0.5'

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
" let g:neocomplete#sources#dictionary#dictionaries = {
" \   'ruby': $HOME . '/dicts/ruby.dict',
" \ }

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

" 謎の設定...
" aug MyAutoCmd
"   au User Rails call SetUpRailsSetting()
" aug END

" aug RailsDictSetting
"   au!
" aug END
"}}}

" eskk周りの設定
" let g:eskk#large_dictionary = {
"   \ 'path': $HOME . "/SKK-JISYO.L",
"   \ 'sorted': 1,
"   \ 'encoding': 'euc-jp',
"   \}
"
" let g:eskk#enable_completion = 1
" let g:eskk#egg_like_newline = 1

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
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
nnoremap <C-n> gt
nnoremap <C-p> gT

" denite
nnoremap [denite] <Nop>
nmap <C-c> [denite]

"現在開いているファイルのディレクトリ下のファイル一覧。
nnoremap <silent> [denite]f :<C-u>DeniteBufferDir
      \ -direction=topleft -cursor-wrap=true file file:new<CR>
"バッファ一覧
nnoremap <silent> [denite]b :<C-u>Denite -direction=topleft -cursor-wrap=true buffer<CR>
"レジスタ一覧
nnoremap <silent> [denite]r :<C-u>Denite -direction=topleft -cursor-wrap=true -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [denite]m :<C-u>Denite -direction=topleft -cursor-wrap=true file_mru<CR>
"ブックマーク一覧
nnoremap <silent> [denite]c :<C-u>Denite -direction=topleft -cursor-wrap=true bookmark<CR>
"ブックマークに追加
nnoremap <silent> [denite]a :<C-u>DeniteBookmarkAdd<CR>

".git以下のディレクトリ検索
nnoremap <silent> [denite]k :<C-u>Denite -direction=topleft -cursor-wrap=true
      \ -path=`substitute(finddir('.git', './;'), '.git', '', 'g')`
      \ file_rec/git<CR>

call denite#custom#source('file'    , 'matchers', ['matcher_cpsm', 'matcher_fuzzy'])

call denite#custom#source('buffer'  , 'matchers', ['matcher_regexp'])
call denite#custom#source('file_mru', 'matchers', ['matcher_regexp'])

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
  \ ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#map('insert', '<C-N>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-P>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-W>', '<denite:move_up_path>', 'noremap')

call denite#custom#var('file_rec', 'command',
      \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#var('grep', 'separator', [])
call denite#custom#var('grep', 'default_opts',
      \ ['--nocolor', '--nogroup'])

" Unite
" let mapleader = "\<Space>"
" nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
" nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
" nnoremap <silent> ,uk :<C-u>Unite bookmark<CR>
" nnoremap <silent> ,e  :<C-u>Unite file_rec/async:!<CR>

" denite-rails
let mapleader = "\<Space>"
nnoremap [rails] <Nop>
nmap     <Leader>d [rails]
nnoremap [rails]r :Denite<Space>rails:
nnoremap <silent> [rails]r :<C-u>Denite<Space>rails:dwim<Return>
nnoremap <silent> [rails]m :<C-u>Denite<Space>rails:model<Return>
nnoremap <silent> [rails]c :<C-u>Denite<Space>rails:controller<Return>
nnoremap <silent> [rails]v :<C-u>Denite<Space>rails:view<Return>
nnoremap <silent> [rails]h :<C-u>Denite<Space>rails:helper<Return>
nnoremap <silent> [rails]r :<C-u>Denite<Space>rails:test<Return>
nnoremap <silent> [rails]s :<C-u>Denite<Space>rails:spec<Return>


" Taglist
" let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
" let Tlist_Show_One_File = 1
" let Tlist_Use_Right_Window = 1
" let Tlist_Exit_OnlyWindow = 1
" \lでtaglistウインドウを開いたり閉じたり出来るショートカット

" Tagbar
map <silent> <leader>t :TagbarToggle<CR>

" fugitive
" Statuslineの設定
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ \[ENC=%{&fileencoding}]%P

" VimShell
" ,vs: シェルを起動
nnoremap <silent> ,vs :VimShell<CR>
" ,vsp: シェルを起動
nnoremap <silent> ,vp :VimShellPop<CR>
" ,ipy: pythonを非同期で起動
nnoremap <silent> ,ipy :VimShellInteractive python<CR>
" ,irb: irbを非同期で起動
nnoremap <silent> ,irb :VimShellInteractive irb<CR>
" ,ss: 非同期で開いたインタプリタに現在の行を評価させる
vmap <silent> ,ss :VimShellSendString<CR>
" 選択中に,ss: 非同期で開いたインタプリタに選択行を評価させる
nnoremap <silent> ,ss <S-v>:VimShellSendString<CR>
" 現在のディレクトリを表示する
let g:vimshell_prompt_expr = 'getcwd()." > "'
let g:vimshell_prompt_pattern = '^\f\+ > '

" markdown設定
au BufRead,BufNewFile *.md set filetype=markdown

" statusline設定
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

" augroup AutoSyntastic
"   autocmd!
"   autocmd BufWritePost *.c,*.cpp call s:syntastic()
" augroup END
" function! s:syntastic()
"   SyntasticCheck
"   call lightline#update()
" endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" 現在開いているファイルを実行 (only php|ruby|go)
function! ExecuteCurrentFile()
  if &filetype == 'php' || &filetype == 'ruby'
    exe '!' . &filetype . ' %'
  endif
  if &filetype == 'go'
    exe '!go run *.go'
  endif
endfunction
" nnoremap <Space> :call ExecuteCurrentFile()<CR>

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
" let g:indent_guides_enable_on_vim_startup = 1

" Vim終了時に現在のセッションを保存する
" autocmd VimLeave * NERDTreeClose
"autocmd VimLeave * SaveSession
" let g:session_autosave ='yes'

" # vimを辞める時に自動保存
" let g:session_directory = '~/sessions'

"引数なし起動の時、前回のsessionを復元
" Restore session with confirm
" function! s:RestoreSessionWithConfirm()
"   let msg = 'Do you want to restore previous session?'
"
"   if argc() == 0  || confirm(msg, "&Yes\n&No", 1, 'Question') == 1
"     execute 'RestoreSession'
"   endif
" endfunction
" command! RestoreSession :source ~/sessions/default.vim
" 引数を指定しなかった時のみ、Sessionを有効にする
" if argc() == 0
"   autocmd VimEnter * nested call <SID>RestoreSessionWithConfirm()
"   " autocmd VimEnter * !$VIMRUNTIME/filetype.vim
" else
" 	" 明示的に無効にする
" 	let g:session_autoload = 0
" 	let g:session_autosave = 0
" endif

" Ctagの場所指定
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'

" indent
" Vim
let g:indentLine_color_term = 239
let g:indentLine_char = '¦'

" 整形
vmap <Enter> <Plug>(EasyAlign)

" 検索結果数
" lazyに移してみた
" nmap n <Plug>(anzu-n-with-echo)
" nmap N <Plug>(anzu-N-with-echo)
" nmap * <Plug>(anzu-star)
" nmap # <Plug>(anzu-sharp)
" clear status
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
" statusline
set statusline=%{anzu#search_status()}

" let g:auto_ctags = 1
" let g:auto_ctags_directory_list = ['tmp']
" let g:auto_ctags_tags_args = '--tag-relative --recurse --sort=yes'
" let g:auto_ctags_filetype_mode = 1

set tags=tags;~

" def end移動
" matchitを有効化
source $VIMRUNTIME/macros/matchit.vim
runtime macros/matchit.vim

" ハイライトを有効にする
let g:hl_matchit_enable_on_vim_startup = 1

" カーソル下のハイライトをトグルする
map <Space>m <Plug>(quickhl-manual-this)
" ハイライトをすべて消す
map <Space>M <Plug>(quickhl-manual-reset)

" for accelerated-jk
" nmap j <Plug>(accelerated_jk_gj)
" nmap k <Plug>(accelerated_jk_gk)

" for vim-tags
" tagジャンプの時に複数候補がある時に一覧表示する
" nnoremap <C-]> g<C-]>

" カーソル下のURLや単語をブラウザで開く
" nmap <Leader>b <Plug>(openbrowser-smart-search)
" vmap <Leader>b <Plug>(openbrowser-smart-search)

" ---------- 'osyo-manga/vim-over' ----------
" 全体置換
nnoremap <silent> <Space>o :OverCommandLine<CR>%s//g<Left><Left>

" 選択範囲置換
vnoremap <silent> <Space>o :OverCommandLine<CR>s//g<Left><Left>

" カーソルしたの単語置換
nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>

" gitgitterの反映時間
set updatetime=2000

" 文法チェックは保存時だけでいい
" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

" let g:auto_update_gtags = 1

" map <C-g> :Gtags
" map <C-h> :Gtags -f %<CR>
" map <C-j> :GtagsCursor<CR>
" map <C-n> :cn<CR>
" map <C-p> :cp<CR>

" rubyファイル保存時に、自動でtagファイル生成
" autocmd BufWritePost *.rb !ripper-tags -R -f .tags

" Neosnippet
" スニペットファイルの場所指定
let g:neosnippet#snippets_directory='~/.vim/snippets/'

" ファイル名で区別出来る場合は直接呼び出し
" ファイル名で区別できない場合は一旦関数に投げる
" augroup filetypedetect
"   autocmd!  BufEnter *_spec.rb NeoSnippetSource ~/.vim/snippets/rspec.snip
"   autocmd!  BufEnter *rb call s:LoadRailsSnippet()
" augroup END

" rails用スニペット呼び出し関数
" function! s:LoadRailsSnippet()

  " カレントディレクトリのディレクトリパス（絶対パス）取得
  " let s:current_file_path = expand("%:p:h")

  " appフォルダ内でなければ無視
  " if ( s:current_file_path !~ "app/" )
  "   return

  " app/modelsフォルダ内ならば
  " elseif ( s:current_file_path =~ "app/models" )
  "   NeoSnippetSource ~/.vim/snippets/model.rails.snip

  " app/controllersフォルダ内ならば
  " elseif ( s:current_file_path =~ "app/controllers" )
  "  NeoSnippetSource ~/.vim/snippets/controller.rails.snip

  " app/viewsフォルダ内ならば
  " elseif ( s:current_file_path =~ "app/views" )
  "   NeoSnippetSource ~/.vim/snippets/view.rails.snip

  " app/helpersフォルダ内ならば
  " elseif ( s:current_file_path =~ "app/helpers" )
  "   NeoSnippetSource ~/.vim/snippets/helper.rails.snip

  " app/assetsフォルダ内ならば
"   elseif ( s:current_file_path =~ "app/assets" )
"     NeoSnippetSource ~/.vim/snippets/asset.rails.snip
"   endif
" endfunction

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" autocmd BufEnter * if exists("b:rails_root") | NeoComplCacheSetFileType ruby.rails | endif
" autocmd BufEnter * if (expand("%") =~ "_spec\.rb$") || (expand("%") =~ "^spec.*\.rb$") | NeoComplCacheSetFileType ruby.rspec | endif
" ここまで

" yankround
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

let g:yankround_max_history = 50
" nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>

"-----------------[general]
call plug#begin()
Plug 'fatih/vim-go'
Plug 'fatih/molokai' "colorscheme
Plug 'AndrewRadev/splitjoin.vim' "split and join queries etc.
Plug 'SirVer/ultisnips' "shortcuts
Plug 'ctrlpvim/ctrlp.vim'
Plug 'blueshirts/darcula' "colorscheme
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/mru.vim' "Open 'most recently used' files
Plug 'itchyny/lightline.vim'
Plug 'Shougo/neocomplete.vim' "keyword completion system
Plug 'ConradIrwin/vim-bracketed-paste' "easier copy and paste
Plug 'tpope/vim-fugitive' "adding branch to lightline
Plug 'tpope/vim-commentary' "Commenting out code
Plug 'tpope/vim-eunuch' "adds helpful unix commands 
call plug#end()

set autowrite
set number
set ttyfast
set ttyscroll=3
set laststatus=2
set autoindent
set incsearch
set encoding=utf-8
set noswapfile
set hlsearch
set completeopt=menu,menuone
set noerrorbells
set showcmd
set updatetime=100
set noshowmode

if has('unnamedplus')
	set clipboard^=unnamed
	set clipboard^=unnamedplus
endif

if has('persistent_undo')
  set undofile
  set undodir=~/.config/vim/tmp/undo//
endif
"-----------------[colorScheme]
syntax enable
set t_Co=256
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai 
"-----------------[mappings]

let mapleader=","
map <space> /
nnoremap <Leader>w <C-w>w<CR>
map <leader>f :MRU<CR>

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

autocmd BufEnter * silent! lcd %:p:h

augroup go
 autocmd!
 
"Show by default 4 spaces for a tab
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
" :GoTest
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" :GoRun
autocmd FileType go nmap <leader>r  <Plug>(go-run)

" :GoDoc
autocmd FileType go nmap <Leader>d <Plug>(go-doc)

" :GoCoverageToggle
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

" :GoInfo
autocmd FileType go nmap <Leader>i <Plug>(go-info)

" :GoMetaLinter
autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
" :GoDef but opens in a vertical split
autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
" :GoDef but opens in a horizontal split
autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
" :GoBuild or GoTestCompile if its a test file
autocmd FileType go nmap <silent> <leader>b :<C-u>call <SID>build_go_files()<CR>
" :GoAlternate  commands :A, :AV, :AS and :AT

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
 let l:file = expand('%')
 if l:file =~# '^\f\+_test\.go$'
  call go#cmd#Test(0, 1)
 elseif l:file =~# '^\f\+\.go$'
  call go#cmd#Build(0)
 endif
endfunction

"----------[Plugins]
"Neocomplete
let g:neocomplete#enable_at_startup = 1

"NERDtree
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Golang
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_metalinter_deadline = "10s"
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

"Liteline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste'],
      \             [ 'fugitive', 'filename', 'modified', 'ctrlpmark', 'go'] ],
      \   'right': [ [ 'lineinfo' ], 
      \              [ 'percent' ], 
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'go': '%#goStatuslineColor#%{LightLineGo()}',
      \ },
      \ 'component_visible_condition': {
      \   'go': '(exists("*go#statusline#Show") && ""!=go#statusline#Show())'
      \ },
      \ 'component_function': {
      \   'lineinfo': 'LightLineInfo',
      \   'percent': 'LightLinePercent',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'fugitive': 'LightLineFugitive',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ }

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineInfo()
  return winwidth(0) > 60 ? printf("%3d:%-2d", line('.'), col('.')) : ''
endfunction

function! LightLinePercent()
  return &ft =~? 'vimfiler' ? '' : (100 * line('.') / line('$')) . '%'
endfunction

function! LightLineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LightLineGo()
  return exists('*go#statusline#Show') ? go#statusline#Show() : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == 'ControlP' ? 'CtrlP' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  if mode() == 't'
    return ''
  endif

  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]')
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
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

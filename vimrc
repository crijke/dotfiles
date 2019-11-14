set nocompatible
filetype off

" Install and run vim-plug on first run
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

so ~/.vim/plugins.vim


set encoding=utf-8
set hidden
set number
set numberwidth=5
filetype plugin indent on

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, vim_command)
  try
    silent! exec a:vim_command . " " . system(a:choice_command . " | selecta")
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
  endtry
  redraw!
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
map <C-p> :call SelectaCommand("find * -type f", ":e")<cr>

" additional filetypes
au BufNewFile,BufRead *.ejs set filetype=html
set autoindent
set modelines=0
let mapleader = ","
set visualbell
set noerrorbells
set ttyfast
set showmode
set laststatus=2
set ruler
set encoding=utf-8
set showcmd
set showmatch

set history=1000
set undolevels=1000
set scrolloff=4
set virtualedit=block

set autoread
set autowrite

" whitespace
set tabstop=2 shiftwidth=2 softtabstop=2
set expandtab
set backspace=indent,eol,start
set list                                 " display extra whitespace
set listchars=tab:»·,trail:·,nbsp:·

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" remove whitespace on save
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" search and replace
set gdefault
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <leader>ss :%s/
vnoremap <leader>ss :s/
nnoremap <Leader>sr :%s/\<<C-r><C-w>\>/
nmap <silent> <leader>/ :nohlsearch<CR>
map <leader>ff :GitGrep<space>

" toggle quickfix and location list
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>c'

" paste last yank (skipping deletions)
nnoremap <leader>p "0p

" integrate with system clipboard by default
set clipboard=unnamed

" statusline
set statusline=%t%=%{SyntasticStatuslineFlag()}%{fugitive#statusline()}%h%m%r%y\ │\ %l/%L,%c\ │\ %P

" syntastic
let g:syntastic_ruby_exec = '~/.rvm/bin/rvm-auto-ruby'
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

" fugitive
nmap <leader>gb :Gblame<CR>
nmap <leader>gr :Gread<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gl :Glog<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gp :Git push<CR>

" sourcetree
nmap <leader>st :!stree<CR><CR>

" wildmenu
set wildmenu
set wildmode=longest,full
set wildignore=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*,*.swp,*~,._*,*/tmp/*,*.so,*.swp,*.zip

" omni completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" buffers and windows
nnoremap <space> :BuffergatorToggle<CR>
map <leader>k :Kwbd<CR>
map <leader>w <C-w>w
map <leader>q :clo<CR>
map <leader>= <C-w>=
let g:buffergator_viewport_split_policy="B"
let g:buffergator_suppress_keymaps=1
let g:buffergator_split_size=10

"airline
let g:airline#extensions#tabline#enabled = 1

" resize splits when resizing window
au VimResized * :wincmd =

" save when losing focus
au FocusLost * :silent! wall

" only show cursorline in normal mode of active window
augroup cline
  au!
  au WinLeave,InsertEnter * set nocursorline
  au WinEnter,InsertLeave * set cursorline
augroup END

augroup ColorcolumnOnlyInInsertMode
  au!
  au InsertEnter * setlocal colorcolumn=+1
  au InsertLeave * setlocal colorcolumn=0
augroup END

" emacs style mappings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" ctags
map <F8> :!/usr/local/bin/ctags -R . && gemtags . && jsctags .<CR>
set tags=./tags;/,./.gemtags

" tagbar
nmap <leader>rt :TagbarToggle<CR>
let g:tagbar_compact = 1
let g:tagbar_show_visibility = 1
" edit vimrc
nmap <leader>ve :e ~/.vimrc<CR>
nmap <leader>vs :so ~/.vimrc<CR>

" NERDTree
nnoremap <leader>n :NERDTreeToggle .<CR>
" nnoremap <leader>m :NERDTreeFind<CR>
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore=['\.pyc$\', '\.rbc$']
let g:NERDTreeChDirMode=2
let g:NERDTreeHighlightCursorline=0
let g:NERDTreeHijackNetrw=1

" selection
map <leader>a ggVG

" comments
nmap \ <C-_><C-_>
vmap \ <C-_><C-_>

" lines
" Bubble single lines
nmap <C-k> [e
nmap <C-j> ]e
" Bubble multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv

" disable F1
map <F1> <nop>
imap <F1> <nop>

" format entire file
nnoremap <leader>fo :normal! gg=G``<CR>

" pastemode
set pastetoggle=<F4>

" move by screen line and not file line
nnoremap j gj
nnoremap k gk

" mouse
set mouse=a

" appearance
syntax enable
set textwidth=100
set background=dark
set t_Co=256
let g:solarized_termcolors=256
colorscheme solarized
set fillchars=vert:\│
if has('gui_running')
  set guifont=Menlo:h12
  set guioptions=egmrt
else
  hi NonText ctermfg=bg guifg=bg
  hi VertSplit ctermbg=bg guibg=bg
endif
" no swap and backup files
set nobackup
set noswapfile


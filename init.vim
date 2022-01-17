if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

set number
set relativenumber
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set ignorecase
set smartcase
set noshowmode
set noshowcmd
set cursorline
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set scrolloff=5
set clipboard+=unnamedplus
set shortmess+=c
set signcolumn=number
set hidden
set termguicolors
set updatetime=100
set foldmethod=indent
set foldlevel=30

silent !mkdir -p $HOME/.config/nvim/tmp/backup
silent !mkdir -p $HOME/.config/nvim/tmp/undo
set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/backup,.
set undofile
set undodir=$HOME/.config/nvim/tmp/undo,.

noremap! <C-n> <Left>
noremap! <C-e> <Down>
noremap! <C-u> <Up>
noremap! <C-i> <Right>
noremap! <C-a> <Home>
noremap! <C-o> <End>

noremap u k
noremap n h
noremap e j
noremap i l
noremap l u
noremap k i
noremap K I
noremap h e
noremap - N
noremap = n

noremap E <C-f>
noremap U <C-b>
noremap N ^
noremap I $
noremap W 5w
noremap B 5b
noremap > >>
noremap < <<
noremap ` ~
noremap ; :
nnoremap vv ^v$h
nnoremap <silent> <Space><CR> :nohlsearch<CR>
nnoremap <silent> q :q<CR>
nnoremap R :w<CR>

" Windows
nnoremap <silent> sN :set nosplitright<CR>:vsplit<CR>
nnoremap <silent> sE :set splitbelow<CR>:split<CR>
nnoremap <silent> sU :set nosplitbelow<CR>:split<CR>
nnoremap <silent> sI :set splitright<CR>:vsplit<CR>
nnoremap <silent> <Space>1 :1wincmd w<CR>
nnoremap <silent> <Space>2 :2wincmd w<CR>
nnoremap <silent> <Space>3 :3wincmd w<CR>
nnoremap <silent> <Space>4 :4wincmd w<CR>
nnoremap <silent> <Space>5 :5wincmd w<CR>
nnoremap <silent> <Space>6 :6wincmd w<CR>
nnoremap <silent> <Space>7 :7wincmd w<CR>
nnoremap <silent> <Space>8 :8wincmd w<CR>
nnoremap <silent> <Space>9 :9wincmd w<CR>
nnoremap sn <C-w>h
nnoremap se <C-w>j
nnoremap su <C-w>k
nnoremap si <C-w>l
nnoremap <silent> <Up> :res +5<CR>
nnoremap <silent> <Down> :res -5<CR>
nnoremap <silent> <Right> :vertical res +5<CR>
nnoremap <silent> <Left> :vertical res -5<CR>
nnoremap sh <C-w>t<C-w>K
nnoremap sv <C-w>t<C-w>H
nnoremap srh <C-w>b<C-w>K
nnoremap srv <C-w>b<C-w>H
nnoremap sf <C-w>w
nnoremap sc <C-w>o
nnoremap <silent> stn :set nosplitright<CR>:vsplit<CR>:term<CR>i
nnoremap <silent> ste :set splitbelow<CR>:split<CR>:term<CR>i
nnoremap <silent> stu :set nosplitbelow<CR>:split<CR>:term<CR>i
nnoremap <silent> sti :set splitright<CR>:vsplit<CR>:term<CR>i
nnoremap <silent> stt :tabe<CR>:term<CR>i

" Tabs
nmap <silent> tu :tabe<CR>
nmap <silent> <Leader>1 <Plug>AirlineSelectTab1
nmap <silent> <Leader>2 <Plug>AirlineSelectTab2
nmap <silent> <Leader>3 <Plug>AirlineSelectTab3
nmap <silent> <Leader>4 <Plug>AirlineSelectTab4
nmap <silent> <Leader>5 <Plug>AirlineSelectTab5
nmap <silent> <Leader>6 <Plug>AirlineSelectTab6
nmap <silent> <Leader>7 <Plug>AirlineSelectTab7
nmap <silent> <Leader>8 <Plug>AirlineSelectTab8
nmap <silent> <Leader>9 <Plug>AirlineSelectTab9
nmap <silent> <Leader>0 <Plug>AirlineSelectTab0
nmap <silent> tn <Plug>AirlineSelectPrevTab
nmap <silent> ti <Plug>AirlineSelectNextTab
nmap <silent> tmn :-tabmove<CR>
nmap <silent> tmi :+tabmove<CR>

noremap <Space>r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		set splitright
		exec "!gcc % -o %<"
		:vsp
		:term ./%<
	elseif &filetype == 'cpp'
		set splitright
		exec "!g++ -std=c++11 % -Wall -o %<"
		:vsp
		:term ./%<
	elseif &filetype == 'cs'
		set splitbelow
		silent! exec "!mcs %"
		:sp
		:res -5
		:term mono %<.exe
	elseif &filetype == 'java'
		set splitbelow
		:sp
		:res -5
		term javac % && time java %<
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		silent! exec "CocCommand flutter.run"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc

" Plugins
call plug#begin('~/.config/nvim/plugged')
" === Language servers
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'dart-lang/dart-vim-plugin'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Other plugins
Plug 'morhetz/gruvbox'
Plug 'theniceboy/nvim-deus'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'liuchengxu/vista.vim'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdcommenter'
Plug 'dhruvasagar/vim-table-mode'
Plug 'luochen1990/rainbow'
Plug 'gcmt/wildfire.vim'
Plug 'tpope/vim-surround'
Plug 'mg979/vim-visual-multi'
Plug 'Yggdroot/indentLine'
call plug#end()

" ===
" === gruvbox
" ===
"color gruvbox

" ===
" === nvim-deus
" ===
color deus

source ~/.config/nvim/config/plugins/coc.vim
source ~/.config/nvim/config/plugins/vim-airline.vim
source ~/.config/nvim/config/plugins/vista.vim
source ~/.config/nvim/config/plugins/undotree.vim
source ~/.config/nvim/config/plugins/fzf.vim
source ~/.config/nvim/config/plugins/nerdcommenter.vim
source ~/.config/nvim/config/plugins/vim-table-mode.vim
source ~/.config/nvim/config/plugins/rainbow.vim
source ~/.config/nvim/config/plugins/indentLine.vim
source ~/.config/nvim/config/md-snippets.vim
source ~/.config/nvim/config/cursor.vim


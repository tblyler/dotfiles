scriptencoding utf-8

let s:uname = system("echo -n \"$(uname)\"")
if v:shell_error
	let s:uname = 'Unknown'
endif

function GoPostUpdate()
	:GoInstallBinaries
	:GoUpdateBinaries
endfunction

call plug#begin($HOME.'/.nvim/plugged')

if s:uname == "Linux"
	" enforce python3 for distros like debian where python2 is the default
	if has('python3')
		Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --all' }
	else
		Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
	endif
else
	" OSX is terrible about everything nice
	Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer --racer-completer --tern-completer' }
endif

Plug 'Chiel92/vim-autoformat'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'Lokaltog/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'bronson/vim-trailing-whitespace'
Plug 'fatih/vim-go', { 'do': ':exec GoPostUpdate()' }
Plug 'jbgutierrez/vim-babel'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'mattn/webapi-vim'
Plug 'nanotech/jellybeans.vim'
Plug 'rking/ag.vim'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
Plug 'terryma/vim-multiple-cursors'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'

call plug#end()

" speed improvements for ctrlp
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
	let g:ctrlp_user_command = 'ag %s -i -l --nocolor --nogroup --hidden
				\ --ignore .git
				\ --ignore .svn
				\ --ignore .hg
				\ --ignore .DS_Store
				\ --ignore "**/*.min.js"
				\ --ignore "**/*.min.map"
				\ --ignore "**/*.pyc"
				\ -g ""'
	let g:ctrlp_use_caching = 0
endif
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
" end speed improvements for ctrlp

colorscheme jellybeans                       " Color scheme
set laststatus=2                             " Enable airline
let g:airline_theme = 'jellybeans'           " Airline color scheme
let g:airline#extensions#tabline#enabled = 1 " Enable tab list in airline
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline_powerline_fonts = 1
set list                                     " Show tabs
set listchars=tab:\|\                        " Show tabs by using the pipe symbol
set tabstop=4                                " Tabs look like 4 spaces
set softtabstop=0 noexpandtab                " Tabs look like 4 spaces
set shiftwidth=4                             " Tabs look like 4 spaces
set number                                   " Show line numbers
set cursorline                               " Highlight entire line that cursor is on
let g:tagbar_left = 1                        " Make tagbar appear on the left
autocmd CompleteDone * pclose                " Remove scratchpad after selection
set mouse=                                   " Disable mouse

if getcwd() =~ '/repos/cuda'
	" codesniff files
	let g:ale_php_phpcs_standard=''.$HOME.'/repos/cuda/Cuda-PHP-Code-Standards/PHP_CodeSniffer/Barracuda'
endif

" Enable syntax-highlighting for Go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Use goimports instead of gofmt for import paths
let g:go_fmt_command = "goimports"

" Key mappings
map <F2> :NERDTreeToggle <CR>
map <F3> :TagbarToggle <CR>
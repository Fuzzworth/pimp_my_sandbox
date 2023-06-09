#!/bin/bash

sudo update
sudo apt-get install fonts-powerline -y
sudo apt-get install curl -y

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

content=$(cat <<EOF
set number
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. \`call plug#begin('~/.vim/plugged')\`
"   - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Multiple Plug commands can be written in a single line using | separators
Plug 'honza/vim-snippets' | Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
" On-demand loading
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Using a non-default branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }
" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'kien/rainbow_parentheses.vim'
" Unmanaged plugin (manually installed and updated)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'valloric/youcompleteme'
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
" Initialize plugin system
" - Automatically executes \`filetype plugin indent on\` and \`syntax enable\`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source \$MYVIMRC
endif
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#lleft_sep = '»'
let g:airline#extensions#tabline#lleft_sep = ':arrow_forwards:'
let g:airline#extensions#tabline#lright_sep = '«'
let g:airline#extensions#tabline#lright_sep = ':arrow_backwards:'
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'default'
set ttimeoutlen=50
let g:airline#extensions#branch#enabled= 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\\ua0"
let g:python3_host_prog = "/usr/bin/python3"
let g:snipMate = { 'snippet_version' : 1 }
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
EOF
)

echo "$content" | sudo tee -a /etc/vim/vimrc >/dev/null

echo "Content appended to /etc/vim/vimrc successfully."

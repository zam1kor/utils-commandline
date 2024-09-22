call plug#begin('~/.vim/plugged')

" List your plugins here
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'    " For file icons in NERDTree

" Color schemes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim'

" Airline for better tabline and statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" NERDTree mappings
nnoremap <leader>n :call OpenNERDTreeInTab()<CR>

" Ensure files open in a new tab when clicked with the mouse
let g:NERDTreeMapOpenInTab = '<LeftMouse>'
autocmd FileType nerdtree nmap <buffer> <LeftMouse> <LeftMouse>:tabedit<CR>

" General settings
set mouse=a         " Enable mouse support
syntax on           " Enable syntax highlighting
set number          " Show line numbers

" Enable devicons
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1


" Always show tabline
set showtabline=2

" Use vim-airline for a better tabline and statusline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Function to open NERDTree in a dedicated tab and keep it there
function! OpenNERDTreeInTab()
  " Check if NERDTree is already open in another tab
  for i in range(1, tabpagenr('$'))
    if gettabvar(i, 'nerdtree_tab') == 1
      " Switch to the NERDTree tab if found
      execute i . 'tabnext'
      return
    endif
  endfor
  " If NERDTree is not open, open it in a new tab
  tabnew
  execute 'NERDTree'
  " Mark this tab as the NERDTree tab
  let t:nerdtree_tab = 1
endfunction

" Prevent NERDTree tab from closing when it's the only window left in the tab
autocmd TabEnter * if tabpagenr('$') > 1 && exists('t:nerdtree_tab') && winnr('$') == 1 | quit | endif

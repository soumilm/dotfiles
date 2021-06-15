set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'lervag/vimtex'
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'mhinz/vim-startify'
Plugin 'vim-syntastic/syntastic'
Plugin 'mattesgroeger/vim-bookmarks'
Plugin 'google/vim-searchindex'
Plugin 'Conque-GDB'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'sbdchd/neoformat'
call vundle#end()            " required
filetype plugin indent on    " required

"Marks Used
" `y - Used for cursor placement after yank

"Registries Used
" "x - Used for environment completion command for .tex files

"Function Keys Used
" F2 - Used to toggle show whitespace
" F8 - Used to toggle colorcolumn

" Ensure that we are in modern vim mode, not backwards-compatible vi mode
set nocompatible
set backspace=indent,eol,start

" Remove the goddamn swap files
set noswapfile

" Helpful information: cursor position in bottom right, line numbers on
" left
set ruler
set relativenumber
set number

" Enable mouse support
set mouse=a

"Enable filetype detection and syntax hilighting
syntax on
filetype on
filetype indent on
filetype plugin on

" Show multicharacter commands as they are being typed
set showcmd

"Disable modelines
set nomodeline

"Highlight current line
set cursorline

"Show filename at the bottom
set laststatus=2

"No Wrapped Lines and Smooth Horizontal Scrolling
set nowrap
set sidescroll=1

"Indentation
set smartindent
autocmd FileType sml setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType ml setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType tex setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType python setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType text setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
au BufRead,BufNewFile *.ml,*.mli,*.mll,*.mly setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
au BufRead,BufNewFile *.c0,*.l1,*.l2,*.l3,*.l4,*.l5,*.l6 setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufWritePre * %s/\s\+$//e

set tabstop=4
set noexpandtab
set softtabstop=4
set shiftwidth=4

"Searching
set incsearch "Search as you type
set hlsearch "Highlight matches
set ignorecase
set smartcase
"Remove search highlight with Esc
nnoremap <C-c> :nohlsearch<CR>
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Syntax highlighting for C0
au BufRead,BufNewFile *.c0,*.l1,*.l2,*.l3,*.l4,*.l5,*.l6 setlocal syntax=c

set encoding=utf-8
scriptencoding utf-8

"Move cursor past line end
set virtualedit=onemore

"Colorscheme
set background=dark
set t_Co=256
colorscheme palenight
let g:palenight_terminal_italics=1
let g:lightline = { 'colorscheme': 'palenight' }
let g:airline_theme = "palenight"
"Use All colors
set termguicolors

highlight Normal ctermfg=grey ctermbg=darkblue

hi clear SignColumn

let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

"Spellcheck
set spelllang=en_us
set spellfile=~/.vim/spell/en.utf-8.add
for item in ['Bad','Cap','Local','Rare']| exe "hi clear Spell".item| endfor
"Misspelled words
hi SpellBad cterm=underline
"Rare words
hi SpellRare cterm=underline
"Word not capitalized
hi SpellCap cterm=underline
"Word spelled like the British
hi SpellLocal cterm=underline
"LaTeX only
set nospell
autocmd FileType tex,text,markdown set spell
"Replace last misspelled word with first suggestions
inoremap <C-l>1 <c-g>u<Esc>[s1z=`]a<c-g>u
inoremap <C-l><C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
"Add last misspelled word to dictionary
inoremap <C-l>+ <c-g>u<Esc>[szg`]a<c-g>u
inoremap <C-l><C-o> <c-g>u<Esc>[szg`]a<c-g>u
"Go to last misspelled word and open suggestions
inoremap <C-l><C-k> <C-x>s

"Open file navigation on left
autocmd VimEnter * :wincmd p
let g:netrw_winsize = 25
let g:netrw_browse_split = 0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_altv = 1

"Default window splits
set splitbelow

"Set vertical window sizes
command Small vertical resize 37
command Mid vertical resize 75
command Big vertical resize 113
"Set horizontal window sizes
command Short resize 10
command Tall resize 25
command MidH resize 20

" ----- xolox/vim-easytags settings -----
" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" ----- majutsushi/tagbar settings -----
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)

"Command and Undo History
set history=1000
set undolevels=1000

"Persistent Undo
set undofile
set undodir=~/.vim/undodir

"Autocomplete Menu
set wildmenu
"Toggle Colorcolumn
noremap <expr> <F8> &cc == '' ? ':set cc=80<CR>' : ':set cc=<CR>'
au BufRead,BufNewFile *.ml,*.mli,*.mll,*.mly set cc=80
autocmd FileType sml set cc=80

"Folding
set wrap linebreak nolist

"Use system clipboard for yank/paste
set clipboard=unnamedplus
nnoremap <leader>p p`[v`]=

"Keep cursor in place for yank
vnoremap y myy`y
vnoremap Y myY`y
nnoremap Y y$

"Put cursor at end of pasted text
noremap p gp<BS><Right>
noremap P gP<BS><Right>
noremap gp p
noremap gP P

"Keep highlighted text for indent shifting
vnoremap < <gv
vnoremap > >gv

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-]>"
let g:UltiSnipsJumpBackwardTrigger="<c-[>"
" :UltiSnipsEdit splits window.
let g:UltiSnipsEditSplit="vertical"

let g:airline#extensions#hunks#non_zero_only = 1

" ----- Raimondi/delimitMate settings -----
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

"Insert a single character from normal mode
nnoremap <Space> i<Space><Esc>r

map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

"Automatch Braces
inoremap {<CR> {<CR>}<Esc>ko

"Terminal
command Term terminal ++rows=10
command BigTerm terminal

"Block Comment/Uncomment
nnoremap <expr> <C-_> (synIDattr(synID(line("."), col("."), 0), "name") =~ 'comment\c') ?
			\ '0:<S-Left>exe "<S-Right>normal! ".b:unCommentCommand<CR>' :
			\ '0:<S-Left>exe "<S-Right>normal! ".b:commentCommand<CR>'

vnoremap <expr> <C-_> (synIDattr(synID(line("."), col("."), 0), "name") =~ 'comment\c') ?
			\ '0:<S-Left>exe "<S-Right>normal! ".b:unCommentCommand<CR>gv' :
			\ '0:<S-Left>exe "<S-Right>normal! ".b:commentCommand<CR>gv'

autocmd Filetype c,cpp,java let b:commentCommand='i//'   "Comment for '//' filetypes
autocmd Filetype c,cpp,java let b:unCommentCommand='^xx' "un-Comment for '//' filetypes
autocmd Filetype python let b:commentCommand='i#'    "Comment for '#' filetypes
autocmd Filetype python let b:unCommentCommand='^x'  "un-Comment for '#' filetypes
autocmd Filetype vim let b:commentCommand='i"'    "Comment for vim filetypes
autocmd Filetype vim let b:unCommentCommand='^x'  "un-Comment for vim filetypes
autocmd Filetype tex let b:commentCommand='i%'    "Comment for '%' filetypes
autocmd Filetype tex let b:unCommentCommand='^x'  "un-Comment for '%' filetypes
autocmd Filetype sml nnoremap <expr> <C-_> (synIDattr(synID(line("."), col("."), 0), "name") =~ 'comment\c') ?
			\ '<Esc>0xx$xx' :
			\ '<Esc>0i(*<Esc>$a*)<Esc>'
autocmd Filetype sml vnoremap <expr> <C-_> (synIDattr(synID(line("."), col("."), 0), "name") =~ 'comment\c') ?
			\ '<Esc>`<xx`>xxgv' :
			\ '<Esc>`<i(*<Esc>`>a*)<Esc>gv'

"Default Tex Flavor
let g:tex_flavor = "latex"

"Autocomplete HTML tags
autocmd FileType html inoremap <C-N> <esc>:let@x=@"<CR>yypkI<<esc>A><esc>jI</<esc>A><esc>:let@"=@x<CR>ko

"Autocomplete \begin LaTeX
autocmd FileType tex inoremap <C-N> <esc>:let@x=@"<CR>YpkI\begin{<esc>A}<esc>jI\end{<esc>A}<esc>:let@"=@x<CR>ko
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

"Compile LaTeX on Ctrl+T
autocmd FileType tex nmap <buffer> <C-T> :wa <bar> !latexmk -pdf %<CR>
"Compile markdown on Ctrl+T
autocmd FileType markdown nmap <buffer> <C-T> :wa <bar> !pandoc -s -o %:r.pdf %<CR>
"Run python on Ctrl+T
autocmd FileType python nmap <buffer> <C-T> :wa <bar> !python3 %<CR>

"Ctrl+B and Ctrl+J for bold/italics
"Markdown :
autocmd FileType markdown vnoremap <C-B> di**<esc>hp
autocmd FileType markdown inoremap <C-B> **<esc>i
autocmd FileType markdown vnoremap <C-J> di__<esc>hp
autocmd FileType markdown inoremap <C-J> __<esc>i
"LaTeX :
autocmd FileType tex vnoremap <C-B> di\textbf{}<esc>hp
autocmd FileType tex inoremap <C-B> \textbf{}<esc>i
autocmd FileType tex vnoremap <C-J> di\textit{}<esc>hp
autocmd FileType tex inoremap <C-J> \textit{}<esc>i

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line

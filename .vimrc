set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Raimondi/delimitMate'               " automatically close quotes, parens, etc
Plugin 'SirVer/ultisnips'                   " configurable tab-completed ultisnips
Plugin 'airblade/vim-gitgutter'             " show diff icons on the left
Plugin 'christoomey/vim-tmux-navigator'     " Ctrl+{h,j,k,l} navigates consistently across tmux and vim
Plugin 'dense-analysis/ale'                 " linter + autocomplete
Plugin 'eslint/eslint'                      " JS linter
Plugin 'fatih/vim-go'                       " golang miscellany
Plugin 'google/vim-searchindex'             " add count and index when searching
Plugin 'honza/vim-snippets'                 " adds snippets for UltiSnips
Plugin 'jparise/vim-graphql'                " GraphQL syntax
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }                      " fuzzy file finder logic
Plugin 'junegunn/fzf.vim'                   " fzf support
Plugin 'leafgarland/typescript-vim'         " TypeScript syntax
Plugin 'mattesgroeger/vim-bookmarks'        " bookmarks for lines
Plugin 'maxmellon/vim-jsx-pretty'           " JS and JSX syntax
Plugin 'mhinz/vim-startify'                 " fancy start screen for vim
Plugin 'neovim/nvim-lspconfig'
Plugin 'pangloss/vim-javascript'            " JavaScript support
Plugin 'sbdchd/neoformat'                   " formatter
Plugin 'simnalamburt/vim-mundo'
Plugin 'tpope/vim-fugitive'                 " git commands
Plugin 'tpope/vim-vinegar'                  " file navigation
Plugin 'vim-python/python-syntax'           " for f-strings
Plugin 'yegappan/mru'                       " see most recently used files

" Colorscheme plugin
Plugin 'cocopon/iceberg.vim'
call vundle#end()            " required
filetype plugin indent on    " required

set rtp+=/opt/homebrew/opt/fzf

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

"Minimum lines to keep above and below the cursor
set scrolloff=5

"I really need to learn not to use these keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
vnoremap <Up> <NOP>
vnoremap <Down> <NOP>
vnoremap <Left> <NOP>
vnoremap <Right> <NOP>

"Indentation
set smartindent
autocmd FileType sml setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType ml setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType tex setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType python setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType go setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType text setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
au BufRead,BufNewFile *.ml,*.mli,*.mll,*.mly setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
au BufRead,BufNewFile *.c0,*.l1,*.l2,*.l3,*.l4,*.l5,*.l6 setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
"Delete trailing whitespace in all lines
autocmd BufWritePre * %s/\s\+$//e

set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2

"Searching
set incsearch "Search as you type
set hlsearch "Highlight matches
set ignorecase
set smartcase
"Remove search highlight with Esc
nnoremap <C-c> :nohlsearch<CR>
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * y/\V<C-R>=escape(@",'/\')<CR><CR>

" Syntax highlighting for C0
au BufRead,BufNewFile *.c0,*.l1,*.l2,*.l3,*.l4,*.l5,*.l6 setlocal syntax=c

set encoding=utf-8
scriptencoding utf-8

"Move cursor past line end
set virtualedit=onemore

"Sets cursor shape to bar when in insert mode
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

"Colorscheme
set background=dark
set t_Co=256
colorscheme iceberg
let g:lightline = { 'colorscheme': 'iceberg' }
"Use All colors
set termguicolors

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
hi SpellBad cterm=underline gui=undercurl
"Rare words
hi SpellRare cterm=underline gui=undercurl
"Word not capitalized
hi SpellCap cterm=underline gui=undercurl
"Word spelled like the British
hi SpellLocal cterm=underline gui=undercurl
"Certain file types only
set nospell
autocmd FileType tex,text,markdown,html,json set spell
autocmd FileType tex,text,markdown,html,json syntax spell toplevel
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

" ----- xolox/vim-easytags settings -----
" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

"Command and Undo History
set history=1000
set undolevels=1000

"Persistent Undo
set undofile
set undodir=~/.vim/undodir

nnoremap U :MundoToggle<CR>

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

"Split vertically/horizontally
set splitright
set splitbelow
nnoremap ,v <C-w>v
nnoremap ,h <C-w>s

let g:gitparsedbranchname = ' '
function! UpdateGitBranch()
  let l:string = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  let g:gitparsedbranchname = strlen(l:string) > 0?' ['.l:string.']':''
endfunction

autocmd BufEnter * :call UpdateGitBranch()
set statusline=
set statusline+=%#PmenuSel#
set statusline+=\ %f\  "Comment to prevent vim from swallowing intentional trailing space
set statusline+=%#LineNr#
set statusline+=%{g:gitparsedbranchname}
set statusline+=%=
set statusline+=\ %l/%L\ (%c)\  "Comment to prevent vim from swallowing intentional trailing space

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
" :UltiSnipsEdit splits window.
let g:UltiSnipsEditSplit="vertical"

let g:startify_change_to_dir = 0
let g:startify_bookmarks = [
            \ { 'v': '~/.vimrc' },
            \ ]

nnoremap + :ALEGoToDefinition<CR>
nnoremap ++ <C-O>
let g:ale_linters = {'python': ['pyright']}
let g:ale_completion_enabled = 1

let g:python_highlight_all = 1

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

noremap [[ ?{<CR>w99[{
noremap ][ /}<CR>b99]}
noremap ]] j0[[%/{<CR>
noremap [] k$][%?}<CR>

"Automatch Braces
inoremap {<CR> {<CR>}<Esc>ko

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
autocmd Filetype tex let b:commentCommand='i% '    "Comment for '%' filetypes
autocmd Filetype tex let b:unCommentCommand='^xx'  "un-Comment for '%' filetypes
autocmd Filetype sml,mlw nnoremap <expr> <C-_> (synIDattr(synID(line("."), col("."), 0), "name") =~ 'comment\c') ?
			\ '<Esc>0xx$xx' :
			\ '<Esc>0i(*<Esc>$a*)<Esc>'
autocmd Filetype sml,mlw vnoremap <expr> <C-_> (synIDattr(synID(line("."), col("."), 0), "name") =~ 'comment\c') ?
			\ '<Esc>`<xx`>xxgv' :
			\ '<Esc>`<i(*<Esc>`>a*)<Esc>gv'

autocmd BufRead,BufNewFile *bashrc* set filetype=bash

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
autocmd FileType tex nmap <buffer> <C-P> :wa <bar> !latexmk -pdf %<CR>
"Compile markdown on Ctrl+T
autocmd FileType markdown nmap <buffer> <C-P> :wa <bar> !pandoc -s -o %:r.pdf %<CR>
"Run python on Ctrl+T
autocmd FileType python nmap <buffer> <C-P> :wa <bar> !python3 %<CR>

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
"HTML :
autocmd FileType html vnoremap <C-B> di<lt>strong><lt>/strong><esc>9hp
autocmd FileType html inoremap <C-B> <lt>strong><lt>/strong><esc>8hi
autocmd FileType html vnoremap <C-J> di<lt>em><lt>/em><esc>5hp
autocmd FileType html inoremap <C-J> <lt>em><lt>/em><esc>4hi

if system('uname -s') == "Darwin\n"
  "OSX
  source ~/dotfiles/.work_vimrc
endif

vim.cmd([[
"Delete trailing whitespace in all lines
autocmd BufWritePre * %s/\s\+$//e

hi clear SignColumn

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
" :UltiSnipsEdit splits window.
let g:UltiSnipsEditSplit="vertical"

nnoremap + :ALEGoToDefinition<CR>

let g:python_highlight_all = 1

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

"Automatch Braces
inoremap {<CR> {<CR>}<Esc>ko

autocmd BufRead,BufNewFile *bashrc* set filetype=bash

"Default Tex Flavor
let g:tex_flavor = "latex"

"Autocomplete HTML tags
autocmd FileType html inoremap <C-N> <esc>:let@x=@"<CR>yypkI<<esc>A><esc>jI</<esc>A><esc>:let@"=@x<CR>ko

"Autocomplete \begin LaTeX
autocmd FileType tex inoremap <C-N> <esc>:let@x=@"<CR>YpkI\begin{<esc>A}<esc>jI\end{<esc>A}<esc>:let@"=@x<CR>ko

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
]])

function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local opt = vim.opt

opt.backspace = {'indent', 'eol', 'start'}
opt.swapfile = false -- Remove the swapfiles

opt.ruler = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true

opt.mouse = "a"

opt.laststatus = 2

vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.list = false

opt.scrolloff = 5

opt.ignorecase = true
opt.smartcase = true

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'Raimondi/delimitMate'               -- automatically close quotes, parens, etc
  use 'SirVer/ultisnips'                   -- configurable tab-completed ultisnips
  use 'airblade/vim-gitgutter'             -- show diff icons on the left
  use 'christoomey/vim-tmux-navigator'     -- Ctrl+{h,j,k,l} navigates consistently across tmux and vim
  use 'cocopon/iceberg.vim'                -- theme
  use 'eslint/eslint'                      -- JS linter
  use 'fatih/vim-go'                       -- golang miscellany
  use 'google/vim-searchindex'             -- add count and index when searching
  use 'honza/vim-snippets'                 -- adds snippets for UltiSnips
  use 'jparise/vim-graphql'                -- GraphQL syntax
  use 'leafgarland/typescript-vim'         -- TypeScript syntax
  use 'mattesgroeger/vim-bookmarks'        -- bookmarks for lines
  use 'maxmellon/vim-jsx-pretty'           -- JS and JSX syntax
  use 'mhinz/vim-startify'                 -- fancy start screen for vim
  use 'neovim/nvim-lspconfig'
  use 'pangloss/vim-javascript'            -- JavaScript support
  use 'sbdchd/neoformat'                   -- formatter
  use 'simnalamburt/vim-mundo'
  use 'tpope/vim-fugitive'                 -- git commands
  use 'tpope/vim-vinegar'                  -- file navigation
  use 'vim-python/python-syntax'           -- for f-strings
  use 'yegappan/mru'                       -- see most recently used files

  use { "ibhagwan/fzf-lua",
    requires = { "nvim-tree/nvim-web-devicons" }, -- optional for icon support
  }

  use {
    'dense-analysis/ale',
    config = function()
        local g = vim.g

        g.ale_ruby_rubocop_auto_correct_all = 1
        g.ale_linters = {
            ruby = {'rubocop', 'ruby'},
            lua = {'lua_language_server'},
            python = {'pyright'},
        }
        g.ale_completion_enabled = 1
      end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
end)

require("fzf-lua").setup({
  "fzf-vim",
  files = {
    git_icons = false,
  },
})

require("lualine").setup()

vim.opt.termguicolors=true
vim.o.background = "dark"
vim.cmd.colorscheme "iceberg"
vim.cmd("let g:lightline = { 'colorscheme': 'iceberg' }")

Map('', '<Up>', '<NOP>')
Map('', '<Down>', '<NOP>')
Map('', '<Left>', '<NOP>')
Map('', '<Right>', '<NOP>')
Map('v', '<Up>', '<NOP>')
Map('v', '<Down>', '<NOP>')
Map('v', '<Left>', '<NOP>')
Map('v', '<Right>', '<NOP>')

Map('n', 'U', ':MundoToggle<CR>')

-- Un-highlight search results on C-c
Map('n', '<C-c>', ':nohlsearch<CR>')
-- * searches current selection
Map('v', '*', [[y/\V<C-R>=escape(@",'/\')<CR><CR>]])

opt.virtualedit = 'onemore'

-- INDENTATION
opt.smartindent = true
opt.tabstop = 2
opt.expandtab = true
opt.softtabstop = 2
opt.shiftwidth = 2

opt.encoding = 'utf-8'
opt.fileencodings = 'utf-8'

opt.history = 1000
opt.undolevels = 1000
-- Persistent Undo
opt.undofile = true
opt.undodir = vim.fs.normalize('~/.vim/undodir')

opt.wildmenu = true
opt.wildmode = 'longest:full,full'

-- Splits
opt.splitright = true
opt.splitbelow = true
Map('n', ',v', '<C-w>v')
Map('n', ',h', '<C-w>s')

vim.g.startify_change_to_dir = 0
vim.g.startify_bookmarks = {
  {v = '~/.vimrc' },
}

-- Keep cursor in place for yank
Map('v', 'y', 'myy`y')
Map('v', 'Y', 'myY`y')
Map('n', 'Y', 'y$')

-- Put the cursor after pasted content
Map('', 'p', 'gp<BS><Right>')
Map('', 'P', 'gP<BS><Right>')
Map('', 'gp', 'p')
Map('', 'gP', 'P')

opt.clipboard = 'unnamedplus'
Map('n', '<leader>p', 'p`[v`]=')

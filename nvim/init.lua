function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

local opt = vim.opt
local g = vim.g

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

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

require("config.lazy")

vim.cmd("hi clear SignColumn")
opt.termguicolors = true
opt.background = "dark"
vim.cmd.colorscheme "iceberg"
g.lightlight = { colorscheme = 'iceberg' }

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

g.startify_change_to_dir = 0
g.startify_bookmarks = {
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


g.UltiSnipsExpandTrigger = "<tab>"
g.UltiSnipsJumpForwardTrigger = "<tab>"
g.UltiSnipsJumpBackwardTrigger = "<S-tab>"
g.UltiSnipsEditSplit = "vertical"

Map('n', '+', ':ALEGoToDefinition<CR>')
g.tex_flavor = "latex"


-- Insert a single character from normal mode
Map('n', '<Space>', 'i<Space><Esc>r')
-- Automatch Braces
Map('i', '{<CR>', '{<CR>}<Esc>ko')

vim.api.nvim_create_autocmd("BufWritePre", {
  command = [[%s/\s\+$//e]]
})

vim.api.nvim_create_autocmd( {"BufRead", "BufNewFile"}, {
  pattern = "*bashrc",
  callback = function()
    vim.bo.filetype = "bash"
  end
})

vim.cmd([[
" ----- Raimondi/delimitMate settings -----
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

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
]])

-- Only on OSX
if os.capture('uname -s') == "Darwin" then
  require("soumilm.stripe")
end

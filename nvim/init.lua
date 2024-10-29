function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

function FileTypeMap(filetype, mode, lhs, rhs, opts)
  vim.api.nvim_create_autocmd( "FileType", {
    pattern = filetype,
    callback = function()
      Map(mode, lhs, rhs, opts)
    end
  })
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

---- Indentation ----
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
  {d = '~/dotfiles' },
  {i = '~/dotfiles/nvim/init.lua' },
}

---- Miscellaneous Clipboard Stuff -----
-- Keep cursor in place for yank
Map('v', 'y', 'myy`y')
Map('v', 'Y', 'myY`y')
Map('n', 'Y', 'y$')
-- Put the cursor after pasted content
Map('', 'p', 'gp<BS><Right>')
Map('', 'P', 'gP<BS><Right>')
Map('', 'gp', 'p')
Map('', 'gP', 'P')
-- Use system clipboard
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

-- Strip all trailing whitespaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
  command = [[%s/\s\+$//e]]
})

vim.api.nvim_create_autocmd( {"BufRead", "BufNewFile"}, {
  pattern = "*bashrc",
  callback = function()
    vim.bo.filetype = "bash"
  end
})

-- Match open tags with corresponding close tags
FileTypeMap(
  "html", "i",
  "<C-N>",
  [[<esc>:let@x=@"<CR>yypkI<<esc>A><esc>jI</<esc>A><esc>:let@"=@x<CR>ko]]
)
FileTypeMap(
  "tex", "i",
  "<C-N>",
  [[<esc>:let@x=@"<CR>YpkI\begin{<esc>A}<esc>jI\end{<esc>A}<esc>:let@"=@x<CR>ko]]
)

---- Raimondi/delimitMate settings ----
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.g.delimitMate_quotes = ""
    vim.g.delimitMate_matchpairs = "(:),[:],{:},`:'"
  end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.g.delimitMate_nesting_quotes = {"`"}
  end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.g.delimitMate_nesting_quotes = {'"', "'"}
  end
})

---- Ctrl+B/J for bold/italics ----
FileTypeMap("markdown", "v", "<C-B>", [[di**<esc>hp]])
FileTypeMap("markdown", "i", "<C-B>", [[**<esc>i]])
FileTypeMap("markdown", "v", "<C-J>", [[di__<esc>hp]])
FileTypeMap("markdown", "i", "<C-J>", [[__<esc>i]])
FileTypeMap("tex", "v", "<C-B>", [[di\textbf{}<esc>hp]])
FileTypeMap("tex", "i", "<C-B>", [[\textbf{}<esc>i]])
FileTypeMap("tex", "v", "<C-J>", [[di\textit{}<esc>hp]])
FileTypeMap("tex", "i", "<C-J>", [[\textit{}<esc>i]])
FileTypeMap("html", "v", "<C-B>", [[di<lt>strong><lt>/strong><esc>9hp]])
FileTypeMap("html", "i", "<C-B>", [[<lt>strong><lt>/strong><esc>8hi]])
FileTypeMap("html", "v", "<C-J>", [[di<lt>em><lt>/em><esc>5hp]])
FileTypeMap("html", "i", "<C-J>", [[<lt>em><lt>/em><esc>4hi]])

-- Compile/run stuff on Ctrl+P
FileTypeMap("tex", "n", "<C-P>", ":wa <bar> !latexmk -pdf %<CR>")
FileTypeMap("markdown", "n", "<C-P>", ":wa <bar> !pandoc -s -o %:r.pdf %<CR>")
FileTypeMap("python", "n", "<C-P>", ":wa <bar> !python %<CR>")

-- Only on OSX
if os.capture('uname -s') == "Darwin" then
  require("soumilm.stripe")
end

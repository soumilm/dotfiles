return {
  -- Try to keep this list ASCIIbetized

  { "Raimondi/delimitMate", lazy = false },               -- automatically close quotes, parens, etc
  { "SirVer/ultisnips", lazy = false },                   -- configurable tab-completed ultisnips
  { "airblade/vim-gitgutter", lazy = false },             -- show diff icons on the left
  { "christoomey/vim-tmux-navigator", lazy = false },     -- Ctrl+{h,j,k,l} navigates consistently across tmux and vim
  {
    "cocopon/iceberg.vim",                                -- theme
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme "iceberg"]])
    end,
  },
  {
    "fatih/vim-go",                                       -- golang miscellany
    lazy = false,
    ft = "go",
  },
  { "google/vim-searchindex", lazy = false },             -- add count and index when searching
  { "honza/vim-snippets", lazy = false },                 -- adds snippets for UltiSnips
  {
    "ibhagwan/fzf-lua",                                   -- fuzzy file finder
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      "fzf-vim",
      files = {
        git_icons = false,
      },
    },
  },
  { "jparise/vim-graphql", lazy = false },                -- GraphQL syntax
  { "leafgarland/typescript-vim", lazy = false },         -- TypeScript syntax
  { "mattesgroeger/vim-bookmarks", lazy = false },        -- bookmarks for lines
  { "maxmellon/vim-jsx-pretty", lazy = false },           -- JS and JSX syntax
  { "mhinz/vim-startify", lazy = false },                 -- fancy start screen for vim
  { "neovim/nvim-lspconfig", lazy = false },              -- LSP
  {
    "nvim-lualine/lualine.nvim",                          -- status line
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  { "sbdchd/neoformat", lazy = false },                   -- formatter
  { "simnalamburt/vim-mundo", lazy = false },
  { "tpope/vim-fugitive", lazy = false },                 -- git commands
  { "tpope/vim-vinegar", lazy = false },                  -- file navigation
  { "vim-python/python-syntax", lazy = false },           -- for f-strings
  { "yegappan/mru", lazy = false },                       -- see most recently used files
}

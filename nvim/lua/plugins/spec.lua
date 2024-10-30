return {
  -- Try to keep this list ASCIIbetized

  { "Raimondi/delimitMate" },               -- automatically close quotes, parens, etc
  { "SirVer/ultisnips" },                   -- configurable tab-completed ultisnips
  { "airblade/vim-gitgutter" },             -- show diff icons on the left
  { "christoomey/vim-tmux-navigator" },     -- Ctrl+{h,j,k,l} navigates consistently across tmux and vim
  {
    "cocopon/iceberg.vim",                  -- theme
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme "iceberg"]])
    end,
  },
  {
    "fatih/vim-go",                         -- golang miscellany
    ft = "go",
  },
  { "google/vim-searchindex" },             -- add count and index when searching
  { "honza/vim-snippets" },                 -- adds snippets for UltiSnips
  {
    "ibhagwan/fzf-lua",                     -- fuzzy file finder
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      "fzf-vim",
      files = {
        git_icons = false,
      },
    },
  },
  { "jparise/vim-graphql" },                -- GraphQL syntax
  { "leafgarland/typescript-vim" },         -- TypeScript syntax
  { "mattesgroeger/vim-bookmarks" },        -- bookmarks for lines
  { "maxmellon/vim-jsx-pretty" },           -- JS and JSX syntax
  { "mhinz/vim-startify" },                 -- fancy start screen for vim
  { "neovim/nvim-lspconfig" },              -- LSP
  {
    "nvim-lualine/lualine.nvim",            -- status line
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  { "sbdchd/neoformat" },                   -- formatter
  { "simnalamburt/vim-mundo" },
  { "tpope/vim-fugitive" },                 -- git commands
  { "tpope/vim-vinegar" },                  -- file navigation
  { "vim-python/python-syntax" },           -- for f-strings
  { "yegappan/mru" },                       -- see most recently used files
}

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
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      local lspkind = require("lspkind")
      local formatting = {
        -- Taken from stevearc
        format = lspkind.cmp_format({
          mode = "symbol",
          symbol_map = {
            Copilot = " ",
            Class = "󰆧 ",
            Color = "󰏘 ",
            Constant = "󰏿 ",
            Constructor = " ",
            Enum = " ",
            EnumMember = " ",
            Event = "",
            Field = " ",
            File = "󰈙 ",
            Folder = "󰉋 ",
            Function = "󰊕 ",
            Interface = " ",
            Keyword = "󰌋 ",
            Method = "󰊕 ",
            Module = " ",
            Operator = "󰆕 ",
            Property = " ",
            Reference = "󰈇 ",
            Snippet = " ",
            Struct = "󰆼 ",
            Text = "󰉿 ",
            TypeParameter = "󰉿 ",
            Unit = "󰑭",
            Value = "󰎠 ",
            Variable = "󰀫 ",
          },
          menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[api]",
            path = "[path]",
            luasnip = "[snip]",
          },
        }),
      }

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = {
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<CR>"] = cmp.mapping(function()
            cmp.confirm( {select=true} )
          end)
        },
      })
    end,
    dependencies = {
      -- Autocompletion
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",

      -- Snippets
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
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

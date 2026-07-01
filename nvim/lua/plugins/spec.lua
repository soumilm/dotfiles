return {
  -- Try to keep this list ASCIIbetized

  {
    "MeanderingProgrammer/render-markdown.nvim",  -- pretty in-buffer markdown rendering
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" },
    opts = {
      heading = {
        -- Show the literal '#', '##', ... instead of the default circled icons.
        icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
        -- No background bar; the heading text itself carries the color (+ bold).
        backgrounds = {},
        -- One distinct color per level, borrowed from existing theme groups (so
        -- it adapts to the colorscheme instead of hardcoding hex). Colors the
        -- icon here; the config function reuses this list to color the text.
        foregrounds = { "Title", "Function", "String", "Constant", "Special", "DiagnosticError" },
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      -- Style bold text and headings. Bold text (@markup.strong) just gets a
      -- bold weight. Each heading level gets a bold weight plus a distinct
      -- color taken from opts.heading.foregrounds[level] (an existing theme
      -- group), so heading text is colored per level without hardcoding hex.
      local palette = opts.heading.foregrounds
      local function bold_markdown()
        local strong = vim.api.nvim_get_hl(0, { name = "@markup.strong", link = false })
        if next(strong) ~= nil then
          strong.bold = true
          vim.api.nvim_set_hl(0, "@markup.strong", strong)
        end
        for i = 1, 6 do
          local color = vim.api.nvim_get_hl(0, { name = palette[i], link = false })
          for _, group in ipairs({ "@markup.heading." .. i .. ".markdown", "markdownH" .. i }) do
            local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
            if next(hl) ~= nil then
              hl.bold = true
              if color.fg then hl.fg = color.fg end
              vim.api.nvim_set_hl(0, group, hl)
            end
          end
        end
      end
      -- These groups only exist once a markdown buffer loads, so (re)apply on
      -- FileType and after any colorscheme change.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function() vim.schedule(bold_markdown) end,
      })
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function() vim.schedule(bold_markdown) end,
      })
    end,
    keys = {
      { "<leader>m", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Toggle Markdown rendering" },
    },
  },
  { "Raimondi/delimitMate" },               -- automatically close quotes, parens, etc
  {
    "SirVer/ultisnips",                     -- configurable tab-completed ultisnips
    cmd = "UltiSnips",
    ft = {
      "html",
    },
  },
  { "airblade/vim-gitgutter" },             -- show diff icons on the left
  { "christoomey/vim-tmux-navigator" },     -- Ctrl+{h,j,k,l} navigates consistently across tmux and vim
  {
    "cocopon/iceberg.vim",                  -- theme
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme "iceberg"]])
    end,
  },
  { "duane9/nvim-rg" },
  {
    "fatih/vim-go",                         -- golang miscellany
    ft = "go",
  },
  {
    "folke/trouble.nvim",                   -- diagnostics
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  { "google/vim-searchindex" },             -- add count and index when searching
  { "hashivim/vim-terraform" },
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

      local confirm = function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        elseif luasnip.expandable() then
          luasnip.expand()
        else
          fallback()
        end
      end

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "ultisnips" },
          { name = "buffer" },
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = {
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<CR>"] = cmp.mapping(confirm),
        },
      })
    end,
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
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
    },
    config = function()
      local telescope = require("telescope")

      -- Transform "82 file:foo file:bar" -> "82" -g "*foo*" ... -g "*bar*" ...
      -- Also: "foo bar" -> "foo.*bar" (spaces become .* unless quoted)
      local function transform_file_pattern(prompt)
        -- Collect all file: patterns
        local globs = {}
        for pattern in prompt:gmatch("file:(%S+)") do
          table.insert(globs, string.format('-g "*%s*"', pattern))
          table.insert(globs, string.format('-g "*%s*/**"', pattern))
          table.insert(globs, string.format('-g "**/*%s*/**"', pattern))
        end

        -- Remove all file:xxx from prompt and trim
        local search_part = prompt:gsub("file:%S+", ""):match("^%s*(.-)%s*$")

        -- If not already quoted, replace spaces with .* and quote
        if search_part ~= "" and not search_part:match('^"') and not search_part:match("^-") then
          search_part = '"' .. search_part:gsub("%s+", ".*") .. '"'
        end

        if #globs == 0 then
          return search_part
        end

        return search_part .. " " .. table.concat(globs, " ")
      end

      telescope.setup({
        extensions = {
          live_grep_args = {
            auto_quoting = true,
            on_input_filter_cb = function(prompt)
              return { prompt = transform_file_pattern(prompt) }
            end,
          },
        },
      })

      telescope.load_extension("live_grep_args")
      vim.keymap.set("n", "<leader>g", telescope.extensions.live_grep_args.live_grep_args)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",      -- parsers (needed for markdown rendering)
    branch = "master",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "markdown", "markdown_inline" },
      highlight = {
        -- Only treesitter-highlight markdown; every other filetype keeps its
        -- existing vim syntax / dedicated plugin. render-markdown needs
        -- treesitter highlighting active to align tables whose cells contain
        -- concealed markup (e.g. **bold**), and to expose the @markup.* groups.
        enable = true,
        disable = function(lang)
          return lang ~= "markdown" and lang ~= "markdown_inline"
        end,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  { "sbdchd/neoformat" },                   -- formatter
  { "simnalamburt/vim-mundo" },
  { "sindrets/diffview.nvim"},
  { "tpope/vim-fugitive" },                 -- git commands
  { "tpope/vim-vinegar" },                  -- file navigation
  { "vim-python/python-syntax" },           -- for f-strings
  { "yegappan/mru" },                       -- see most recently used files
}

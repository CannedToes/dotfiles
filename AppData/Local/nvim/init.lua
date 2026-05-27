-- <options> --
vim.loader.enable()
vim.cmd([[hi @lsp.type.number gui=bold]])
vim.cmd([[set noswapfile]])
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.breakindent = true
vim.opt.cursorcolumn = false
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 2
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.wrap = false

-- <keymaps> --
vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Write buffer" })
vim.keymap.set("n", "<leader>so", "<cmd>source $MYVIMRC<cr>", { desc = "Source config" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right window" })

-- <autocmds> --
local augroup = vim.api.nvim_create_augroup("my.config", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "markdown", "text", "gitcommit", "typst" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

-- <plugins> --
vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/L3MON4D3/LuaSnip",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/chomosuke/typst-preview.nvim",
  "https://github.com/loctvl842/monokai-pro.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/stevearc/quicker.nvim",
})

-- <theme> --
require("monokai-pro").setup({ filter = "classic" })
vim.cmd.colorscheme("monokai-pro-classic")

-- <ui> --
require("mini.ai").setup({})
require("mini.bracketed").setup({})
require("mini.diff").setup()
require("mini.git").setup()
require("mini.operators").setup({})
require("mini.pairs").setup({})
require("mini.surround").setup({})
require("mini.trailspace").setup({})
require("mini.statusline").setup({})

require("luasnip").setup({ enable_autosnippets = true })

-- <treesitter> --
local basic_parsers =
  { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc" }
require("nvim-treesitter").install(basic_parsers)

local function treesitter_try_attach(buf, language)
  if not vim.treesitter.language.add(language) then
    return
  end

  vim.treesitter.start(buf, language)

  if vim.treesitter.query.get(language, "indents") then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

local available_parsers = require("nvim-treesitter").get_available()
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  callback = function(args)
    local language = vim.treesitter.language.get_lang(args.match)
    if not language then
      return
    end

    local installed_parsers = require("nvim-treesitter").get_installed("parsers")

    if vim.tbl_contains(installed_parsers, language) then
      treesitter_try_attach(args.buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      require("nvim-treesitter").install(language):await(function()
        treesitter_try_attach(args.buf, language)
      end)
    else
      treesitter_try_attach(args.buf, language)
    end
  end,
  desc = "Install and start Treesitter parsers by filetype",
})

require("quicker").setup({})

require("mason").setup({})

require("oil").setup({
  default_file_explorer = true,
  view_options = { show_hidden = true },
  lsp_file_methods = {
    enabled = true,
    timeout_ms = 1000,
    autosave_changes = true,
  },
  columns = {
    "icon",
  },
  float = {
    max_width = 0.3,
    max_height = 0.6,
  },
})
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open parent directory" })

require("flash").setup({})
vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
vim.keymap.set("c", "<C-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })

-- <search> --
require("fzf-lua").setup({ "default" })
vim.keymap.set("n", "<leader>ff", function()
  require("fzf-lua").files()
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function()
  require("fzf-lua").live_grep()
end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", function()
  require("fzf-lua").buffers()
end, { desc = "Find buffers" })

-- <completion> --
require("blink.cmp").setup({
  keymap = { preset = "default" },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },
  sources = {
    default = { "lsp", "path", "snippets" },
  },
  snippets = { preset = "luasnip" },
  fuzzy = { implementation = "lua" },
  signature = { enabled = true },
})

-- <lsp> --
vim.lsp.enable({
  "lua_ls",
  "rust_analyzer",
  "nixd",
  "basedpyright",
  "clangd",
  "zls",
  "tinymist",
  "ruff",
  "glsl_analyzer",
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

-- <formatting> --
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    nix = { "nixfmt" },
    python = { "isort", "ruff_format" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    zig = { "zigfmt" },
    typst = { "typstyle" },
  },
})

vim.keymap.set("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

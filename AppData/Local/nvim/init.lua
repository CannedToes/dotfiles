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
vim.opt.updatetime = 250
vim.opt.wrap = false

-- <completion>
vim.opt.completeopt = { "menuone", "noselect", "popup" }

-- <keymaps> --
vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Write buffer" })
vim.keymap.set("n", "<leader>so", "<cmd>source $MYVIMRC<cr>", { desc = "Source config" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right window" })

vim.keymap.set("i", "<C-Space>", function()
  vim.lsp.completion.get()
end, { desc = "Trigger completion" })

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
  "https://github.com/chomosuke/typst-preview.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/loctvl842/monokai-pro.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/romus204/tree-sitter-manager.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/vague-theme/vague.nvim",
})

-- <theme> --
require("vague").setup({})
vim.cmd.colorscheme("vague")

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

-- <treesitter> --
require("tree-sitter-manager").setup({
  ensure_installed = {
    "bash",
    "diff",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "json",
    "jsonc",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "nix",
    "query",
    "regex",
    "toml",
    "vim",
    "vimdoc",
    "yaml",
  },
  auto_install = true,
})

require("oil").setup({})
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open parent directory" })

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
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, {
        autotrigger = true,
      })
    end

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
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })

local Util = require("lazyvim.util")

return {
  -- disable plugins
  { "echasnovski/mini.pairs", enabled = false },
  { "JoosepAlviste/nvim-ts-context-commentstring", enabled = false },
  { "echasnovski/mini.surround", enabled = false },
  { "echasnovski/mini.ai", enabled = false },
  { "echasnovski/mini.bufremove", enabled = false },

  -- configure plugins
  { "tpope/vim-commentary" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { "christoomey/vim-tmux-navigator" },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "go",
        "html",
        "javascript",
        "json",
        "kotlin",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "sql",
        "starlark",
        "terraform",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
}

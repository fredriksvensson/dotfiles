return {
  "epwalsh/obsidian.nvim",
  version = "v2.2.0",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>os",
      "<cmd>ObsidianSearch<cr>",
      desc = "Search Obsidian file",
    },
    {
      "<leader>on",
      "<cmd>ObsidianNew<cr>",
      desc = "New Obsidian file",
    },
  },
  opts = {
    nvim_cmp = true,

    workspaces = {
      {
        name = "work",
        path = "~/vaults/work",
      },
    },
  },
}

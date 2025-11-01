return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- Shows filtered items but dimmed
        hide_dotfiles = false, -- Shows dot files
        hide_gitignored = false, -- Shows gitignored files
      },
    },
  },
}

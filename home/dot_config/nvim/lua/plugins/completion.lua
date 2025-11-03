-- Completion configuration
return {
  -- Configure blink.cmp (LazyVim default)
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      enabled = function()
        -- Disable in markdown files
        return vim.bo.filetype ~= "markdown"
      end,
    },
  },

  -- Fallback: Configure nvim-cmp if it's being used instead
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      opts.enabled = function()
        -- Disable in markdown files
        return vim.bo.filetype ~= "markdown"
      end
      return opts
    end,
  },
}

-- Chezmoi template support using Go template parser with language injections
return {
  -- Add Go template (gotmpl) parser and common base languages for Chezmoi templates
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Ensure parsers for gotmpl and common base languages used in dotfiles
      vim.list_extend(opts.ensure_installed, {
        "gotmpl", -- Go template syntax (used by Chezmoi)
        "bash", -- For .sh.tmpl files
        "json", -- For .json.tmpl files
        "yaml", -- For .yaml.tmpl files
        "toml", -- For .toml.tmpl files
      })
    end,
  },
}

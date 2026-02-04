return function()
  -- In Neovim 0.10+, treesitter highlighting is built-in and enabled automatically
  -- nvim-treesitter is now mainly just a parser manager
  
  local pb = Config.common.pb

  local custom_parsers = {
    haxe = {
      install_info = {
        url = "https://github.com/vantreeseba/tree-sitter-haxe",
        branch = "main",
      },
      filetype = "haxe",
    },
  }

  -- Register custom parsers (if needed in the future)
  vim.api.nvim_create_autocmd('User', {
    pattern = 'TSUpdate',
    callback = function()
      local ok, parsers = pcall(require, 'nvim-treesitter.parsers')
      if ok then
        for lang, config in pairs(custom_parsers) do
          parsers[lang] = config
        end
      end
    end,
  })

  -- Map filetypes to TS parsers
  vim.treesitter.language.register("glimmer", "handlebars")

  -- Configure which languages should NOT use treesitter highlighting
  local disabled_languages = {
    "latex",
    "comment",
    "haxe",
  }

  -- Disable treesitter for specific languages or large files
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local bufnr = args.buf
      local lang = vim.treesitter.language.get_lang(args.match)
      
      -- Disable for large files (> 320 KB)
      local kb = Config.common.utils.buf_get_size(bufnr)
      if kb > 320 then
        vim.treesitter.stop(bufnr)
        return
      end

      -- Disable for specific languages
      if lang and vim.tbl_contains(disabled_languages, lang) then
        vim.treesitter.stop(bufnr)
        return
      end

      -- Explicitly enable for all other languages
      pcall(vim.treesitter.start, bufnr, lang)
    end,
  })

  -- For nvim-ts-autotag support (if installed)
  local ok, _ = pcall(require, "nvim-ts-autotag")
  if ok then
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
    })
  end
end

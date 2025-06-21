-- Autoformatting setup using conform.nvim + mason
return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        -- Enable format on save
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        -- Define which formatter to use per filetype
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          javascriptreact = { "prettier" },
          json = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          markdown = { "prettier" },
          yaml = { "prettier" },
          go = { "goimports", "gofmt" },
          python = { "black" },
          sh = { "shfmt" },
          cpp = { "clang-format" },
          c = { "clang-format" },
          java = { "clang-format" },
        },
      })

      -- Optional: manual format
      vim.keymap.set("n", "<leader>f", function()
        require("conform").format({ async = true })
      end, { desc = "Format buffer" })

      -- Optional: <C-s> to format and save
      vim.keymap.set("n", "<C-s>", function()
        require("conform").format({ async = true, lsp_fallback = true })
        vim.cmd("w")
      end, { desc = "Format and Save", silent = true })

      vim.keymap.set("i", "<C-s>", function()
        vim.cmd("stopinsert")
        require("conform").format({ async = true, lsp_fallback = true })
        vim.cmd("w")
      end, { desc = "Format and Save", silent = true })
    end,
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier",
          "stylua",
          "black",
          "clang-format",
          "shfmt",
          "gofmt",
          "goimports",
        },
        auto_update = true,
        run_on_start = true,
      })
    end,
  },
}

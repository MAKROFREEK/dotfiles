-- Organize imports before save (LSPs that support it; others no-op)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" }, diagnostics = {} },
      apply = true,
    })
  end,
})

-- Rust: inlay hints on attach, guidance keymaps buffer-local
vim.api.nvim_create_autocmd("LspAttach", {
  pattern = "*.rs",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil or client.name ~= "rust_analyzer" then return end

    vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })

    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
    vim.keymap.set("n", "<leader>ih", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
    end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
  end,
})

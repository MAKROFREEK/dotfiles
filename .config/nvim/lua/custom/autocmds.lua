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

-- Rust: guidance keymaps buffer-local
vim.api.nvim_create_autocmd("LspAttach", {
  pattern = "*.rs",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil or client.name ~= "rust_analyzer" then return end

    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
  end,
})

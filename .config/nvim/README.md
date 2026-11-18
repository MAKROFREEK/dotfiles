# Neovim Config

Structure:

```
init.lua            -- bootstraps lazy.nvim, requires custom/
lua/custom/
  init.lua          -- loads options → plugins → autocmds
  options.lua       -- vim options
  plugins.lua       -- all plugin specs
  autocmds.lua      -- autocmds + Rust LSP keymaps
```

## Plugins

**Editing**
- `vim-visual-multi` — multi-cursor (`Ctrl`+click to select, `n` next match)
- `vim-surround` — text objects for quotes/brackets (`cs"'`, `ysiw)`)
- `vim-commentary` — `gcc` toggle line comment, `gc` motion

**Fuzzy finder**
- `fzf-lua` — file finder on `<C-f>`. Lazy-loads: the plugin loads on the first press, not at startup. The keybinding lives in its spec in `plugins.lua`.

**Completion**
- `blink.cmp` — completion engine with built-in Rust fuzzy matcher. Sources: snippets → LSP → path → buffer. Keymap preset `enter`:
  - `<CR>` accept selected item
  - `<Tab>` / `<S-Tab>` — navigate completion menu; when no menu is open, jump snippet tabstops
  - `<C-Space>` show menu, `<C-e>` hide, `<C-k>` signature help
  - Snippets come from `friendly-snippets`, expanded by Neovim's native snippet engine (no LuaSnip).

**LSP / tooling**
- `mason.nvim` + `mason-lspconfig` — installer. Default handler starts servers via lspconfig; `rust_analyzer` is skipped there because rustaceanvim owns it.
- `nvim-lspconfig` — LSP configs (used for `lua_ls` etc.).
- `rustaceanvim` — rust-analyzer integration for Rust. Configured in `plugins.lua`:
  - `check = clippy`, `checkOnSave = true` — clippy lints as diagnostics on save (set via `vim.lsp.config`, since nvim-lspconfig's defaults would otherwise override it)
  - codelldb debug adapter (Linux `liblldb.so` path)
- `rust.vim` — Rust syntax + `rustfmt` on save
- `crates.nvim` — `Cargo.toml` completion/hover via an in-process LSP (picked up by blink's `lsp` source)

**Debugging**
- `nvim-dap` + `nvim-dap-ui` — dap UI opens/closes with the debug session

**UI**
- `which-key.nvim` — keymap hints (`timeoutlen` = 300ms)
- `fidget.nvim` — LSP progress notifications

## Rust workflow

- Save → format (rustfmt) + organize imports + clippy diagnostics
- Inlay hints on by default, buffer-local maps in `.rs` files:

| Key | Action |
|---|---|
| `K` | hover docs (hover actions via rustaceanvim) |
| `<leader>ca` | code actions (apply clippy fixes) |
| `gr` | references |
| `<leader>rn` | rename |
| `<leader>ih` | toggle inlay hints |

`<leader>` = default (space).

## Other autocmds

- `BufWritePre` — `source.organizeImports` code action before every save (servers that support it; others no-op).

## Commands

- `:Lazy sync` — install/update/remove plugins from specs.

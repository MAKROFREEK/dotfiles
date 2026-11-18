require("lazy").setup({
  -- Visual & Editing
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()
      -- Example VSCode-like Ctrl+n mapping:
      vim.keymap.set({ "n", "x" }, "<C-n>", function() mc.matchAddCursor(1) end)
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  -- Fuzzy Finder (lazy: loads on first <C-f> press)
  {
    "ibhagwan/fzf-lua",
    lazy = true,
    keys = { { "<C-f>", "<cmd>FzfLua files<cr>", desc = "Fuzzy find files" } },
  },
  -- LSP, Mason, DAP, Formatting, Linting, etc.
  { "williamboman/mason.nvim", config = true },
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
        handlers = {
          function(server_name)
            -- rustaceanvim owns rust_analyzer; don't double-setup
            if server_name == "rust_analyzer" then return end
            lspconfig[server_name].setup({})
          end,
        },
      })
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = "rust",
    config = function ()
      local mason_registry = require('mason-registry')
      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      -- Linux: liblldb.so (the .dylib was macOS-only)
      local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

      -- Set vim.g BEFORE requiring rustaceanvim.config — the plugin caches its
      -- config at require time; setting after is silently ignored
      vim.g.rustaceanvim = {}

      -- nvim 0.12: lspconfig's rust_analyzer definition overrides rustaceanvim's
      -- server.settings at merge time, so set check via vim.lsp.config instead
      -- (definitions are deep-merged by vim.lsp.config)
      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            -- Clippy lints as diagnostics after save
            check = {
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            checkOnSave = true,
          },
        },
      })

      local cfg = require('rustaceanvim.config')
      vim.g.rustaceanvim.dap = {
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
      }
    end
  },

  {
    'mfussenegger/nvim-dap',
    config = function()
			local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
		end,
  },

    {
    'rcarriga/nvim-dap-ui', 
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
			require("dapui").setup()
		end,
  },

  {
	  'rust-lang/rust.vim',
	  ft = "rust",
	  init = function()
		  vim.g.rustfmt_autosave = 1
	  end
  },

  -- Helps with crates versions
    {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function()
      require("crates").setup {
        -- In-process LSP: blink picks these completions up via its 'lsp' source
        lsp = {
          enabled = true,
          completion = true,
        },
      }
    end
  },

  -- Completion Engine (native snippet engine, friendly-snippets loaded directly)
  {
    'saghen/blink.cmp',
    dependencies = {
      'saghen/blink.lib',
      'rafamadriz/friendly-snippets',
    },
    build = function()
      require('blink.cmp').build():pwait()
    end,
    opts = {
      keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      },
      sources = {
        default = { 'snippets', 'lsp', 'path', 'buffer' },
      },
      completion = {
        documentation = { auto_show = true },
      },
      signature = { enabled = true },
      fuzzy = { implementation = 'rust' },
    },
  },

  -- UI & Formatting
  {
    "folke/which-key.nvim",
    lazy = false, -- Ensures it loads during startup before VimEnter
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup()
    end,
  },
  -- Corner Notifications
  {
  "j-hui/fidget.nvim",
  opts = {
    -- options
  },
},
})

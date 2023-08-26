-- add `rust_analyzer` to `skipped_servers` list
lvim.lsp.installer.setup.automatic_installation = false
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

--
-- ---------------------------------------------------------- --
-- ---------------------------------------------------------- --
-- NEOVIDE                                                    --
-- ---------------------------------------------------------- --
-- ---------------------------------------------------------- --

vim.cmd("let g:neovide_hide_mouse_when_typing = 1")
vim.cmd("let g:neovide_fullscreen=v:true")
-- vim.cmd("let g:neovide_transparency=0.9")
-- vim.cmd("let g:neovide_cursor_animation_length=0.13")
-- vim.cmd("let g:neovide_cursor_trail_length=0.8")
-- vim.cmd("let g:neovide_cursor_vfx_mode=\"pixiedust\"") -- railgun, torpedo, pixiedust, sonicboom, ripple, wireframe
-- vim.cmd("let g:neovide_cursor_vfx_opacity=200.0")
-- vim.cmd("let g:neovide_cursor_vfx_particle_lifetime=1.2")
-- vim.cmd("let g:neovide_cursor_vfx_particle_density=7.0")
-- vim.cmd("let g:neovide_cursor_vfx_particle_speed=10.0")
-- vim.cmd("let g:neovide_cursor_vfx_particle_phase=1.5")
-- vim.cmd("let g:neovide_cursor_vfx_particle_curl=1.0")

-- ---------------------------------------------------------- --
-- ---------------------------------------------------------- --
-- VIM                                                        --
-- ---------------------------------------------------------- --
-- ---------------------------------------------------------- --

vim.opt.cmdheight = 1
vim.opt.scrolloff = 10
vim.cmd("set guifont=\"Fira Code Nerd Font\"")
vim.cmd("set colorcolumn=101")
-- Trying to make rustfmt work in lvim...
-- vim.cmd("set autoread")
-- vim.cmd("au CursorHold * checktime")

-- ---------------------------------------------------------- --
-- ---------------------------------------------------------- --
-- LUNARVIM                                                   --
-- ---------------------------------------------------------- --
-- ---------------------------------------------------------- --

-- General
lvim.leader = "space"
lvim.colorscheme = "catppuccin-latte"
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.telescope.defaults.layout_config.width = 0.9
lvim.builtin.telescope.defaults.prompt_prefix = "  "
lvim.builtin.telescope.defaults.selection_caret = "  "
lvim.builtin.cmp.mapping["<Tab>"] = require('cmp').mapping.confirm({ select = true })
lvim.format_on_save = true
lvim.builtin.indentlines.active = false

-- Plugins
lvim.plugins = {
  { "lunarvim/colorschemes" },
  { "folke/tokyonight.nvim" },
  { "rafamadriz/neon" },
  { "catppuccin/nvim" },
  { "dracula/vim" },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function() require("hop").setup() end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = {'<M-S-j>', '<M-S-k>', '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
        hide_cursor          = true,  -- Hide cursor while scrolling
        stop_eof             = true,  -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff  = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff    = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true,  -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function      = nil,   -- Default easing function
        pre_hook             = nil,   -- Function to run before the scrolling animation starts
        post_hook            = nil,   -- Function to run after the scrolling animation ends
      })

      -- Additional mappings
      local mappings = {}
      mappings['<M-S-k>'] = {'scroll', {'-vim.wo.scroll', 'true', '200'}} -- up
      mappings['<M-S-j>'] = {'scroll', { 'vim.wo.scroll', 'true', '200'}} -- down
      require('neoscroll.config').set_mappings(mappings)
    end
  },
  { "jparise/vim-graphql" },
  { "mustache/vim-mustache-handlebars" }
}

-- Formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { exe = "rustfmt", filetypes = { "rust", "rs" } },
}

-- Bindings
lvim.keys.normal_mode["<M-h>"]     = ":HopChar2<CR>"   -- Alt h         : hop!
lvim.keys.normal_mode["<M-l>"]     = ":vsplit<CR>"     -- Alt l         : split vertical
lvim.keys.normal_mode["<M-q>"]     = ":close<CR>"      -- Alt q         : close window
lvim.keys.normal_mode["<M-w>"]     = ":bdelete<CR>"    -- Alt w         : close buffer
lvim.keys.normal_mode["<M-s>"]     = ":w<CR>"          -- Alt s         : save
lvim.keys.normal_mode["<S-l>"]     = ":bnext<CR>"      -- Ctrl Tab      : next tab
lvim.keys.normal_mode["<S-h>"]     = ":bprevious<CR>"  -- Ctrl Shift Tab: previous tab
-- lvim.keys.normal_mode["<M-S-j>"]   = "<C-d>"           -- Alt Shift j   : scroll half down -- See neoscroll config
-- lvim.keys.normal_mode["<M-S-k>"]   = "<C-u>"           -- Alt Shift k   : scroll half up   -- See neoscroll config
-- lvim.keys.normal_mode["<Tab>"]     = ":wincmd w<CR>"   -- Tab           : switch window    => Ctrl  h/l

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<M-j>"] = actions.move_selection_next,
    ["<M-k>"] = actions.move_selection_previous,
    ["<M-n>"] = actions.cycle_history_next,
    ["<M-p>"] = actions.cycle_history_prev,
  },
  n = {
    ["<M-j>"] = actions.move_selection_next,
    ["<M-k>"] = actions.move_selection_previous,
  },
}

-- Status line
-- see https://www.lunarvim.org/configuration/06-statusline.html
-- see https://github.com/nvim-lualine/lualine.nvim
local line = require("lvim.core.lualine.components")
lvim.builtin.lualine.style = "lvim" -- "lvim", default", "none"
lvim.builtin.lualine.options = {
  section_separators = { left = '', right = ''},
  component_separators = { left = '', right = ''},
}
lvim.builtin.lualine.sections = {
  lualine_a = { line.mode },
  lualine_b = { line.branch, line.diagnostics},
  lualine_c = { line.filename },
  lualine_x = {},
  lualine_y = {},
  lualine_z = {}
}

require("user.options")
require("user.keymaps")
require("user.autocmd")

require("user.lsp")

-- NOTE: all modules are disabled by default and need to be activated explicitly
require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = false,
        ignore_install = { "latex" },
    }
}

-- This is assuming that zathura is installed, otherwise it defaults to the system PDF viewer.
vim.g.vimtex_view_method = 'zathura'

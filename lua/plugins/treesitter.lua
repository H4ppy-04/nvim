-- NOTE: all modules are disabled by default and need to be activated explicitly
require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        ignore_install = { "latex" },
    }
}

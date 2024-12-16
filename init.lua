require "user.options"
require "user.keymaps"
require "user.autocmd"
require "user.plug"

require "plugins.telescope"
require "plugins.treesitter"
require "plugins.vimtex"
require "plugins.vimwiki"
require "plugins.lsp"

if vim.env.TERM == "tmux-256color" then
    vim.o.termguicolors = true
elseif vim.env.TERM == "linux" or vim.env.TERM == "tmux-256color" then
    vim.cmd.colorscheme "vim"
end

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*.plaintex",
    command = "set syntax=latex"
})

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
    callback = function(_)
        vim.cmd.colorscheme "vim"
        vim.o.expandtab = false
        vim.o.tabstop = 8
        vim.o.softtabstop = 2
        vim.o.shiftwidth = 2
    end
})

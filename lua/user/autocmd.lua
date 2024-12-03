vim.api.nvim_create_autocmd(
    { 'TextYankPost' }, {
        group = vim.api.nvim_create_augroup("HighlightYank", { clear = false }),
        pattern = '.*',
        callback = function()
            vim.highlight.on_yank({
                higroup = 'IncSearch',
                timeout = 25
            })
        end,
        desc = 'Show matching highlighted text on yank'
    })


vim.api.nvim_create_autocmd({ "OptionSet", "ColorScheme" }, {
    pattern = { "background", "bg" },
    callback = function(event)
        if vim.g.colors_name == "vim" and event.event == "OptionSet" then
            if event.option_new == "light" then
                -- vim.api.nvim_set_hl(0, 'Normal', { fg = 'black', bg = 'white' })
            end
        end
        if vim.g.colors_name == "vim" and vim.o.background == "dark" then
            -- vim.api.nvim_set_hl(0, 'Pmenu', { fg = 'white', bg = 'black' })
        end
    end
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function(_)
        local lxterm = vim.system({'pidof', 'lxterminal'}, { text = true }):wait()
        local gnome = vim.system({'pidof', 'gnome-terminal-server', 'gnome-terminal'}, { text = true }):wait()

        vim.o.termguicolors = false

        if lxterm.code == 0 then
            vim.cmd.colorscheme "vim"
            vim.o.termguicolors = true
        elseif gnome.code == 0 then
            vim.cmd.colorscheme "default"
        end
    end,
})

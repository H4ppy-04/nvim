local globals = {
    mapleader = ' ',
    netrw_banner = 0,  -- supress banner
    netrw_winsize = 45 -- for 45% of the window
}

for k, v in pairs(globals) do
    vim.g[k] = v
end

local opts = {
    {
        tabstop = 4,
        softtabstop = 4,
        shiftwidth = 4,
        expandtab = true
    },
    {
        swapfile = false,
        backup = false,
        undofile = false
    },
    {
        hlsearch = true,
        incsearch = true,
    },
    {
        updatetime = 50 -- time format is in milliseconds
    },
    {
        -- FIXME: needs to be checked with `vim.fn.isdirectory(...)`
        directory = vim.fs.normalize('~/.cache/nvim'),
        shadafile = vim.fs.normalize('~/.cache/nvim/viminfo'),
    },
    {
        scrolloff = 8,
        colorcolumn = '80',
        wrap = false,
    },
    {
        number = true,
        relativenumber = true
    }
}

for _, group in pairs(opts) do
    for k, v in pairs(group) do
        vim.opt[k] = v
    end
end

-- determines what is or isn't a valid file name
vim.opt.isfname:append('@-@')


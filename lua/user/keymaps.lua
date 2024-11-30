local maps = {
    { { 'n' }, '<leader>ex', vim.cmd.Ex, { remap = false } },
    { { 'i' }, '<C-c>',      '<Esc>',    { remap = false } },
}

for _, v in pairs(maps) do
    vim.keymap.set(unpack(v))
end

local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('junegunn/fzf', {
    ['dir'] = '~/Programs/cli_tools/fzf',
    ['do'] = function()
        vim.fn['fzf#install']()
    end
})

Plug('nvim-telescope/telescope-fzf-native.nvim', {
    ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
})

Plug('nvim-telescope/telescope.nvim', {
    ['tag'] = '0.1.8'
})

Plug('nvim-lua/plenary.nvim')

Plug('vimwiki/vimwiki')

vim.call('plug#end')

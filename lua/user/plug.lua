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

Plug 'https://github.com/nvim-treesitter/nvim-treesitter'

Plug('nvim-lua/plenary.nvim')

Plug('vimwiki/vimwiki')

Plug 'wakatime/vim-wakatime'

Plug 'junegunn/vader.vim'

Plug 'SirVer/ultisnips'

-- Snippets & Co.
Plug 'ckunte/latex-snippets-vim'
Plug 'lervag/vimtex'
Plug 'honza/vim-snippets'

-- lsp stuff
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

-- format haskell files on write
Plug 'https://github.com/alx741/vim-hindent'

vim.call('plug#end')

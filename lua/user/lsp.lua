vim.api.nvim_create_autocmd(
    { 'LspAttach' }, {
        callback = function(event)
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client ~= nil then
                if client.server_capabilities.definitionProvider then
                    vim.bo[event.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
                end
                if client.server_capabilities.completionProvider then
                    vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                    local maps = {
                        { 'n', 'gd',         function() vim.lsp.buf.definition() end,              { noremap = true, silent = true } },
                        { 'n', 'K',          function() vim.lsp.buf.hover() end,                   { noremap = true, silent = true } },
                        { 'n', '<leader>ca', function() vim.lsp.buf.code_action() end,             { noremap = true } },
                        { 'n', 'gr',         function() vim.lsp.buf.references() end,              { noremap = true } },
                        { 'n', '<leader>rn', function() vim.lsp.buf.rename() end,                  { noremap = true } },
                        { 'i', '<C-h>',      function() vim.lsp.buf.signature_help() end,          { noremap = true, silent = true } },
                        { 'n', ']d',         function() vim.diagnostic.goto_next() end,            { noremap = true } },
                        { 'n', '[d',         function() vim.diagnostic.goto_prev() end,            { noremap = true } },
                        { 'n', 'gf',         function() vim.lsp.buf.format({ async = false }) end, { noremap = true, silent = true } }
                    }
                    for _, v in pairs(maps) do
                        v[4].buffer = event.buf
                        vim.keymap.set(v[1], v[2], v[3], v[4])
                    end
                end
            end
        end,
        desc = 'Language server protocol keyboard mappings',
    }
)

vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        local client = vim.lsp.start({
            name = 'rust-analyzer',
            cmd = { '/home/doctor/.cargo/bin/rust-analyzer' },
            root_dir = vim.fs.find({ 'Cargo.toml', 'Cargo.lock', '.git', }, { upward = true })[1]
        })
        if client ~= nil then
            vim.lsp.buf_attach_client(0, client)
        end
    end,
    desc = "Enable go LSP for rust files"
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        local client = vim.lsp.start({
            name = 'gopls',
            cmd = { 'gopls' },
            root_dir = vim.fs.find({ 'go.mod', 'go.work', '.git', }, { upward = true })[1]
        })
        if client ~= nil then
            vim.lsp.buf_attach_client(0, client)
        end
    end,
    desc = "Enable LSP for go files"
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        local client = vim.lsp.start({
            name = 'pyright',
            cmd = { 'pyright' },
            root_dir = vim.fs.find({ 'pyproject.toml', 'setup.py', '.git', 'src' }, { upward = true })[1]
        })
        if client ~= nil then
            vim.lsp.buf_attach_client(0, client)
        end
    end,
    desc = "Enable pyright LSP for python files"
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        local client = vim.lsp.start({
            name = 'clangd',
            cmd = { 'clangd' },
            root_dir = vim.fs.find({ 'Makefile', '.clang-format', '.git', }, { upward = true })[1]
        })
        if client ~= nil then
            vim.lsp.buf_attach_client(0, client)
        end
    end,
    desc = "Enable clangd LSP for c/c++ files"
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        local client = vim.lsp.start({
            name = 'lua-language-server',
            cmd = { 'lua-language-server' },
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    workspace = {
                        checkThirdParty = false,
                        library = { vim.env.VIMRUNTIME }
                    },
                }
            },
            root_dir = vim.fs.find( { 'init.lua', '.git', 'style.lua' }, { upward = true })[1]
        })
        if client ~= nil then
            vim.lsp.buf_attach_client(0, client)
        end
    end,
    desc = "Enable lua-language-server LSP for lua filetypes"
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.rs", "*.lua", "*.c", "*.h", "*.py" },
    callback = function()
        if vim.lsp.buf_is_attached(0, 1) then
            vim.lsp.buf.format()
        end
    end,
    desc = 'Synchronous format on save'
})

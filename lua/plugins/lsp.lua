require("mason").setup({
    max_concurrent_installers = 2,
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local handlers = {
   function (server_name)
       require("lspconfig")[server_name].setup {}
   end,

   ["rust_analyzer"] = function ()
       require("rust-tools").setup {}
   end,

   ["lua_ls"] = function ()
       local lspconfig = require("lspconfig")
       lspconfig.lua_ls.setup {
           settings = {
               Lua = {
                   diagnostics = {
                       globals = { "vim" }
                   }
               }
           }
       }
   end,

   ["hls"] = function()
       require("lspconfig")['hls'].setup {
           filetypes = { 'haskell', 'lhaskell', 'cabal' }
       }
   end,
}

require("mason-lspconfig").setup({
    handlers = handlers,
    automatic_installation = true
})

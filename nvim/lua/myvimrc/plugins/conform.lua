return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>cf',
            function()
                require('conform').format({ async = true, lsp_fallback = true })
            end,
            mode = '',
            desc = 'Format buffer',
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { 'stylua' },
        },
        -- Set up format-on-save
        format_on_save = {
            lsp_fallback = true,
            timeout_ms = 500,
        },
    },
    init = function()
        vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}

return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- 'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    opts = {
        window = {
            mappings = {
                ['P'] = { 'toggle_preview', config = { use_float = false, use_image_nvim = true } },
                ['l'] = { 'focus_preview' },
                ['<C-b>'] = { 'scroll_preview', config = { direction = 10 } },
                ['<C-f>'] = { 'scroll_preview', config = { direction = -10 } },
            }
        }
    },
    -- nnoremap [vimfiler] <Nop>
    -- nmap <Space>f [vimfiler]

    -- nnoremap <silent> [vimfiler]v :<C-u>VimFiler<CR>
    -- nnoremap <silent> [vimfiler]b :<C-u>VimFilerBufferDir<CR>
    -- nnoremap <silent> [vimfiler]d :<C-u>VimFilerDouble<CR>
    -- nnoremap <silent> [vimfiler]e :<C-u>VimFilerExplorer -winwidth=25<CR>
    -- nnoremap <silent> [vimfiler]f :<C-u>VimFilerExplorer -find -winwidth=25<CR>
    -- nnoremap <silent> [vimfiler]t :<C-u>VimFilerTab<CR>
}

-- Prerequite:
-- * Nerd fonts: https://www.nerdfonts.com/#home
--   * 0xProto Nerd Font

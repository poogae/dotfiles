-- _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
--    _       _ _     _
--   (_)_ __ (_) |_  | |_   _  __ _
--   | | '_ \| | __| | | | | |/ _` |
--   | | | | | | |_ _| | |_| | (_| |
--   |_|_| |_|_|\__(_)_|\__,_|\__,_|
--
-- _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

local config_module = "myvimrc"

-- Set user-defined environs
vim.env.MYVIMHOME = vim.fs.dirname(vim.fs.normalize(vim.env.MYVIMRC))
vim.env.MYVIMMODULE = config_module

require(config_module)

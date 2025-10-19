local M = {}

-- state
local term_buf = nil
local term_win = nil

-- default config
local config = {
    height = 10, -- height of the terminal
    filetype = "avl-terminal", -- filetype of the buffer, can be used to disable lualine etc.
    set_keymaps = false, -- whether or not to execute `set_keymaps` function
}

M.toggle = function()
    if term_win and vim.api.nvim_win_is_valid(term_win) then
        -- close if window is there
        vim.api.nvim_win_close(term_win, true)
        term_win = nil
        return
    end

    -- if no window, create
    vim.cmd(config.height .. "split")
    term_win = vim.api.nvim_get_current_win()

    if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
        -- create buffer for terminal
        term_buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_win_set_buf(term_win, term_buf)
        vim.cmd("term")

        -- set filetype
        vim.bo[term_buf].filetype = config.filetype
    end

    vim.api.nvim_win_set_buf(term_win, term_buf)
end

M.discard = function()
    -- delete buffer
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
        vim.api.nvim_buf_delete(term_buf, { force = true })
    end

    -- close window
    if term_win and vim.api.nvim_win_is_valid(term_win) then
        vim.api.nvim_win_close(term_win, true)
    end
end

local set_keymaps = function()
    vim.keymap.set("n", "<leader>tt", M.toggle, { noremap = true, silent = true, desc = "Toggle Terminal" }) -- <leader>tt to toggle terminal
    vim.keymap.set("n", "<leader>tx", M.discard, { noremap = true, silent = true, desc = "Discard Terminal" }) -- <leader>tt to toggle terminal
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true }) -- escape terminal mode with Esc
end

M.setup = function(opts)
    config = vim.tbl_extend("force", config, opts or {})

    -- usercommands
    -- - ToggleTerm -> toggles terminal
    -- - DiscardTerm -> completely shuts down terminal
    vim.api.nvim_create_user_command("ToggleTerm", M.toggle, {})
    vim.api.nvim_create_user_command("DiscardTerm", M.discard, {})

    if config.set_keymaps then
        set_keymaps()
    end
end

return M

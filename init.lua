require("config.lazy")

-- IMPORTANT KEYMAPS [You can go to :help lsp]
-- [[
-- For completion
-- CTRL+X CTRL+O (old way)
-- CTRL+X CTRL+L -- complete a line that is already written in the same buffer
-- ----
-- FOR GO TO DEF
-- CTR+] and go back CTRL+t
-- FOR SHOWING REFERENCES
-- grr
-- FOR RENAME ALL - MUST BE AT THE WORD
-- grn
-- FOR CODE ACTION
-- gra

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true
vim.opt.wrap = false
-- vim.opt.scrolloff = 10
-- vim.opt.guicursor = "" -- this will make it block instead of beam for the cursor, removing this line, will bring it back to beam.


-- vim.cmd [[hi @function.builtin guifg=yellow]]
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
-- vim.keymap.set("n", "<space>ee", "<cmd>e .<CR>")
vim.keymap.set("n", "<space>ee", "<cmd>Oil<CR>")
-- vim.keymap.set("n", "<space>p", function() vim.lsp.buf.format() end) -- check lsp.lua --> Below
-- Made it to format the code when saving a file.

-- Cancel anything highlighted
vim.keymap.set("n", "<space>cc", "<cmd>noh<CR>")

-- Showing all buffers running in the background
vim.keymap.set("n", "<space>tb", "<cmd>Telescope buffers<CR>", { silent = true, noremap = true })

-- Start presenting an md file.
vim.keymap.set("n", "<space>ps", "<cmd>Slides<CR>", { silent = true, noremap = true })

-- Moving text up down left right
vim.keymap.set("x", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("x", ">", ">gv", { noremap = true, silent = true })
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("n", "<space>st", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 10)
end)

-- For quick fix
vim.keymap.set("n", ">", "<cmd>cnext<CR>")
vim.keymap.set("n", "<", "<cmd>cprev<CR>")
vim.keymap.set("n", "<space>qf", "<cmd>copen<CR>")

-- Code Action can solve problems quick.
vim.keymap.set("n", "<space>ca", function()
	vim.lsp.buf.code_action()
end)

-- Heighlight where copied
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yannk', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})


-- This basically executes when opening the terminal -- Similar to an event.
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

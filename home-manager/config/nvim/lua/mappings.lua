require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("i", "jj", "<ESC>")
map("n", "<leader>a", "ggVG", { desc = "Select all" })
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlight" })

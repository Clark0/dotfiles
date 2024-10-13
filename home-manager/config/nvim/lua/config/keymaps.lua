-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("i", "jj", "<ESC>")

-- Delete a word backwards
map("n", "dw", "diw")

-- Select all
map("n", "<leader>a", "ggVG")

-- Move selected lines with J or K
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Buffer
map("n", "<tab>", ":bnext<CR>", opts)
map("n", "<s-tab>", ":bprev<CR>", opts)

map("n", "<leader>b1", "BufferLineGoToBuffer 1<CR>")
map("n", "<leader>b2", "BufferLineGoToBuffer 2<CR>")
map("n", "<leader>b3", "BufferLineGoToBuffer 3<CR>")
map("n", "<leader>b4", "BufferLineGoToBuffer 4<CR>")
map("n", "<leader>b5", "BufferLineGoToBuffer 5<CR>")
map("n", "<leader>b6", "BufferLineGoToBuffer 6<CR>")
map("n", "<leader>b9", "BufferLineGoToBuffer -1<CR>")

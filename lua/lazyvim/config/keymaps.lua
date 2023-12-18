-- This file is automatically loaded by lazyvim.config.init
local Util = require("lazyvim.util")

-- DO NOT USE THIS IN YOU OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = Util.safe_keymap_set

-- Remap space as leader key
-- Modes: Normal, Visual, Select, Operator-pending
-- <Nop>: do nothing (useful in mappings)
-- noremap("", "<space>", "<nop>")

map("i", "jk", "<esc>")

-- Clear search with <esc>
map({ "n", "i" }, "<esc>", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>")

-- Reload configuration without restart nvim
map("n", "<leader>r", ":so %<CR>")

-- Better delete one character using "x"
map({ "n", "v" }, "x", '"_x')

-- Enable backspace to delete selected area
map("x", "<BS>", '"_d')

-- Better paste
map("x", "p", '"_dP')

-- Copy to system clippboard
map({ "n", "x" }, "<leader>y", '"+y')

-- better up/down
-- map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
-- map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
-- map(NORMAL_MODE, "<C-h>", "<C-w>h")
-- map(NORMAL_MODE, "<C-j>", "<C-w>j")
-- map(NORMAL_MODE, "<C-k>", "<C-w>k")
-- map(NORMAL_MODE, "<C-l>", "<C-w>l")

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { remap = true })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { remap = true })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { remap = true })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { remap = true })

-- buffers
-- if Utils.has("bufferline.nvim") then
--   map(NORMAL_MODE, "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>")
--   map(NORMAL_MODE, "<Tab>", "<cmd>BufferLineCycleNext<cr>")
-- else
--   map(NORMAL_MODE, "<S-Tab>", "<cmd>bprevious<cr>")
--   map(NORMAL_MODE, "<Tab>", "<cmd>bnext<cr>")
-- end

-- map({ NORMAL_MODE, VISUAL_MODE }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- next search result
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })


map("n", "<leader>w", "<cmd>w<cr>", { remap = true })
map("n", "<leader>q", "<cmd>q<cr>", { remap = true })

-- better indenting
map("x", "<", "<gv", { remap = true })
map("x", ">", ">gv", { remap = true })

-- move lines
map("x", "J", ":m '>+1<cr>gv=gv", { remap = true })
map("x", "K", ":m '<-2<cr>gv=gv", { remap = true })

-- toggle options
--map(NORMAL_MODE, "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
--map(NORMAL_MODE, "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
--map(NORMAL_MODE, "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
--map(NORMAL_MODE, "<leader>ul", function() Util.toggle("relativenumber", true) Util.toggle("number") end, { desc = "Toggle Line Numbers" })
--map(NORMAL_MODE, "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
--local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
--map(NORMAL_MODE, "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })

-- map("m", "<leader>m", ":Format<CR>")
map({ "n", "v" }, "<leader>m", function()
  Util.format({ force = true })
end)

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { remap = true })
end

map("n", "<leader>l", "<cmd>Lazy<cr>")

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader><s-d>", function() Util.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

map("n", "<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
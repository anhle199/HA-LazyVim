-- This file is automatically loaded by lazyvim.config.init
local Util = require("lazyvim.util")

-- DO NOT USE THIS IN YOU OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = Util.safe_keymap_set

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- formatting
map({ "n", "v" }, "<leader>cf", function()
  Util.format({ force = true })
end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- stylua: ignore start

-- toggle options
map("n", "<leader>uf", function() Util.format.toggle() end, { desc = "Toggle auto format (global)" })
map("n", "<leader>uF", function() Util.format.toggle(true) end, { desc = "Toggle auto format (buffer)" })
map("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>uL", function() Util.toggle("relativenumber") end, { desc = "Toggle Relative Line Numbers" })
map("n", "<leader>ul", function() Util.toggle.number() end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", function() Util.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
  map( "n", "<leader>uh", function() Util.toggle.inlay_hints() end, { desc = "Toggle Inlay Hints" })
end
map("n", "<leader>uT", function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end, { desc = "Toggle Treesitter Highlight" })

-- lazygit
map("n", "<leader>gg", function() Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function() Util.terminal({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- LazyVim Changelog
map("n", "<leader>L", function() Util.news.changelog() end, { desc = "LazyVim Changelog" })

-- floating terminal
local lazyterm = function() Util.terminal(nil, { cwd = Util.root() }) end
map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function() Util.terminal() end, { desc = "Terminal (cwd)" })
map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })


-- local Utils = require("core.utils")
-- local map = Utils.map
-- local noremap = Utils.noremap
-- local exprmap = Utils.exprmap

-- local Constants = require("core.constants")
-- local NORMAL_MODE = Constants.VIM_MODES.NORMAL
-- local INSERT_MODE = Constants.VIM_MODES.INSERT
-- local VISUAL_MODE = Constants.VIM_MODES.VISUAL
-- local VISUAL_SELECT_MODE = Constants.VIM_MODES.VISUAL_SELECT

-- -- Remap space as leader key
-- -- Modes: Normal, Visual, Select, Operator-pending
-- -- <Nop>: do nothing (useful in mappings)
-- -- noremap("", "<space>", "<nop>")

-- noremap(INSERT_MODE, "jk", "<esc>")

-- -- Clear search with <esc>
-- map({ NORMAL_MODE, INSERT_MODE }, "<esc>", "<cmd>noh<cr><esc>")

-- -- Reload configuration without restart nvim
-- noremap(NORMAL_MODE, "<leader>r", ":so %<CR>")

-- -- Better delete one character using "x"
-- noremap(NORMAL_MODE, VISUAL_MODE, '"_x')

-- -- Enable backspace to delete selected area
-- noremap(VISUAL_SELECT_MODE, "<BS>", '"_d')

-- -- Better paste
-- noremap(VISUAL_SELECT_MODE, "p", '"_dP')

-- -- Copy to system clippboard
-- noremap({ NORMAL_MODE, VISUAL_SELECT_MODE }, "<leader>y", '"+y')

-- -- better up/down
-- exprmap(NORMAL_MODE, "j", "v:count == 0 ? 'gj' : 'j'")
-- exprmap(NORMAL_MODE, "k", "v:count == 0 ? 'gk' : 'k'")

-- -- Move to window using the <ctrl> hjkl keys
-- -- map(NORMAL_MODE, "<C-h>", "<C-w>h")
-- -- map(NORMAL_MODE, "<C-j>", "<C-w>j")
-- -- map(NORMAL_MODE, "<C-k>", "<C-w>k")
-- -- map(NORMAL_MODE, "<C-l>", "<C-w>l")

-- -- Resize window using <ctrl> arrow keys
-- map(NORMAL_MODE, "<C-Up>", "<cmd>resize +2<cr>")
-- map(NORMAL_MODE, "<C-Down>", "<cmd>resize -2<cr>")
-- map(NORMAL_MODE, "<C-Left>", "<cmd>vertical resize -2<cr>")
-- map(NORMAL_MODE, "<C-Right>", "<cmd>vertical resize +2<cr>")

-- -- buffers
-- -- if Utils.has("bufferline.nvim") then
-- --   map(NORMAL_MODE, "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>")
-- --   map(NORMAL_MODE, "<Tab>", "<cmd>BufferLineCycleNext<cr>")
-- -- else
-- --   map(NORMAL_MODE, "<S-Tab>", "<cmd>bprevious<cr>")
-- --   map(NORMAL_MODE, "<Tab>", "<cmd>bnext<cr>")
-- -- end

-- -- map({ NORMAL_MODE, VISUAL_MODE }, "gw", "*N", { desc = "Search word under cursor" })

-- -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- -- next search result
-- exprmap({ NORMAL_MODE, VISUAL_MODE, "o" }, "n", "'Nn'[v:searchforward]")
-- exprmap({ NORMAL_MODE, VISUAL_MODE, "o" }, "N", "'nN'[v:searchforward]")

-- map(NORMAL_MODE, "<leader>w", "<cmd>w<cr>")
-- map(NORMAL_MODE, "<leader>q", "<cmd>q<cr>")

-- -- better indenting
-- map(VISUAL_SELECT_MODE, "<", "<gv")
-- map(VISUAL_SELECT_MODE, ">", ">gv")

-- -- move lines
-- map(VISUAL_SELECT_MODE, "J", ":m '>+1<cr>gv=gv")
-- map(VISUAL_SELECT_MODE, "K", ":m '<-2<cr>gv=gv")

-- -- toggle options
-- --map(NORMAL_MODE, "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
-- --map(NORMAL_MODE, "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
-- --map(NORMAL_MODE, "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
-- --map(NORMAL_MODE, "<leader>ul", function() Util.toggle("relativenumber", true) Util.toggle("number") end, { desc = "Toggle Line Numbers" })
-- --map(NORMAL_MODE, "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
-- --local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
-- --map(NORMAL_MODE, "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })

-- noremap(NORMAL_MODE, "<leader>m", ":Format<CR>")

-- -- highlights under cursor
-- if vim.fn.has("nvim-0.9.0") == 1 then
--   map(NORMAL_MODE, "<leader>ui", vim.show_pos)
-- end

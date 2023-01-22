-- Keybindings, but care because they have been loaded before plugins
local M = {}

-- Shorten function name
local keymap = vim.keymap.set

function M.setup()
  -- Silent keymap option
  local opts = { silent = true }

  --Remap space as leader key
  keymap("", "<Space>", "<Nop>", opts)
  vim.g.mapleader = " "

  -- Modes
  --   normal_mode = "n",
  --   insert_mode = "i",
  --   visual_mode = "v",
  --   visual_block_mode = "x",
  --   term_mode = "t",
  --   command_mode = "c",

  -- Normal --
  -- Better window navigation
  keymap("n", "<C-h>", "<C-w>h", opts)
  keymap("n", "<C-j>", "<C-w>j", opts)
  keymap("n", "<C-k>", "<C-w>k", opts)
  keymap("n", "<C-l>", "<C-w>l", opts)

  -- Better insert mode navigation
  keymap("i", "<C-h>", "<Left>", opts)
  keymap("i", "<C-j>", "<Down>", opts)
  keymap("i", "<C-k>", "<Up>", opts)
  keymap("i", "<C-l>", "<Right>", opts)

  -- Better window creation
  keymap("n", "<leader>wv", "<C-w>v", opts)
  keymap("n", "<leader>ws", "<C-w>s", opts)
  keymap("n", "<leader>wc", "<C-w>c", opts)
  keymap("n", "<leader>wo", "<C-w>o", opts)

  -- Resize with arrows
  keymap("n", "<C-Up>", ":resize -2<CR>", opts)
  keymap("n", "<C-Down>", ":resize +2<CR>", opts)
  keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
  keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

  -- Navigate buffers
  keymap("n", "<S-l>", ":bnext<CR>", opts)
  keymap("n", "<S-h>", ":bprevious<CR>", opts)

  -- Clear highlights
  keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

  -- Close buffers
  keymap("n", "<S-x>", "<cmd>Bdelete!<CR>", opts)

  -- Navigate tabs
  keymap("n", "<A-l>", ":tabnext<CR>", opts)
  keymap("n", "<A-h>", ":tabprevious<CR>", opts)

  keymap("n", "<A-o>", ":tabnew<CR>", opts)

  -- Close tabs
  keymap("n", "<A-x>", ":tabclose<CR>", opts)

  -- Better paste
  keymap("v", "p", '"_dP', opts)

  -- Visual --
  -- Stay in indent mode
  keymap("v", "<", "<gv", opts)
  keymap("v", ">", ">gv", opts)

  -- Plugins --

  -- Change theme
  keymap("n", "<leader><leader>", "<cmd>lua require('base.colorscheme').next_theme()<CR>")

  -- NvimTree
  keymap("n", "<leader>et", ":NvimTreeToggle<CR>", opts)
  keymap("n", "<leader>ee", ":NvimTreeFocus<CR>", opts)

  -- Telescope
  keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
  keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
  keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
  keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

  -- Git
  keymap("n", "<leader>gg", "<cmd>lua require('base.toggleterm').start_lazygit()<CR>", opts)

  -- Comment
  keymap("n", "<leader>cc", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
  keymap("x", "<leader>cc", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

  -- DAP
  keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
  keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
  keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)

  keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
  keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
  keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
  keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
  keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
  keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

  -- Lsp
  keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)

  -- Term
  keymap("n", "<C-t>", "<cmd>ToggleTerm direction=float<cr>", opts)
  keymap("n", "<leader>to", "<cmd>ToggleTerm size=20 direction=horizontal<cr>", opts)
  keymap("n", "<leader>tt", "<cmd>ToggleTermToggleAll<cr>", opts)

  -- need something to exit from terminal
  keymap("t", "<esc>", [[<C-\><C-n>]], opts)
  keymap("t", "<esc><esc>", [[<C-\><C-n><C-w>c]], opts)
  keymap("t", "<esc>2", [[<C-\><C-n><cmd>2ToggleTerm<cr>]], opts)
  keymap("t", "<esc>3", [[<C-\><C-n><cmd>3ToggleTerm<cr>]], opts)
  keymap("t", "<esc>c", [[<C-\><C-n><cmd>ToggleTermToggleAll<cr>]], opts)
  keymap("t", "<c-h>", [[<C-\><C-n><C-W>h]], opts)
  keymap("t", "<c-l>", [[<C-\><C-n><C-W>l]], opts)

  -- General out
  keymap("n", "<leader>xx", ":qall!<cr>", opts)
  keymap("n", "<leader>ww", "<cmd>w!<cr>", opts)
  keymap("n", "<leader>wa", "<cmd>wa!<cr>", opts)
  keymap("n", "<leader>xa", "<cmd>xa!<cr>", opts)
  keymap("n", "<leader>xx", "<cmd>qall!<cr>", opts)
end

---Setup HTTP rest keybindings
function M.rest_keymaps()
  keymap("n", "<leader>hh", "<cmd>lua require('rest-nvim').run()<CR>", {})
end

return M
